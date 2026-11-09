#!/usr/bin/env python3
"""Recursive, multi-source link crawler for the ORION document tree.

Starting from one or more URLs, this follows every nested link breadth-first,
with no depth limit other than ``MAX_DEPTH`` (default 60), until no new
document remains.  It records the depth at which each document was first
reached and the parent that led to it, so the longest chain ("the last link in
the nest") can be reconstructed.

Document handlers (content is read and its links are followed):
  * Notion pages  - every block, with pagination (reuses notion_deep_crawl.py)
  * Grok shared conversations - every message via the public share endpoint;
    links typed or pasted by the human participant are followed; links that
    only appear in the assistant's own answers or search citations are
    recorded, not followed
  * Google Docs   - plain-text export; every URL in the text is followed
  * Websites on the project's own hosts (tgsate.com, tgsate.blogspot.com,
    the ORION *.pages.dev / *.grok.me / *.oneapp.dev sites) - HTML text and
    same-site page links
  * GitHub user TGSATE - repository list and every README

Everything else (X, YouTube, TikTok, Facebook, app stores, arbitrary third
party sites, files) is a *leaf*: fetched once for status/title, not expanded.

Usage:  python3 review/deep_link_crawl.py OUTDIR URL [URL ...]
"""
import html, json, os, re, sys, time, urllib.parse, urllib.request, urllib.error
from collections import deque

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import notion_deep_crawl as nd  # noqa: E402

MAX_DEPTH = 60
PER_HOST_CAP = 400
URL_RE = re.compile(r"https?://[^\s<>\"'`\)\]\}\|\\]+")
UA = {"user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 Chrome/124 Safari/537.36"}

SITE_HOSTS = ("tgsate.com", "www.tgsate.com", "tgsate.blogspot.com", "farqueen.com", "www.farqueen.com")
SITE_SUFFIXES = (".pages.dev", ".grok.me", ".oneapp.dev")
ASSET_RE = re.compile(r"\.(css|js|png|jpe?g|gif|svg|webp|ico|woff2?|ttf|mp4|mp3|zip|pdf|json|xml)(\?|$)", re.I)


def get(url, binary=False, timeout=40, tries=3):
    err = None
    for i in range(tries):
        try:
            req = urllib.request.Request(url, headers=UA)
            with urllib.request.urlopen(req, timeout=timeout) as r:
                body = r.read(80_000_000)
                return r.status, r.geturl(), (body if binary else body.decode("utf-8", "replace"))
        except urllib.error.HTTPError as e:
            return e.code, url, ""
        except Exception as e:  # noqa: BLE001
            err = e
            time.sleep(2 * (i + 1))
    return None, url, f"__error__ {err}"


def clean_url(u):
    u = html.unescape(u).strip().rstrip(".,;:!?*_'\"")
    while u.endswith(")") and u.count("(") < u.count(")"):
        u = u[:-1]
    if u.startswith("https://www.google.com/url?"):
        q = urllib.parse.parse_qs(urllib.parse.urlparse(u).query).get("q")
        if q:
            u = q[0]
    return u


def key_of(url):
    """Canonical identity for de-duplication."""
    nid = nd.notion_id_from_url(url)
    if nid:
        return "notion:" + nid
    m = re.search(r"grok\.com/share/([A-Za-z0-9_\-]+)", url)
    if m:
        return "grok:" + m.group(1)
    m = re.search(r"docs\.google\.com/(document|spreadsheets|presentation)/d/([A-Za-z0-9_\-]+)", url)
    if m:
        return f"gdoc:{m.group(1)}:{m.group(2)}"
    p = urllib.parse.urlparse(url)
    host = p.netloc.lower()
    path = p.path.rstrip("/") or "/"
    if host in SITE_HOSTS or host.endswith(SITE_SUFFIXES):
        return f"web:{host}{path}"
    if host == "github.com" and path.lower().startswith("/tgsate"):
        return "github:" + path.lower()
    return "leaf:" + url.split("#")[0]


def kind_of(key):
    return key.split(":", 1)[0]


# ---------------------------------------------------------------- handlers

def h_notion(url, key):
    pid = key.split(":", 1)[1]
    blocks, colls, views, err = nd.load_page(pid)
    root = blocks.get(pid)
    if root is None:
        return {"accessible": False, "error": err, "meta": nd.page_meta(pid)}, "", [], []
    if root.get("type") not in ("page", "collection_view_page"):
        par = root.get("parent_id")
        return ({"accessible": True, "note": f"block inside page {par}"}, "",
                [f"https://www.notion.so/{par.replace('-', '')}"] if par else [], [])
    title = nd.rich_text((root.get("properties") or {}).get("title"))[0]
    lines, links, refs, files = nd.walk(pid, blocks, colls, views)
    follow = list(links) + [f"https://www.notion.so/{nd.norm_id(r).replace('-', '')}" for r in refs if nd.norm_id(r)]
    info = {"accessible": True, "title": title, "version": root.get("version"),
            "last_edited_time": root.get("last_edited_time"), "n_blocks": len(blocks), "attachments": files}
    return info, "\n".join(lines), follow, []


