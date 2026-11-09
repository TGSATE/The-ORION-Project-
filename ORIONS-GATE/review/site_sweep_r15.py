#!/usr/bin/env python3
"""Whole-site sweep of www.tgsate.com (Google Sites) for R15·L1.

Breadth-first over every same-site page reachable from the home page and
from the seed pages given on the command line.  For each page it records the
HTTP status, title, depth, the page that linked to it, and every outbound
link.  Then every outbound (off-site) link is checked once for its status.

Usage: python3 review/site_sweep_r15.py OUTDIR [SEED_URL ...]
Writes OUTDIR/site_pages.json, OUTDIR/outbound_status.json.
"""
import html, json, os, re, sys, time, urllib.parse, urllib.request, urllib.error
from collections import deque
from concurrent.futures import ThreadPoolExecutor

UA = {"user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 Chrome/124 Safari/537.36"}
HOST = "www.tgsate.com"
HREF_RE = re.compile(r'href="([^"]+)"')
ASSET_RE = re.compile(r"\.(css|js|png|jpe?g|gif|svg|webp|ico|woff2?|ttf|mp4|mp3|zip|pdf|json|xml)(\?|$)", re.I)


def get(url, timeout=40, tries=3):
    err = None
    for i in range(tries):
        try:
            req = urllib.request.Request(url, headers=UA)
            with urllib.request.urlopen(req, timeout=timeout) as r:
                return r.status, r.geturl(), r.read(20_000_000).decode("utf-8", "replace")
        except urllib.error.HTTPError as e:
            return e.code, url, ""
        except Exception as e:  # noqa: BLE001
            err = e
            time.sleep(2 * (i + 1))
    return None, url, f"__error__ {err}"


def unwrap(u):
    """Google Sites wraps outbound links in google.com/url?q=..."""
    p = urllib.parse.urlparse(u)
    if p.netloc.endswith("google.com") and p.path == "/url":
        q = urllib.parse.parse_qs(p.query).get("q")
        if q:
            return q[0]
    return u


def norm(u, base):
    u = html.unescape(u).strip()
    if u.startswith(("mailto:", "tel:", "javascript:", "#")):
        return None
    u = unwrap(urllib.parse.urljoin(base, u))
    u, _ = urllib.parse.urldefrag(u)
    return u


def same_site(u):
    p = urllib.parse.urlparse(u)
    return p.netloc in (HOST, "tgsate.com") and not ASSET_RE.search(p.path)


def canon(u):
    p = urllib.parse.urlparse(u)
    return f"https://{HOST}{p.path.rstrip('/') or '/'}"


def title_of(body):
    m = re.search(r"<title>(.*?)</title>", body, re.S)
    return html.unescape(m.group(1)).strip() if m else ""


def main():
    out = sys.argv[1]
    os.makedirs(out, exist_ok=True)
    seeds = [f"https://{HOST}/"] + sys.argv[2:]
    pages, q = {}, deque()
    for s in seeds:
        c = canon(s)
        if c not in pages:
            pages[c] = {"depth": 0, "parent": None}
            q.append(c)
    while q:
        u = q.popleft()
        st, final, body = get(u)
        rec = pages[u]
        rec.update(status=st, final=final, title=title_of(body) if st == 200 else "")
        links = []
        if st == 200:
            for h in HREF_RE.findall(body):
                n = norm(h, u)
                if not n or not n.startswith("http"):
                    continue
                if urllib.parse.urlparse(n).netloc in ("www.gstatic.com", "fonts.googleapis.com", "accounts.google.com", "sites.google.com", "www.google.com", "support.google.com", "policies.google.com"):
                    continue
                links.append(n)
        rec["links"] = sorted(set(links))
        for n in rec["links"]:
            if same_site(n):
                c = canon(n)
                if c not in pages:
                    pages[c] = {"depth": rec["depth"] + 1, "parent": u}
                    q.append(c)
        print(len(pages), st, u, file=sys.stderr)
        time.sleep(0.2)
    json.dump(pages, open(os.path.join(out, "site_pages.json"), "w"), indent=1)

    outbound = sorted({l for p in pages.values() for l in p.get("links", []) if not same_site(l)})

    def check(l):
        st, final, body = get(l, timeout=25, tries=2)
        return l, {"status": st, "final": final, "title": title_of(body)[:120] if st == 200 else ""}

    with ThreadPoolExecutor(12) as ex:
        res = dict(ex.map(check, outbound))
    json.dump(res, open(os.path.join(out, "outbound_status.json"), "w"), indent=1)


if __name__ == "__main__":
    main()
