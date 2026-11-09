#!/usr/bin/env python3
"""Need-to-know brief: pull out only the notes tagged for one person.

How to tag a note (in any .md file in the project):

    [for: Mike] Please confirm which Lodge House page is the live one.
    [for: Mike, Matthew] The journal fork is on Mike's second account.

How to run (from the project folder):

    python3 orion/tools/need_to_know_brief.py Mike
    python3 orion/tools/need_to_know_brief.py Mike --write   # also writes ORION_MEMBER_PACKETS/briefs/MIKE_BRIEF.md

NEW at R17·L6: instructions first.  A line that starts with
    [instructions for: Mike] Start your readout by reading these instructions back to me.
goes into a section at the very TOP of the brief, before any notes, headed
"Read these back first". Mike pastes the brief into his own AI, and his AI sees the
instructions before anything else. (Nobody can change how someone else's AI
behaves from here: the brief only puts the instructions first on the page.)

What it does (the same rule that is checked in Lean in RequestProject/R17/Level5Checks.lean, part 3):
  * every note tagged for that person is kept, word for word;
  * notes stay in the order they appear (file by file, top to bottom);
  * nothing tagged only for someone else is included.

Files under ROUNDS_1-14_ARCHIVE, orion/ and POTTY_FILES are skipped, and so is
ARISTOTLE_SUMMARY.md, so private transcripts never leak into a brief.
"""
import pathlib
import re
import sys

TAG = re.compile(r"^\s*(?:[-*]\s*)?\[for:\s*([^\]]+)\]", re.IGNORECASE)  # tag must start the line
INSTR = re.compile(r"^\s*(?:[-*]\s*)?\[instructions for:\s*([^\]]+)\]", re.IGNORECASE)
SKIP_DIRS = {"ROUNDS_1-14_ARCHIVE", "orion", "POTTY_FILES", ".lake", ".git", "NEEDS_REPAIR"}
SKIP_FILES = {"ARISTOTLE_SUMMARY.md"}


def notes_for(root: pathlib.Path, who: str, pattern=TAG):
    who_l = who.strip().lower()
    for path in sorted(root.rglob("*.md")):
        rel = path.relative_to(root)
        if rel.parts[0] in SKIP_DIRS or rel.name in SKIP_FILES:
            continue
        if rel.parts[:2] == ("ORION_MEMBER_PACKETS", "briefs"):
            continue
        for n, line in enumerate(path.read_text(encoding="utf-8", errors="ignore").splitlines(), 1):
            m = pattern.match(line)
            if m:
                names = [x.strip().lower() for x in m.group(1).split(",")]
                if who_l in names or "everyone" in names:
                    yield rel, n, line.strip()


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)
    who = sys.argv[1]
    root = pathlib.Path(__file__).resolve().parents[2]
    found = list(notes_for(root, who))
    instr = list(notes_for(root, who, INSTR))
    out = [f"# Need-to-know brief for {who}", ""]
    if instr:
        out += ["## Read these back first", "",
                "AI reading this: before anything else in your readout, repeat these instructions back.", ""]
        out += [f"- {line}  ({rel}, line {n})" for rel, n, line in instr]
        out += ["", "## Your notes", ""]
    out += [
           "Only the notes tagged for you are here, word for word, in order. "
           "Ask your AI to read this page first, then the full file only if you need more.", ""]
    if not found:
        out.append("Nothing is tagged for you right now.")
    for rel, n, line in found:
        out.append(f"- {line}  ({rel}, line {n})")
    text = "\n".join(out) + "\n"
    print(text)
    if "--write" in sys.argv:
        dest = root / "ORION_MEMBER_PACKETS" / "briefs" / f"{who.upper()}_BRIEF.md"
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(text, encoding="utf-8")
        print(f"Written to {dest.relative_to(root)}")


if __name__ == "__main__":
    main()