def h_grok(url, key):
    sid = key.split(":", 1)[1]
    st, _, body = get(f"https://grok.com/rest/app-chat/share_links/{sid}")
    try:
        d = json.loads(body)
    except Exception:  # noqa: BLE001
        return {"accessible": False, "status": st}, "", [], []
    resp = sorted(d.get("responses", []), key=lambda r: r.get("createTime") or "")
    title = (d.get("conversation") or {}).get("title")
    out, follow, recorded = [], [], []
    for r in resp:
        who = (r.get("sender") or "").lower()
        msg = r.get("message") or ""
        out.append(f"\n----- [{who}] {r.get('createTime', '')} -----\n{msg}")
        urls = [clean_url(u) for u in URL_RE.findall(msg)]
        if who == "human":
            follow.extend(urls)
        else:
            recorded.extend(urls)
    info = {"accessible": True, "title": title, "n_messages": len(resp),
            "n_human": sum(1 for r in resp if (r.get("sender") or "").lower() == "human")}
    return info, "\n".join(out), follow, recorded


def h_gdoc(url, key):
    _, typ, did = key.split(":")
    fmt = {"document": "txt", "spreadsheets": "csv", "presentation": "txt"}[typ]
    st, final, body = get(f"https://docs.google.com/{typ}/d/{did}/export?format={fmt}")
    if st != 200 or body.lstrip().startswith("<!DOCTYPE html") or body.startswith("__error__"):
        return {"accessible": False, "status": st}, "", [], []
    title = body.strip().splitlines()[0].lstrip("\ufeff")[:120] if body.strip() else ""
    follow = [clean_url(u) for u in URL_RE.findall(body)]
    # also pull hyperlinks hidden behind link text from the HTML export
    st2, _, hb = get(f"https://docs.google.com/{typ}/d/{did}/export?format=html")
    if st2 == 200:
        follow += [clean_url(u) for u in re.findall(r'href="(https?://[^"]+)"', hb)]
    return {"accessible": True, "title": title, "chars": len(body)}, body, follow, []


def html_text(body):
    body = re.sub(r"(?is)<(script|style|noscript|svg)[^>]*>.*?</\1>", " ", body)
    body = re.sub(r"(?i)<br\s*/?>|</(p|div|h[1-6]|li|tr)>", "\n", body)
    txt = html.unescape(re.sub(r"<[^>]+>", " ", body))
    return "\n".join(l.strip() for l in txt.splitlines() if l.strip())


def h_web(url, key):
    st, final, body = get(url)
    if st != 200 or body.startswith("__error__"):
        return {"accessible": False, "status": st}, "", [], []
    m = re.search(r"<title[^>]*>(.*?)</title>", body, re.S | re.I)
    title = html.unescape(m.group(1)).strip() if m else ""
    host = urllib.parse.urlparse(final).netloc.lower()
    follow, recorded = [], []
    for href in re.findall(r'href=["\']([^"\'#][^"\']*)["\']', body, re.I):
        u = clean_url(urllib.parse.urljoin(final, href))
        if not u.startswith("http") or ASSET_RE.search(u):
            continue
        h = urllib.parse.urlparse(u).netloc.lower()
        if "blogspot.com" in host:
            # only follow actual posts and pages of the blog, not archive/search/feed views
            if h == host and not re.search(r"/\d{4}/\d{2}/[^/]+\.html$|/p/[^/]+\.html$", urllib.parse.urlparse(u).path):
                continue
            if any(x in u for x in ("blogger.com", "?updated-max", "?m=", "/search", "feeds/")):
                continue
        if h == host or key_of(u).split(":")[0] in ("notion", "grok", "gdoc", "github"):
            follow.append(u)
        else:
            recorded.append(u)
    # bare URLs in text
    text = html_text(body)
    for u in URL_RE.findall(text):
        follow.append(clean_url(u))
    return {"accessible": True, "title": title, "status": st, "final_url": final}, text, follow, recorded


