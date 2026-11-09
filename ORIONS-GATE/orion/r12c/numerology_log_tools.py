"""Exploratory tools for Beth's number log (ORION12>🌀11, third pass).

Reads the log section of GOOGLE_DOC_ORION12_THIRD_PASS.txt, removes every
parenthetical personal note, and writes a numbers-only copy plus summary counts.
These counts come from this script; they are exploratory, not a formal proof.
"""
import collections, json, re, sys, pathlib

HERE = pathlib.Path(__file__).parent
doc = (HERE / "GOOGLE_DOC_ORION12_THIRD_PASS.txt").read_text(encoding="utf-8-sig").replace("\r", "")
lines = doc.split("\n")
start = next(i for i, l in enumerate(lines) if l.startswith("11052024"))
end = next(i for i, l in enumerate(lines) if l.startswith("10062026"))
log = [l for l in lines[start:end + 1] if l.strip()]

DATE = re.compile(r"^\s*(\d{1,2})[./](\d{1,2}|xx)[./](\d{2,4})\s*(\([^)]*\))?\s*[:\-]?")
COMPACT = re.compile(r"^\s*(\d{2})(\d{2})(2026|26)\s*:?")

def norm_year(y):
    return 2000 + int(y) if len(y) == 2 else int(y)

rows, cur = [], None
markers = []
for l in log:
    m = DATE.match(l)
    c = COMPACT.match(l)
    if m:
        y = norm_year(m.group(3))
        cur = f"{y:04d}-{int(m.group(1)):02d}-{m.group(2) if m.group(2)=='xx' else int(m.group(2)):02}" if m.group(2) != "xx" else f"{y:04d}-{int(m.group(1)):02d}-xx"
        body = l[m.end():]
    elif c and l.split()[0].rstrip(":").isdigit() and len(l.split()[0].rstrip(":")) in (6, 8):
        y = norm_year(c.group(3))
        cur = f"{y:04d}-{c.group(1)}-{c.group(2)}"
        body = l[c.end():]
        if len(l.split()[0].rstrip(":")) == 8:
            markers.append(l.strip())
    else:
        body = l
    body = re.sub(r"\([^)]*\)", "", body)          # personal notes withheld
    body = re.sub(r"https?://\S+", "", body)
    toks = [t.replace(":", "") for t in re.findall(r"\d+(?::\d+)?", body)]
    if cur is None:
        markers.append(l.strip())
        continue
    rows.append((cur, toks, body.strip()))

by_date = collections.OrderedDict()
for d, toks, body in rows:
    by_date.setdefault(d, []).extend(toks)

def is_pal(t): return len(t) > 1 and t == t[::-1]
def is_rep(t): return len(t) > 1 and len(set(t)) == 1

all_toks = [t for ts in by_date.values() for t in ts]
cnt = collections.Counter(all_toks)
stats = {
    "dated_days": len(by_date),
    "numbers_logged": len(all_toks),
    "palindromes": sum(map(is_pal, all_toks)),
    "repdigits": sum(map(is_rep, all_toks)),
    "top_25": cnt.most_common(25),
    "count_144": cnt["144"],
    "first_144_dates": [d for d, ts in by_date.items() if "144" in ts][:12],
    "markers": markers,
}
week = [d for d in by_date if "2026-09-30" <= d <= "2026-10-06"]
stats["this_week"] = {d: by_date[d] for d in week}

if __name__ == "__main__":
    out = HERE / "NUMEROLOGY_LOG_NUMBERS_ONLY.txt"
    with out.open("w", encoding="utf-8") as f:
        f.write("# Beth's number log, numbers only (personal notes in parentheses removed)\n")
        for d, ts in by_date.items():
            f.write(f"{d}: {' '.join(ts)}\n")
    (HERE / "NUMEROLOGY_LOG_STATS.json").write_text(json.dumps(stats, indent=1, ensure_ascii=False), encoding="utf-8")
    print(json.dumps({k: v for k, v in stats.items() if k != 'this_week'}, ensure_ascii=False)[:3000])
    print(json.dumps(stats["this_week"]))
