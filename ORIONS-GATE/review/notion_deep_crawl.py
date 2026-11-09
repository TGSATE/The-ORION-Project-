#!/usr/bin/env python3
"""Recursive link crawler for the ORION Notion pages.

Starting from one or more Notion pages, this script reads every block of
every page (with pagination), extracts every link (inline text links, page
mentions, child pages, link-to-page / alias blocks, synced blocks, bookmarks,
embeds, files, images, database rows), and follows every Notion link it finds,
breadth-first, with no depth cap other than ``--max-depth`` (default 60), until
no new pages remain.  Non-Notion links are recorded as leaves; each one is
fetched once (HTTP status, final URL, <title>) but its own outgoing links are
*not* followed, so the crawl stays inside the shared document tree.

Usage:
    python3 review/notion_deep_crawl.py OUTDIR PAGE_ID [PAGE_ID ...]

Output (in OUTDIR):
    pages/<depth>_<id>.md   plain-text transcript of each Notion page reached
    crawl.json              machine-readable graph: pages, edges, leaves
"""
import json, re, sys, time, urllib.request, urllib.error, html
from collections import deque

API = "https://www.notion.so/api/v3/"
UUID_RE = re.compile(r"([0-9a-f]{8})-?([0-9a-f]{4})-?([0-9a-f]{4})-?([0-9a-f]{4})-?([0-9a-f]{12})", re.I)
NOTION_HOST_RE = re.compile(r"https?://([a-z0-9-]+\.)?notion\.(so|site|com)/", re.I)


def norm_id(s):
    m = UUID_RE.search(s)
    if not m:
        return None
    return "-".join(g.lower() for g in m.groups())


def notion_id_from_url(url):
    if not NOTION_HOST_RE.match(url):
        return None
    base, _, frag = url.partition("#")
    path = base.split("?")[0].rstrip("/")
    seg = path.split("/")[-1]
    m = re.search(r"([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})$", seg, re.I)
    if m:
        return m.group(1).lower()
    m = re.search(r"([0-9a-f]{32})$", seg.replace("-", ""), re.I)
    if m:
        return norm_id(m.group(1))
    q = re.search(r"[?&]p=([0-9a-f]{32})", base, re.I)  # peek-view links
    if q:
        return norm_id(q.group(1))
    return None


def page_meta(pid):
    d = post("getPublicPageData", {"type": "block-space", "name": "page", "blockId": pid,
                                   "showMoveTo": False, "saveParent": False, "shouldDuplicate": False,
                                   "projectManagementLaunch": False, "requestedOnPublicDomain": False,
                                   "configureOpenInDesktopApp": False, "mobileData": {"isPush": False}})
    return {k: d.get(k) for k in ("spaceName", "publicAccessRole", "isDeleted", "requireLogin", "__error__", "message")
            if k in d}


def post(endpoint, payload, tries=4):
    data = json.dumps(payload).encode()
    for i in range(tries):
        try:
            req = urllib.request.Request(API + endpoint, data=data,
                                         headers={"content-type": "application/json",
                                                  "user-agent": "Mozilla/5.0"})
            with urllib.request.urlopen(req, timeout=60) as r:
                return json.loads(r.read())
        except Exception as e:  # noqa: BLE001
            err = e
            time.sleep(2 * (i + 1))
    return {"__error__": str(err)}


def unwrap(rec):
    v = rec.get("value")
    while isinstance(v, dict) and "value" in v and isinstance(v["value"], dict) and "id" not in v:
        v = v["value"]
    if isinstance(v, dict) and "value" in v and isinstance(v["value"], dict) and "id" in v["value"]:
        v = v["value"]
    return v


def load_page(pid):
    blocks, collections, views = {}, {}, {}
    cursor, chunk, err = {"stack": []}, 0, None
    while True:
        d = post("loadPageChunk", {"pageId": pid, "limit": 100, "cursor": cursor,
                                   "chunkNumber": chunk, "verticalColumns": False})
        if "__error__" in d or "recordMap" not in d:
            err = d.get("__error__") or d.get("message") or "no recordMap"
            break
        rm = d["recordMap"]
        for k, rec in rm.get("block", {}).items():
            v = unwrap(rec)
            if v:
                blocks[k] = v
        for k, rec in rm.get("collection", {}).items():
            v = unwrap(rec)
            if v:
                collections[k] = v
        for k, rec in rm.get("collection_view", {}).items():
            v = unwrap(rec)
            if v:
                views[k] = v
        cursor = d.get("cursor") or {"stack": []}
        chunk += 1
        if not cursor.get("stack") or chunk > 60:
            break
    # fetch any referenced child blocks that were not delivered
    for _ in range(5):
        missing = set()
        for b in list(blocks.values()):
            if b.get("type") == "page" and b["id"] != pid:
                continue  # child pages are crawled as their own pages
            for c in b.get("content", []) or []:
                if c not in blocks:
                    missing.add(c)
        if not missing:
            break
        d = post("syncRecordValues", {"requests": [{"pointer": {"table": "block", "id": m}, "version": -1}
                                                   for m in list(missing)[:100]]})
        got = 0
        for k, rec in d.get("recordMap", {}).get("block", {}).items():
            v = unwrap(rec)
            if v:
                blocks[k] = v
                got += 1
        if not got:
            break
    return blocks, collections, views, err


