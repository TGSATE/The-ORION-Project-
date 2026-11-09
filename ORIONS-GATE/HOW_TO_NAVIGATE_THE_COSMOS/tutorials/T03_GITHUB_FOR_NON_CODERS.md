# T03. GitHub for non-coders, with Matthew's repo as practice 🐙

*Round 16, 7 October 2026. Beth: "Trying to figure out GitHub. Do I just copy this to you to read from each dev? How do I get their code from GitHub? [github.com/enuminous/EFMW-Axioms] 👈 Matthews for practice… tell me how to do this please."*

## The short answer

**Yes: just paste the GitHub link into your doc, exactly as you did.** If the repository is **public**, I can download and read the whole thing from the link alone. That's what I did with Matthew's (§4). You don't need to copy any code yourself.

If a link doesn't work for me, it's usually because the repository is **private**. Then either:
- ask the developer to make it public (if they're happy to), **or**
- ask them to click **Code → Download ZIP** and send you the ZIP file to upload, **or**
- they can add you as a collaborator (you'd need a free GitHub account), though I still couldn't open a private link myself.

## 1. What GitHub is

- **GitHub** is a website where people keep code and other files in **repositories** ("repos"). Think of a repo as a project folder that remembers every change ever made to it.
- Each saved change is a **commit**, with a note saying what changed, who changed it and when.
- People can copy a repo (**fork** or **clone**), work on their copy, and ask to merge their changes back (**pull request**).
- A link like `github.com/enuminous/EFMW-Axioms` means: account **enuminous** (Matthew), repository **EFMW-Axioms**.

## 2. Looking at a repo without coding

1. Open the link in a browser.
2. The **file list** is at the top; the **README** (the project's front page) is shown below it. Start there.
3. Click any file to read it. Click **commits** (a clock icon with a number) to see the history.
4. The green **Code** button → **Download ZIP** gives you a copy of everything.
5. **Star** (bookmark) or **Watch** (get notified of changes) if you have an account.

## 3. How the team can share code with ORION

**Simplest for now:** each developer pastes their repo links into the doc each round, with one line saying what it is and what they want checked. For example:
> Matthew: github.com/enuminous/EFMW-Axioms (the 12 axioms in Lean; please check it builds)

**Better soon (04, milestone M0):** create a free **GitHub organisation** called something like `orion-engine`, and put the shared ORION code in repos there. Everyone on the dev team gets access, and there's one place to look. Each developer can keep their own personal repos as well.

**Good habits to ask for:**
- a README that says what the repo is and how to run it;
- a licence file (Matthew's says CC BY 4.0);
- no passwords, keys or personal data in the code.

## 4. Practice run: Matthew's `EFMW-Axioms`

**What I did:** downloaded the public repository (latest change 6 October 2026, `a8119c4`), read every file, and built its Lean code with this project's tools. A snapshot is saved in `orion/r16/efmw_axioms_snapshot/`.

**What's in it (8 files):**

| File | What it is |
|---|---|
| `README.md` | Front page: a reconstruction of the 6 March 2025 EFMW axiom sheet, in three layers: historical claim, mathematical stand-in, and physical status |
| `PAPER.md`, `index.html` | The paper-style write-up and web page |
| `EFMWAxioms/Axioms.lean` | The 12 axioms and corollaries written as Lean structures, plus 12 small theorems |
| `EFMWAxioms/Main.lean` | Lists the 12 for display |
| `lakefile.toml`, `lean-toolchain` | Build settings (the same Lean and Mathlib versions as this project) |
| `.github/workflows/lean.yml` | Makes GitHub build it automatically and reject `sorry` on every change. Good practice |

**What I found:**
- ✅ **It builds cleanly** with no errors and no `sorry`. (The copy is `RequestProject/RoundSixteen/EFMWAxiomsUpstream.lean`, unchanged.)
- ✅ **It's honest about what it proves.** Its own rule: "Lean can prove consequences of an assumption. It cannot prove that nature satisfies the assumption."
- 🟡 **Ten of the twelve theorems just repeat the assumption they're named after** (A1, A2, A4, A5, A6, C7, C8, C9, C10, C11). Only A3 and C12 combine assumptions into something new. That's fine for a first version, but it means the repo shows that the twelve ideas *can be written down precisely*, not that anything follows from them yet.
- **Three things I added and proved** (`RequestProject/RoundSixteen/EFMWAxiomsReview.lean`):
  1. **All twelve can hold at once.** I built one example that satisfies them all, so they don't contradict each other. (The example is very simple: mostly constant functions. That also shows how weak the assumptions are.)
  2. **A4 (scale invariance) is stronger than it looks:** it forces the "strength" to be one fixed value for all positive inputs and one for all negative inputs.
  3. **A6 (causal entanglement) carries no information as written:** a relation that holds between *every* pair of points is just "always true".
- **Ideas for Matthew's next version** (suggestions only): state a consequence that uses two or more axioms together; make A6 say something about *which* points are entangled; add a short "status" line per axiom in the Lean comments to match the README's three layers.

## 5. Your next practice steps

1. Open `github.com/enuminous/EFMW-Axioms` and find the README, then `EFMWAxioms/Axioms.lean`.
2. Click the commit history and read the latest note.
3. Make a free GitHub account if you'd like to star or watch repos.
4. Next round, paste one link from each developer with a one-line "what to check". I'll do the same for each.

## Round 23: doing it on an iPhone, step by step

**Goal: get files you approve from this project's downloads into a GitHub repository for the team.** First, choose a *small, safe test file* (for example a new file containing only the words `ORION upload test`), not your entire download folder: the folder contains private images, birth details, and an old Git history containing sensitive metadata. A public repository is visible to everyone. If you need a complete project transfer, have a teammate prepare a **reviewed, sanitized export with a new history**, then check the list of files together before publishing. I cannot connect your accounts or upload on your behalf.

1. On iPhone, open **Files** (blue folder icon; swipe down on the Home screen and search **Files**). Tap **Browse**, then check **Downloads** under both **On My iPhone** and **iCloud Drive**, plus any **Google Drive** location shown. In Drive, also search **Recent**, **Shared with me** and the first eight characters of the long download code. If you saw a file only during an upload, it may be in Drive or a temporary picker: in Files, use the search bar; in the upload screen, tap **Browse** to see the current folder's path. Don't delete anything until its first line identifies it.
2. Use `FILE_NAME_FINDER.md`: the long code identifies the **round**, not necessarily the file. Open one mystery file (Files → tap; for text, try **Share → Open in…** if needed). Its first line gives its title. Add `R23` (or the appropriate round) before the filename using **long-press → Rename**. If the file is a download you cannot open, share it to Drive or ask Mike to identify it before deleting it.
3. Go to [github.com](https://github.com) in Safari and sign in to **your** account. Open your destination repo. Do not use Mike's repo unless he has explicitly added you and said which branch to use. A **new private repo** is a safer place to practice; later choose what to make public.
4. On the repo page, tap **Add file → Upload files** (if the mobile layout hides this, tap Safari's `aA`/page menu → **Request Desktop Website**). Tap **choose your files**, then **Browse** to select the *one test file* from Files/Drive. Scroll down, type a descriptive commit message, and select **Commit changes**. A commit preserves its previous version in Git history: if you accidentally upload private material, simply deleting it later is **not** enough to remove the history.
5. Refresh the repo, open the file and confirm its contents. Copy the exact URL `https://github.com/your-account/repo/blob/main/filename` into your next document and tell me **what to compare**. Repeat with a reviewed selection only after this test works. For collaborators, GitHub's repo **Settings → Collaborators** lets the owner invite the correct usernames; don't share passwords.

**Official written walkthroughs:** [create a repo](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository), [upload a file](https://docs.github.com/en/repositories/working-with-files/managing-files/adding-a-file-to-a-repository), and [GitHub Mobile](https://docs.github.com/en/get-started/using-github/github-mobile). **Visual walkthrough:** GitHub's own [GitHub for Beginners playlist on YouTube](https://www.youtube.com/playlist?list=PL0lo9MOBetEFcp4SCWinBdpml9B2U25-f) (its first video explains account/repo basics; for the upload step use the written page alongside it). For a very large collection, ask a teammate for a screen-share: hundreds of uploads by phone are not a safe or practical starting point.

**Cloudflare and OneCompiler are separate.** Cloudflare Pages can *display a website from a GitHub repo* after you authorize it (guide: [Cloudflare Pages Git integration](https://developers.cloudflare.com/pages/get-started/git-integration/)); it is not where the team's source history lives. First get the approved code into GitHub, then ask Mike which repo and public page he wants, and don't connect accounts to a third-party service without understanding its requested permissions. [OneCompiler](https://onecompiler.com/) is for quick snippets, **not a repository or a replacement for GitHub**; don't paste private project files or credentials into it. Ask Mike to say precisely what either service is meant to do for ORION.
