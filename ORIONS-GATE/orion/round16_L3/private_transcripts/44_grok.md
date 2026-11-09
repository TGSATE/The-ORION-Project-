# PRIVATE transcript, captured 2026-10-08 from https://grok.com/share/bGVnYWN5LWNvcHk_f8beef81-2a60-4c3d-a1f2-3180b8028bdd
# Title on Grok: Terminology Restorer App Structure

### [2026-08-23T20:09:23.034Z] human ()
Walk me through how this app works and how the code is organized.

### [2026-08-23T20:09:23.046Z] assistant (build)
I'll start by reading the project instructions and mapping the workspace so I can explain how the app is structured.

This is an existing app, so I’ll map the source, routes, and data flow next.

**Source** is a terminology restorer. You paste private or invented jargon; it maps those coinages onto established technical terms, then can match the rewrite against a library of related work and weave them into one account.

There are two places to work: **Restore** (home) and **Library**.

---

## What you do with it

**1. Restore a source**

Paste, drop, or load a `.txt` / `.md` file into the big box. Three samples are there if you want to try it first:

- invented physics-adjacent language
- spiritual coinages
- startup slang

Two options:

- **Find related works** — match against the library
- **Compile with matches** — weave those kin into one account (only if matching is on)

**Restore terms** sends the text to the model. After a wait you get:

| Section | What it is |
|---|---|
| Title, domains, claim | A short public-language summary |
| Lexicon | Private name → established term, with a one-line why |
| Rewrite | The argument in standard language |
| Kin | Library works that share a mechanism |
| Compiled | Optional synthesis with those matches |

You can copy the rewrite, **keep it in the library**, or clear and start again.

**2. Browse and compile the library**

The library has two shelves:

- **Canon** — ten seeded frameworks (cybernetics, predictive processing, homeostasis, attachment, orgs as control systems, and so on)
- **Kept restorations** — work you saved

Select two or more and compile them. Opening a work shows its rewrite, glossary, and linked kin; from there you can compile with those connections.

---

## How the code is organized

The app is a React 19 + TanStack Start site. Product code lives under `src/`. Platform plumbing (`auth`, `db`, PWA, preview) is pre-wired and mostly unused by the product itself — there are no accounts; the library is a shared, unowned table.

```text
src/
  routes/          pages (URL → screen)
  components/      UI
  lib/source/      the actual product: types, AI, jobs, DB, samples
  lib/auth, db     platform helpers (auth is off)
  styles.css       paper / ink / sage tokens
```

### Pages

| Route | Screen |
|---|---|
| `/` | Restore workspace |
| `/library` | Catalog of canon + kept work |
| `/library/$id` | One work and its links |

`__root.tsx` is the document shell: fonts, paper background, toaster, auth provider (idle). `AppShell` is the header with Restore / Library.

### The restore pipeline

1. **Client** (`distill-workspace.tsx`) holds the draft in a Zustand store (`lib/source/store.ts`) and calls `startDistill`.
2. **Server** (`lib/source/server.ts`) validates length (40–100k chars), creates an in-memory job, and returns a `jobId` immediately so the request does not time out.
3. The client **polls** `getDistillJob` every 1.2s.
4. In the background the server loads the catalog (if matching is on), calls Grok with a strict JSON schema, normalizes the payload, and finishes the job.
5. **Keep in the library** inserts a `works` row and writes `work_links` for each match.

Jobs live in a process-local `Map` and expire after an hour (`lib/source/jobs.ts`). They are not in the database.

### Data

Two tables (`migrations/0002_works.sql`):

- **`works`** — title, claim, standardized rewrite, glossary, domains, key concepts, optional source excerpt, `is_canon`
- **`work_links`** — from/to, strength (`strong` / `related` / `adjacent`), reason

On first use, if `works` is empty, the ten canon entries from `lib/source/canon.ts` are seeded.

### Types (`lib/source/types.ts`)

The important shapes:

- `GlossaryEntry` — original / standard / field / note
- `DistillResult` — what the model returns
- `WorkRecord` / `WorkDetail` — a saved row, plus links on the detail page

### UI split

| File | Role |
|---|---|
| `distill-workspace.tsx` | Paste/drop/file, options, restore, polling |
| `result-view.tsx` | Shared result layout (home, library compile, save) |
| `library-view.tsx` | Shelves, multi-select, compile |
| `work-detail.tsx` | One work + compile-with-kin |
| `mark.tsx` | Small brand mark |

Visual language is paper (`#F3EEE4`), ink, Fraunces for display, Figtree for UI.

---

The loop is: **private language in → established terms out → optional match and compile → optional keep**. Canon is the starting map of the field; everything you keep becomes part of that map for the next restore.