def query_collection(coll_id, view_id, space_id):
    d = post("queryCollection", {
        "source": {"type": "collection", "id": coll_id, "spaceId": space_id},
        "collectionView": {"id": view_id, "spaceId": space_id},
        "loader": {"type": "reducer", "reducers": {"collection_group_results": {"type": "results", "limit": 500}},
                   "searchQuery": "", "userTimeZone": "UTC"}})
    ids = []
    try:
        ids = d["result"]["reducerResults"]["collection_group_results"]["blockIds"]
    except Exception:  # noqa: BLE001
        pass
    return ids


def rich_text(prop):
    """Return (plain text, [links], [page_mentions]) for a Notion rich-text array."""
    out, links, mentions = [], [], []
    for seg in prop or []:
        if not seg:
            continue
        txt = seg[0]
        anns = seg[1] if len(seg) > 1 else []
        for a in anns:
            if not a:
                continue
            if a[0] == "a" and len(a) > 1:
                links.append(a[1])
            elif a[0] == "p" and len(a) > 1:
                mentions.append(a[1])
            elif a[0] == "lm" and len(a) > 1 and isinstance(a[1], dict):
                if a[1].get("href"):
                    links.append(a[1]["href"])
        out.append(txt if txt != "\u2023" else "[mention]")
    return "".join(out), links, mentions


def walk(pid, blocks, collections, views):
    """Yield transcript lines and collect outgoing references for one page."""
    lines, links, pages, files = [], [], [], []
    seen = set()

    def visit(bid, depth):
        if bid in seen or bid not in blocks:
            return
        seen.add(bid)
        b = blocks[bid]
        t = b.get("type")
        props = b.get("properties", {}) or {}
        fmt = b.get("format", {}) or {}
        ind = "  " * depth
        txt, l, m = rich_text(props.get("title"))
        links.extend(l)
        pages.extend(m)
        for key, val in props.items():
            if key == "title":
                continue
            if isinstance(val, list):
                t2, l2, m2 = rich_text(val)
                links.extend(l2)
                pages.extend(m2)
        if t == "page" and bid != pid:
            pages.append(bid)
            lines.append(f"{ind}[child page: {txt} -> {bid}]")
            return
        if t in ("alias", "link_to_page"):
            ptr = (fmt.get("alias_pointer") or {}).get("id")
            if ptr:
                pages.append(ptr)
                lines.append(f"{ind}[link to page -> {ptr}]")
        if t == "transclusion_reference":
            ptr = (fmt.get("transclusion_reference_pointer") or {}).get("id")
            if ptr:
                pages.append(ptr)
                lines.append(f"{ind}[synced block -> {ptr}]")
        if t in ("bookmark", "embed", "video", "image", "file", "pdf", "audio", "figma", "gist",
                 "drive", "tweet", "codepen", "maps", "framer", "typeform", "loom", "excalidraw"):
            src = None
            if props.get("link"):
                src = rich_text(props["link"])[0]
            if not src and props.get("source"):
                src = rich_text(props["source"])[0]
            src = src or fmt.get("display_source")
            if src:
                if src.startswith("attachment:") or "secure.notion-static.com" in src or "prod-files-secure" in src:
                    files.append(src)
                else:
                    links.append(src)
                lines.append(f"{ind}[{t}: {txt or ''} {src}]")
            return
        if t in ("collection_view", "collection_view_page"):
            cid = b.get("collection_id") or (fmt.get("collection_pointer") or {}).get("id")
            lines.append(f"{ind}[database {cid}]")
            for vid in b.get("view_ids", []) or []:
                for rid in query_collection(cid, vid, b.get("space_id")):
                    pages.append(rid)
                    lines.append(f"{ind}  [database row -> {rid}]")
                break
            return
        if txt:
            prefix = {"to_do": "[ ] ", "bulleted_list": "- ", "numbered_list": "1. ",
                      "header": "# ", "sub_header": "## ", "sub_sub_header": "### ",
                      "quote": "> ", "callout": "! "}.get(t, "")
            lines.append(ind + prefix + txt)
        for c in b.get("content", []) or []:
            visit(c, depth + (0 if bid == pid else 1))

    visit(pid, 0)
    return lines, links, pages, files


