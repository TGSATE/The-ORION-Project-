"""Regenerate ORION_LINE_BY_LINE_INDEX.md: the line number of every section heading
in the main rule files. Run from the project root: python3 review/line_index.py"""
import re
FILES = [("ORION_GAME_MANUAL.md", 'The exhaustive game manual (the "MMO manual")'),
         ("ORION_SUMMARY_CURRENT.md", "The project summary (current state)"),
         ("DIAMOND_RULES.md", "Every 💎-locked rule, round by round"),
         ("CONTRADICTIONS_REGISTER.md", "Every open question, sections A–R"),
         ("ORION_BUILD_GLOSSARY.md", "The glossary (what each word means)")]
out = ["# ORION line-by-line index 📜", "",
       "*Round 20, 7 October 2026. You asked to see the current state line by line instead of summaries. These five files **are** the line-by-line current state. This page tells you what is on which line, so you can jump straight there. Line numbers are the file's own lines (most text editors and GitHub show them on the left).*", "",
       "**How to open them:** download this project from the Aristotle website, or with the Aristotle command-line tool (instructions: https://aristotle.harmonic.fun/docs/installation). Unzip it, then open any `.md` file in a text editor, VS Code, or by dragging it into GitHub. They are plain text, so nothing needs installing to read them.", ""]
for f, desc in FILES:
    lines = open(f, encoding="utf-8").read().split("\n")
    n = len(lines) - (1 if lines[-1] == "" else 0)
    out += [f"## `{f}`: {desc} ({n} lines)", "", "| Line | Section |", "|---|---|"]
    for i, l in enumerate(lines, 1):
        m = re.match(r"^(#{1,3})\s+(.*)", l)
        if m:
            t = m.group(2).replace("|", "\\|")
            out.append(f"| {i} | {'  ' * (len(m.group(1)) - 1)}{t} |")
    out.append("")
out += ["---", "", "*This index is regenerated each round. If a line number is off by a little, the file was edited after the index was made; search for the section title instead.*"]
open("ORION_LINE_BY_LINE_INDEX.md", "w", encoding="utf-8").write("\n".join(out) + "\n")
