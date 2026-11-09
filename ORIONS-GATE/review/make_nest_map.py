#!/usr/bin/env python3
"""Turn a crawl.json from deep_link_crawl.py into a readable Markdown nest map."""
import json, sys, collections

src, out = sys.argv[1], sys.argv[2]
d = json.load(open(src))
nodes, leaves = d["nodes"], d["leaves"]


def label(k, v):
    t = (v.get("title") or "").replace("|", "/").strip()
    return t[:80] if t else "—"


def status(v):
    if v.get("accessible"):
        return "read"
    meta = v.get("meta") or {}
    if meta.get("isDeleted"):
        return "**deleted in Notion**"
    if v.get("status"):
        return f"HTTP {v['status']}"
    return "not readable"


lines = ["# Nest map — every document reached from ORION R11", "",
         f"Start: {', '.join(d.get('start', []))}", "",
         "Depth = the fewest clicks from the R11 page. Documents are read and their links followed; "
         "*leaves* (social posts, videos, app listings, third-party articles, files) were fetched once "
         "for status and title but not expanded.", ""]
by = collections.Counter(v["depth"] for v in nodes.values())
ok = collections.Counter(v["depth"] for v in nodes.values() if v.get("accessible"))
lines += ["| Depth | Documents reached | Readable |", "|---|---|---|"]
for dep in sorted(by):
    lines.append(f"| {dep} | {by[dep]} | {ok[dep]} |")
lines += ["", f"Leaves recorded: {len(leaves)}", ""]
for dep in sorted(by):
    lines += [f"## Depth {dep}", "", "| Document | Kind | Status | Reached from |", "|---|---|---|---|"]
    rows = sorted(((k, v) for k, v in nodes.items() if v["depth"] == dep), key=lambda kv: kv[0])
    for k, v in rows:
        kind = k.split(":")[0]
        par = v.get("parent") or "—"
        lines.append(f"| {label(k, v)} <br>`{v['url'][:110]}` | {kind} | {status(v)} | `{par[:60]}` |")
    lines.append("")
lines += ["## Leaves (not expanded)", "", "| URL | Depth | HTTP | Title |", "|---|---|---|---|"]
for k, v in sorted(leaves.items(), key=lambda kv: (kv[1]["depth"], kv[0])):
    lines.append(f"| `{v['url'][:120]}` | {v['depth']} | {v.get('status')} | {(v.get('title') or '').replace('|', '/')[:70]} |")
open(out, "w").write("\n".join(lines) + "\n")
