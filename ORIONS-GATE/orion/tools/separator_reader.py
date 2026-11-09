#!/usr/bin/env python3
"""Separator reader: shows how Aristotle reads Beth's separators in a Doc.

How to run (from the project folder), on a plain-text export of a Google Doc
(File -> Download -> Plain text):

    python3 orion/tools/separator_reader.py my_doc.txt

It prints every separator it finds (line number, kind, round.level) and then the
one-line header that opens each readout:

    Coming from 18.1 -> porting to 18.2

The rules (same as RequestProject/R18/Level1Checks.lean):
  * a separator line is a run of 🌀 plus a round label like OR18 or OR18.1
    (umbrella labels from ☂️1.2 on: ☂️1.3, UM1.3 and ☂️2 read the same way);
    (old forms OR17.Lv5 and OR17L5 are read too);
      - ⏭️ on the line          -> "next": the next level/round starts here
      - 🧿 on the line          -> "exam": the readout-examination section
      - otherwise              -> "spiral": a level starts here
  * ⏬ row ... 🆙 row          -> the parking block (your "I'm working here" space);
                                 skipped, never read as instructions.
                                 NEW at 19.1: a ⏬ row with no 🆙 after it (before the
                                 end line) is NOT a parking block: nothing is skipped.
                                 (At 19.1 the arrows opened your spiral and never closed,
                                 and the old reader hid 64 lines of it.)
  * a line of 9 💎             -> "final audit": no further changes
  * END LINE: exactly ☢️☢️☢️🧿☢️☢️☢️ (new, soft: "nothing left to see here"),
    or exactly nine ☢️ (old) -> stop; nothing after it is read.
    A line that merely *contains* ☢️ next to other text is NOT a stop.
  * NEW at 19.1: if there is a 🧿 readout-examination separator, "coming from" is
    its level and "porting to" is the first separator after it (OR19.2 -> 19.2;
    ⏭️OR20 -> 20.1); with nothing after it, the next level number.
  * NEW at 19.3: a line that is just "ARI🧿" (or "ARI:🧿", "ARI 🧿") right under a
    🌀 separator turns that separator into a 🧿 exam line ("Ari, examine here").
    (At 19.3 the Doc had `OR19.3💎` and then `ARI🧿` on its own line.)
  * NEW at 19.3: a ⏭️ separator whose next non-blank line starts with "Indicates"
    is a legend line (the key), not a real round change: it is skipped.
    (At 19.3: `18🌀…⏭️OR19💎` + "Indicates ROUND is finished…".)
  * Otherwise: "coming from" = the last spiral level before the end line;
    "porting to"  = the level after it, unless a later ⏭️ separator names the
    next round, in which case that wins.
"""
import re
import sys

VS = "\ufe0f"
END_SOFT = "☢️☢️☢️🧿☢️☢️☢️".replace(VS, "")
END_OLD = ("☢️" * 9).replace(VS, "")
LABEL = re.compile(r"(?:OR|UM|☂)\s*(\d+)(?:\s*[.\s]?\s*(?:Lv|L)?\s*🌀?\s*(\d+))?")


def norm(s: str) -> str:
    return s.replace(VS, "").replace("\ufeff", "").strip()


def classify(line: str):
    s = norm(line)
    if s in (END_SOFT, END_OLD):
        return ("end", None)
    if s and set(s) == {"💎"} and len(s) == 9:
        return ("final", None)
    if s and set(s) == {"⏬"}:
        return ("park_open", None)
    if s and set(s) == {"🆙"}:
        return ("park_close", None)
    if "🌀" in s or "⏭" in s:
        m = LABEL.search(s)
        rest = LABEL.sub("", s)
        # a separator is mostly emoji: no ordinary words besides the label
        if m and not re.search(r"[A-Za-z]{3,}", rest):
            r = int(m.group(1))
            lv = int(m.group(2)) if m.group(2) else None
            kind = "next" if "⏭" in s else ("exam" if "🧿" in s else "spiral")
            return (kind, (r, lv))
    return ("text", None)


def closes_before_end(kinds, i):
    """Is there a 🆙 row after position i, before any end line?"""
    for k in kinds[i + 1:]:
        if k == "end":
            return False
        if k == "park_close":
            return True
    return False


ARI_EYE = re.compile(r"^ARI\s*:?\s*🧿$")


def next_nonblank(lines, i):
    for j in range(i + 1, len(lines)):
        if norm(lines[j]):
            return norm(lines[j])
    return ""


def read(lines):
    seps, parked, end_at = [], 0, None
    in_park = False
    kinds = [classify(line)[0] for line in lines]
    for n, line in enumerate(lines, 1):
        kind, lab = classify(line)
        if kind in ("spiral", "next", "exam"):
            after = next_nonblank(lines, n - 1)
            if kind == "spiral" and ARI_EYE.match(after):
                kind = "exam"
            elif kind == "next" and after.lower().startswith("indicates"):
                kind = "legend"
        if kind == "end":
            end_at = n
            seps.append((n, "end", None))
            break
        if kind == "park_open":
            if closes_before_end(kinds, n - 1):
                in_park = True
                seps.append((n, "park_open", None))
            else:
                seps.append((n, "park_open_unclosed", None))
            continue
        if kind == "park_close":
            in_park = False
            seps.append((n, "park_close", None))
            continue
        if in_park:
            parked += 1
            continue
        if kind == "legend":
            seps.append((n, "legend", lab))
            continue
        if kind != "text":
            seps.append((n, kind, lab))
    return seps, parked, end_at


def fmt(lab):
    if lab is None:
        return ""
    r, lv = lab
    return f"{r}.{lv}" if lv is not None else f"{r}"


def header(seps):
    exams = [i for i, (_, k, lab) in enumerate(seps) if k == "exam" and lab and lab[1] is not None]
    if exams:
        i = exams[-1]
        coming = seps[i][2]
        for _, k, lab in seps[i + 1:]:
            if k in ("spiral", "exam") and lab and lab[1] is not None:
                return coming, lab
            if k == "next" and lab:
                return coming, (lab if lab[1] is not None else (lab[0], 1))
        return coming, (coming[0], coming[1] + 1)
    levels = [lab for _, k, lab in seps if k in ("spiral", "exam") and lab and lab[1] is not None]
    coming = levels[-1] if levels else None
    port = (coming[0], coming[1] + 1) if coming else None
    last_next = None
    for i, (_, k, lab) in enumerate(seps):
        if k == "next" and lab:
            last_next = (i, lab)
    if last_next:
        idx, lab = last_next
        later_levels = [s for s in seps[idx + 1:] if s[1] in ("spiral", "exam")]
        if not later_levels:
            port = lab if lab[1] is not None else (lab[0], 1)
    return coming, port


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)
    lines = open(sys.argv[1], encoding="utf-8", errors="ignore").read().splitlines()
    seps, parked, end_at = read(lines)
    for n, k, lab in seps:
        note = "  (no 🆙 after it: not a parking block, nothing skipped)" if k == "park_open_unclosed" else ""
        if k == "legend":
            note = "  (legend line: the key, not a real round change)"
        print(f"line {n:>5}  {k:<11} {fmt(lab)}{note}")
    if parked:
        print(f"(parking block: {parked} lines skipped)")
    print("END LINE at line %d: nothing after it is read." % end_at if end_at else "No end line: everything is read.")
    coming, port = header(seps)
    print(f"\nComing from {fmt(coming) or '?'} -> porting to {fmt(port) or '?'}")


if __name__ == "__main__":
    main()
