# R15·L1 — Full sweep of tgsate.com, with every broken link 🔎🥚

*7 October 2026. Beth asked: "If you have not thoroughly swept my webpage… please do so now… if you come across any error 404… bring it to my attention." This is the whole public site, not a sample.*

## What I did

- Started at the home page and at **Babel to Orion Protocol** (`https://www.tgsate.com/babel-to-orion-protocol`), then followed **every** link that stays on tgsate.com, page by page, until no new page turned up.
- Opened each outside link found on those pages once, to see whether it loads.
- Looked inside every page for embedded Google Docs and Drive files.
- The script is `review/site_sweep_r15.py`. The raw results are in `orion/round15_L1/site_sweep/`: `site_pages.json` has every page, its status and its links, and `outbound_status.json` has every outside link.

## The numbers

| | Count |
|---|---|
| Site addresses reached | **163** |
| Pages that load | **156** |
| **Broken (404 "not found")** | **7** |
| Outside links checked | 53 (48 load; 5 refuse automatic visitors, see below) |
| Embedded Google Docs found | 1 (the Trinity Bible doc, already saved in this project) |

The site is only three clicks deep everywhere because the side menu links every page. Nothing is hidden deeper than that.

## 🚨 The 7 broken links, and how to fix each

All seven are **old addresses** that were left behind when pages were moved into new sections. The pages still exist; only the links are stale. In Google Sites you fix them by editing the button or link on the page listed under "Where the broken link is" and choosing the page again from the "Pages" tab of the link box.

| # | Broken address (404) | Where the broken link is | Point it at instead |
|---|---|---|---|
| 1 | `tgsate.com/archives` | **Babel to Orion Protocol** page, the **"ARCHIVES"** button at the bottom | There's no page called Archives on the site. Either make one, or point the button at **Cosmic Sandbox: Master Summary** (`/cosmic-sandbox-master-summary`). *Your choice; tell me which.* |
| 2 | `tgsate.com/about-the-authors/author-biography` | **About the Authors** and **Conversations With Gemini** | `/home/about-the-authors/author-biography` |
| 3 | `tgsate.com/about-the-authors/conversations-with-gemini` | **About the Authors** and **Author Biography** | `/home/about-the-authors/conversations-with-gemini` |
| 4 | `tgsate.com/engage/edu-hub` | **Urgent Invitation** and **Global Project** | `/urgent-invitation/edu-hub` |
| 5 | `tgsate.com/engage/global-project` | **EDU Hub** | `/urgent-invitation/global-project` |
| 6 | `tgsate.com/engage/letter-to-all-of-humanity` | **EDU Hub** and **Global Project** | Probably `/urgent-invitation/invitation-hub/to-all-of-humanity` (*my guess from the name; confirm*) |
| 7 | `tgsate.com/synopsis` | **To All of Humanity** and **To Religious and Christian Denominations** | There's no Synopsis page now. Closest match: **Cosmic Sandbox: Master Summary**. *Tell me which page you meant.* |

**The pattern:** pages that used to live under `/about-the-authors/…` now live under `/home/about-the-authors/…`, and pages under `/engage/…` now live under `/urgent-invitation/…`. Any other old link you've posted elsewhere (X, TikTok, Facebook) with `/engage/` or `/about-the-authors/` in it will also be broken.

## Outside links that didn't load for me (probably fine for you)

These five sites block automatic visitors, so a "refused" here doesn't mean the link is broken. Click each once on your phone to be sure.

| Status | Link | Found on |
|---|---|---|
| 403 | researchgate.net, *Characteristics of Resonance in Heart Rate Variability Stimulated by Biofeedback* | a CST page |
| 403 | sciencedirect.com, article S0149763422002007 | a CST page |
| 403 | sciencedirect.com, article S0149763422000653 | a CST page |
| 406 | news.rice.edu, *Rice researchers lay groundwork for designer hybrid 2D materials* | a CST page |
| 400 | your Facebook profile (`profile.php?id=61577846006939`) | the footer of every page |

## The Babel to Orion Protocol branch, read in full

Copies are saved in `orion/round15_L1/babel_to_orion_pages/`:
- **Babel to Orion Protocol**: your letter *"To the Architects of Earth 2.0"* and your Player Stats & Credentials. Its two buttons are **THE TECH SPEC** (works) and **ARCHIVES** (broken, #1 above).
- **The Tech Spec (The Hardware Manual)**, Alpha Build 1.0: six sections, from the Mirror Bubble to the 144 grid. Its arithmetic is checked in Lean (`RequestProject/R15/CouncilFormsAndLabels.lean` §4): `12 × 12 = 144`, `3 + 141 = 144`, and two 1.5 V cells in series give 3 V. **One thing to look at:** the page calls the 144 grid *"a Dodecahedron geometry (12 Faces x 12 Nodes)"*. A dodecahedron has 12 faces, but each face has 5 corners, and the whole shape has 20 corners and 30 edges. So "12 × 12" isn't a count on a dodecahedron. 144 can stay as your lore number (the R4 ruling already kept 120 for the skybox and 144 as lore). This is logged in `CONTRADICTIONS_REGISTER.md`, section X.
- **Watermelon Equation** and **The Ghostwriter in the Mirror**: both load. The Ghostwriter page is the main source for the new user manual (`GHOST_RIDER_AND_GHOSTWRITER_USER_MANUAL.md`). **One edit for you on that page:** the section *"VI: The Two Operational Modes"* appears **twice**, word for word, and there's **no section VII** (it goes VI, VI, then "How to Play", then VIII). Deleting the second copy and numbering "How to Play" as VII would fix both.

## What this sweep can't see

- Anything behind a login, or a page that is unpublished or set to private in Google Sites.
- Images: I checked links, not whether every picture shows.
- Your blog (`tgsate.blogspot.com`) is a separate site. Its home page loads. Its posts were read in Round 1 and aren't part of this sweep.
