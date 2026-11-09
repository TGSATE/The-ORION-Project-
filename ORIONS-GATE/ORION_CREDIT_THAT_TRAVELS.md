# Credit that travels with the work 🛡️

*Round 21, 7 October 2026. You asked (doc line 421): "is there any way at all to add metadata that forces anybody who utilizes this code to at the very least attach the current contributors list that cannot be scrubbed from the metadata… I want to protect everybody."*

## 1. The straight answer

**No. Metadata can't be made unscrubbable.**
- Metadata means the hidden information inside a file: a photo's details, a document's "properties", comments in code.
- Anyone who has a copy of a file can edit or delete any of it with free tools.
- Removing location data from your photos works the same way, just in the other direction.

So the protection has to come from things that are **public, dated and visible**, not hidden inside the file.

## 2. What actually protects people (in order of effort)

| # | What | Why it helps | Effort |
|---|---|---|---|
| 1 | **A `CONTRIBUTORS.md` file** at the top of your GitHub repo | It's the first thing anyone copying the project sees, and copies usually carry it along. **A draft is ready:** `orion/r21/github_ready/CONTRIBUTORS.md`. Check the names first | 5 minutes |
| 2 | **GitHub's history** | Every change saved to GitHub (a "commit") records **who** and **when**, publicly. Forks keep that history. Deleting a name later is itself a dated, visible change | Free, automatic |
| 3 | **A dated public post of the list** | After uploading the file, open it on GitHub, copy the link to that exact version (the **History** button, then the latest entry), and post it on X: "ORION contributors as of [date]". The link includes a long code that changes if the file changes, so the dated post shows exactly what the list said that day | 2 minutes each round |
| 4 | **Credits inside the game** | A credits screen and one line on the ORION Engine welcome page ("Built by the ORION team, see Contributors"). A copy that removes them looks like what it is | When the game is built |
| 5 | **The ledger** (`ORION_FOUNDERS_CREDIT_LEDGER.md`) | Your round-by-round record of who made and who shared what. It's already kept every round | Ongoing |

## 3. The legal side (not something I can advise on)

- Your screenshot (album **#1440**) shows your repo's **License: None**.
- Whether anyone is *required* to keep the contributors list, and what happens if they don't, depends on the **license** and any **contributor agreements** you choose.
- That is a legal decision. **Please ask a lawyer.** I can't recommend a license or interpret one.
- The steps in §2 work as a public record whatever you decide.

## 4. How to upload the contributors file (phone)

1. Open the GitHub app and go to **TGSATE / ORION-Engine-Platform-and-MMO**.
2. Tap **Code** (the row with the `</>` icon, under `main`).
3. Tap **+** (Add file), then **Create new file**. If the app doesn't offer it, open github.com in your phone's browser instead; it has **Add file → Create new file**.
4. Name it `CONTRIBUTORS.md`.
5. Paste the text from `orion/r21/github_ready/CONTRIBUTORS.md` (after your corrections).
6. Tap **Commit changes**.

## 5. Checked in Lean

The credit-list rule, "add this round's names, skip names already there", is modelled in `RequestProject/RoundTwentyOne/MorphChainAndTranslator.lean` §3. The computer confirmed:
- **No name is ever dropped** when a round is added.
- **Every new name gets listed.**
- **Nobody is listed twice.**

This checks the bookkeeping rule. It doesn't stop anyone from copying.