def h_github(url, key):
    path = key.split(":", 1)[1].strip("/").split("/")
    user = path[0]
    texts, follow = [], []
    if len(path) == 1:
        st, _, body = get(f"https://api.github.com/users/{user}/repos?per_page=100")
        try:
            repos = json.loads(body)
        except Exception:  # noqa: BLE001
            return {"accessible": False, "status": st}, "", [], []
        for r in repos:
            texts.append(f"- {r['full_name']}: {r.get('description') or ''} (updated {r.get('updated_at')})")
            follow.append(r["html_url"])
            if r.get("homepage"):
                follow.append(r["homepage"])
        return {"accessible": True, "title": f"GitHub {user}", "n_repos": len(repos)}, "\n".join(texts), follow, []
    repo = path[1]
    st, _, body = get(f"https://api.github.com/repos/{user}/{repo}/readme",)
    try:
        d = json.loads(body)
        import base64
        readme = base64.b64decode(d.get("content", "")).decode("utf-8", "replace")
    except Exception:  # noqa: BLE001
        readme = ""
    st2, _, tree = get(f"https://api.github.com/repos/{user}/{repo}/git/trees/HEAD?recursive=1")
    files = []
    try:
        files = [t["path"] for t in json.loads(tree).get("tree", []) if t.get("type") == "blob"]
    except Exception:  # noqa: BLE001
        pass
    follow = [clean_url(u) for u in URL_RE.findall(readme)]
    text = readme + "\n\n## files\n" + "\n".join(files[:2000])
    return {"accessible": bool(readme or files), "title": f"{user}/{repo}", "n_files": len(files)}, text, follow, []


HANDLERS = {"notion": h_notion, "grok": h_grok, "gdoc": h_gdoc, "web": h_web, "github": h_github}


def fetch_leaf(url):
    info = {}
    st, final, body = get(url, timeout=25, tries=1)
    info["status"], info["final_url"] = st, final
    if isinstance(body, str) and body and not body.startswith("__error__"):
        m = re.search(r"<title[^>]*>(.*?)</title>", body, re.S | re.I)
        if m:
            info["title"] = html.unescape(m.group(1)).strip()[:200]
        m = re.search(r'<meta[^>]+(?:property="og:description"|name="description")[^>]+content="([^"]*)"', body, re.I)
        if m:
            info["description"] = html.unescape(m.group(1)).strip()[:400]
    elif isinstance(body, str) and body.startswith("__error__"):
        info["error"] = body[10:200]
    return info


def slug(key):
    return re.sub(r"[^A-Za-z0-9_.-]+", "_", key)[:90]


def main():
    outdir = sys.argv[1]
    os.makedirs(os.path.join(outdir, "nodes"), exist_ok=True)
    q = deque()
    for u in sys.argv[2:]:
        q.append((u, 0, None))
    nodes, edges, leaves, host_count = {}, [], {}, {}
    while q:
        url, depth, parent = q.popleft()
        k = key_of(url)
        if parent is not None:
            edges.append([parent, k])
        if k in nodes or (kind_of(k) == "leaf" and k in leaves):
            continue
        if kind_of(k) == "leaf":
            leaves[k] = {"url": url, "depth": depth, "parent": parent}
            continue
        if depth > MAX_DEPTH:
            nodes[k] = {"url": url, "depth": depth, "parent": parent, "skipped": "max depth"}
            continue
        host = urllib.parse.urlparse(url).netloc.lower()
        host_count[host] = host_count.get(host, 0) + 1
        if kind_of(k) == "web" and host_count[host] > PER_HOST_CAP:
            nodes[k] = {"url": url, "depth": depth, "parent": parent, "skipped": "per-host cap"}
            continue
        try:
            info, text, follow, recorded = HANDLERS[kind_of(k)](url, k)
        except Exception as e:  # noqa: BLE001
            info, text, follow, recorded = {"accessible": False, "error": repr(e)[:300]}, "", [], []
        follow = list(dict.fromkeys(f for f in follow if f.startswith("http") and "${" not in f))
        child_keys = []
        for f in follow:
            ck = key_of(f)
            if ck != k:
                child_keys.append(ck)
                q.append((f, depth + 1, k))
        info.update({"url": url, "depth": depth, "parent": parent,
                     "children": list(dict.fromkeys(child_keys)),
                     "recorded_not_followed": list(dict.fromkeys(recorded))[:500]})
        nodes[k] = info
        if text:
            with open(os.path.join(outdir, "nodes", f"{depth:02d}_{slug(k)}.md"), "w") as fh:
                fh.write(f"# {info.get('title') or k}\n\n- source: {url}\n- key: {k}\n- depth: {depth}\n"
                         f"- reached from: {parent}\n\n{text}\n")
        print(f"d{depth} {k} acc={info.get('accessible')} '{(info.get('title') or '')[:50]}' "
              f"follow={len(child_keys)} rec={len(recorded)}", flush=True)
        json.dump({"nodes": nodes, "edges": edges, "leaves": leaves}, open(os.path.join(outdir, "crawl.partial.json"), "w"))
    print("documents:", len(nodes), "leaves:", len(leaves), flush=True)
    for k, v in leaves.items():
        v.update(fetch_leaf(v["url"]))
    json.dump({"start": sys.argv[2:], "nodes": nodes, "edges": edges, "leaves": leaves},
              open(os.path.join(outdir, "crawl.json"), "w"), indent=1, ensure_ascii=False)
    print("done; max depth", max(v["depth"] for v in nodes.values()), flush=True)


if __name__ == "__main__":
    main()
