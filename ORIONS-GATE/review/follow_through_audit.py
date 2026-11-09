"""Round 16 follow-through audit: check that every file or folder named in backticks in
ARISTOTLE_SUMMARY.md (one section per earlier run) exists somewhere in this project.
Run from the project root:  python3 review/follow_through_audit.py"""
import os, re
s = open('ARISTOTLE_SUMMARY.md', encoding='utf8').read()
runs = re.split(r'^# Summary of changes for run ', s, flags=re.M)[1:]
ext = r'(?:md|lean|txt|json|tsv|py|svg|png|patch|log|sha256|html|csv|toml)'
names = {}
for f in (os.path.join(dp, x) for dp, dn, fs in os.walk('.') if '.lake' not in dp and '/.git' not in dp for x in fs + dn):
    names.setdefault(os.path.basename(f), []).append(f)
total, missing = 0, []
for k, r in enumerate(runs):
    paths = set(re.findall(r'`([A-Za-z0-9_./\-]+\.' + ext + r')`', r)) | set(re.findall(r'`([A-Za-z0-9_./\-]+/)`', r))
    total += len(paths)
    for p in sorted(paths):
        if os.path.exists(p) or os.path.exists(p.lstrip('./')):
            continue
        hits = names.get(os.path.basename(p.rstrip('/')), [])
        missing.append((len(runs) - k, p, hits[:2]))
print(f'runs: {len(runs)}; backticked file/folder references: {total}')
print('not found at the literal path (run number counted from the oldest = 1):')
for m in missing:
    print('  run', m[0], m[1], '-> found at', m[2] if m[2] else 'NOWHERE in project')
