#!/usr/bin/env python3
"""Round-by-round watch list for the collaborators' public code repositories.

Usage:  python3 review/repo_watch.py OUT.tsv [PREVIOUS.tsv] [--days N]

For each collaborator account below it lists the public repositories pushed in
the last N days (default 30), newest first, and records each one's current head
commit using `git ls-remote` (no download).  If a previous snapshot is given, it
prints which repositories are new, changed (different head commit) or unchanged.
It only reads public pages; it never signs in and never writes to GitHub.
"""
import json, subprocess, sys, urllib.request, datetime, csv

ACCOUNTS = {            # GitHub account -> ORION member (from the project roster)
    "TGSATE": "Beth",
    "enuminous": "Matthew",
    "meta-introspector": "Mike (introsp3ctor)",
    "the-far-queen": "Bobby (far queen)",
}

def api(url):
    req = urllib.request.Request(url, headers={"User-Agent": "orion-repo-watch",
                                               "Accept": "application/vnd.github+json"})
    return json.load(urllib.request.urlopen(req, timeout=60))

def head(full_name, branch):
    try:
        out = subprocess.run(["git", "ls-remote", f"https://github.com/{full_name}.git",
                              f"refs/heads/{branch}"], capture_output=True, text=True,
                             timeout=60).stdout.split()
        return out[0] if out else ""
    except Exception:
        return ""

def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    days = 30
    if "--days" in sys.argv:
        days = int(sys.argv[sys.argv.index("--days") + 1]); args = [a for a in args if a != str(days)]
    out_path = args[0]; prev_path = args[1] if len(args) > 1 else None
    cutoff = datetime.datetime.utcnow() - datetime.timedelta(days=days)
    rows = []
    for acct, member in ACCOUNTS.items():
        page = 1
        while True:
            repos = api(f"https://api.github.com/users/{acct}/repos?per_page=100&sort=pushed&page={page}")
            if not repos:
                break
            stop = False
            for r in repos:
                pushed = datetime.datetime.strptime(r["pushed_at"], "%Y-%m-%dT%H:%M:%SZ")
                if pushed < cutoff:
                    stop = True; break
                own = not r["fork"]
                rows.append({"account": acct, "member": member, "repo": r["name"],
                             "own_or_fork": "own" if own else "fork",
                             "pushed_at": r["pushed_at"], "language": r["language"] or "",
                             "size_kb": r["size"], "branch": r["default_branch"],
                             "head": head(r["full_name"], r["default_branch"]) if own else "",
                             "description": (r["description"] or "").replace("\t", " ")[:120]})
            if stop or len(repos) < 100:
                break
            page += 1
    with open(out_path, "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0].keys()), delimiter="\t")
        w.writeheader(); w.writerows(rows)
    print(f"{len(rows)} repositories pushed in the last {days} days written to {out_path}")
    if prev_path:
        prev = {(r["account"], r["repo"]): r for r in csv.DictReader(open(prev_path), delimiter="\t")}
        for r in rows:
            p = prev.get((r["account"], r["repo"]))
            if p is None:
                print("NEW      ", r["account"], r["repo"])
            elif r["own_or_fork"] == "own" and p.get("head") != r["head"]:
                print("CHANGED  ", r["account"], r["repo"], p.get("head", "")[:8], "->", r["head"][:8])

if __name__ == "__main__":
    main()