def fetch_leaf(url):
    info = {"url": url}
    try:
        req = urllib.request.Request(url, headers={"user-agent": "Mozilla/5.0"})
        with urllib.request.urlopen(req, timeout=25) as r:
            info["status"] = r.status
            info["final_url"] = r.geturl()
            body = r.read(400000).decode("utf-8", "replace")
            m = re.search(r"<title[^>]*>(.*?)</title>", body, re.S | re.I)
            if m:
                info["title"] = html.unescape(m.group(1)).strip()[:200]
            m = re.search(r'<meta[^>]+(?:property="og:description"|name="description")[^>]+content="([^"]*)"', body, re.I)
            if m:
                info["description"] = html.unescape(m.group(1)).strip()[:400]
    except urllib.error.HTTPError as e:
        info["status"] = e.code
    except Exception as e:  # noqa: BLE001
        info["error"] = str(e)[:200]
    return info


def main():
    outdir = sys.argv[1]
    starts = [norm_id(s) for s in sys.argv[2:]]
    max_depth = 60
    import os
    os.makedirs(os.path.join(outdir, "pages"), exist_ok=True)
    q = deque((s, 0, None) for s in starts)
    visited, pages_out, edges, leaves = {}, {}, [], {}
    while q:
        pid, depth, parent = q.popleft()
        if pid in visited or depth > max_depth:
            continue
        visited[pid] = depth
        blocks, colls, views, err = load_page(pid)
        root = blocks.get(pid)
        if root is None:
            meta = page_meta(pid)
            pages_out[pid] = {"depth": depth, "parent": parent, "accessible": False, "error": err, "meta": meta}
            print(f"d{depth} {pid} INACCESSIBLE ({err}) {meta}", flush=True)
            continue
        # if the id was a block inside a page, climb to its page
        if root.get("type") not in ("page", "collection_view_page"):
            par = root.get("parent_id")
            pages_out[pid] = {"depth": depth, "parent": parent, "accessible": True,
                              "block_type": root.get("type"), "redirect_parent_page": par}
            if par:
                edges.append((pid, par, "block-in-page"))
                q.append((par, depth, pid))
            continue
        title = rich_text((root.get("properties") or {}).get("title"))[0]
        lines, links, refs, files = walk(pid, blocks, colls, views)
        child_ids = []
        for r in refs:
            r2 = norm_id(r)
            if r2 and r2 != pid:
                child_ids.append(r2)
        ext = []
        for u in links:
            nid = notion_id_from_url(u)
            if nid:
                if nid != pid:
                    child_ids.append(nid)
            else:
                ext.append(u)
        child_ids = list(dict.fromkeys(child_ids))
        ext = list(dict.fromkeys(ext))
        for c in child_ids:
            edges.append((pid, c, "notion"))
            if c not in visited:
                q.append((c, depth + 1, pid))
        for u in ext:
            edges.append((pid, u, "external"))
            leaves.setdefault(u, {"first_seen_on": pid, "depth": depth + 1})
        pages_out[pid] = {"depth": depth, "parent": parent, "accessible": True, "title": title,
                          "version": root.get("version"), "last_edited_time": root.get("last_edited_time"),
                          "n_blocks": len(blocks), "notion_children": child_ids, "external_links": ext,
                          "attachments": files}
        with open(os.path.join(outdir, "pages", f"{depth:02d}_{pid}.md"), "w") as f:
            f.write(f"# {title}\n\n- page id: {pid}\n- depth from start: {depth}\n- reached from: {parent}\n"
                    f"- version: {root.get('version')}  last edited (ms): {root.get('last_edited_time')}\n\n")
            f.write("\n".join(lines) + "\n")
        print(f"d{depth} {pid} '{title[:60]}' blocks={len(blocks)} notion={len(child_ids)} ext={len(ext)}", flush=True)
    for u, info in leaves.items():
        info.update(fetch_leaf(u))
    json.dump({"start": starts, "pages": pages_out, "edges": edges, "external": leaves},
              open(os.path.join(outdir, "crawl.json"), "w"), indent=1, ensure_ascii=False)
    print("pages visited:", len(pages_out), "max depth:", max(v["depth"] for v in pages_out.values()),
          "external:", len(leaves))


if __name__ == "__main__":
    main()
