#!/usr/bin/env python3
"""Grab the public GitHub code of every ORION team account in one go.

Usage (on any computer with git and Python 3):
    python3 grab_team_code.py [destination-folder] [--since YYYY-MM-DD]

For each account below it lists the public repositories, records the newest
commit of every non-fork repository in LEDGER.tsv, and downloads (shallow
clone, newest version only) every repository pushed on or after --since.
Nothing is uploaded, posted or changed on GitHub. Without a GitHub token the
API allows about 60 listing requests per hour, which is enough for one run.
"""
import json, os, subprocess, sys, urllib.request

ACCOUNTS = {  # account -> who (as named in Beth's Doc)
    "meta-introspector": "Mike",
    "jmikedupont2": "Mike (personal account)",
    "enuminous": "Matthew",
    "the-far-queen": "Bobby",
    "ryansctt1994-sudo": "Ryan",
    "TGSATE": "Beth",
    "humancodex": "found entity (not Mike)",
}
EXTRA_FORKS = {  # forks Beth asked for by name
    "jmikedupont2": ["WaterSheet.lean", "UPT-Meta", "Hpof", "MillenniumClock", "UPT", "3-is-magic", "One"],
    "humancodex": ["i-have-adhd"],
}
MAX_MB = 150

def repos(user):
    out, page = [], 1
    while page <= 10:
        url = f"https://api.github.com/users/{user}/repos?per_page=100&page={page}&sort=pushed"
        req = urllib.request.Request(url, headers={"User-Agent": "orion-grab"})
        tok = os.environ.get("GITHUB_TOKEN")
        if tok:
            req.add_header("Authorization", f"Bearer {tok}")
        batch = json.load(urllib.request.urlopen(req))
        if not batch:
            break
        out += batch
        page += 1
    return out

def head(url):
    r = subprocess.run(["git", "ls-remote", url, "HEAD"], capture_output=True, text=True, timeout=60)
    return r.stdout.split()[0] if r.stdout.strip() else "unavailable"

def main():
    args = sys.argv[1:]
    since = "2026-09-01"
    if "--since" in args:
        i = args.index("--since"); since = args[i + 1]; del args[i:i + 2]
    dest = args[0] if args else "orion_team_code"
    os.makedirs(dest, exist_ok=True)
    rows = []
    for user, who in ACCOUNTS.items():
        try:
            lst = repos(user)
        except Exception as e:
            rows.append([who, user, "(listing failed)", "", "", "", "", str(e)[:60]]); continue
        for r in lst:
            wanted = (not r["fork"]) or r["name"] in EXTRA_FORKS.get(user, [])
            if not wanted:
                continue
            url = r["clone_url"]; mb = r["size"] / 1024
            status = "listed"
            if r["pushed_at"][:10] >= since and mb <= MAX_MB:
                target = os.path.join(dest, user, r["name"])
                if not os.path.isdir(target):
                    c = subprocess.run(["git", "clone", "-q", "--depth", "1", url, target],
                                       capture_output=True, text=True, timeout=600)
                    status = "downloaded" if c.returncode == 0 else "clone failed"
                else:
                    status = "already here"
            elif mb > MAX_MB:
                status = f"listed (over {MAX_MB} MB, skipped)"
            rows.append([who, user, r["name"], "fork" if r["fork"] else "own",
                         r["pushed_at"][:10], r.get("language") or "", head(url)[:12], status])
    with open(os.path.join(dest, "LEDGER.tsv"), "w") as f:
        f.write("who\taccount\trepo\town/fork\tlast_push\tlanguage\tcommit\tstatus\n")
        for row in rows:
            f.write("\t".join(map(str, row)) + "\n")
    print(f"{len(rows)} repositories recorded in {dest}/LEDGER.tsv")

if __name__ == "__main__":
    main()
