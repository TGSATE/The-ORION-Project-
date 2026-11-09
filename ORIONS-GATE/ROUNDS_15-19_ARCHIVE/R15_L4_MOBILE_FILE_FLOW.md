# R15·L4 mobile Attach / Save / Find — review draft 🌀

This translates Beth's latest notes into a proposed, **not implemented** design. It does not mean an existing Google Docs/phone feature works this way. It is not permission to remove anything from a phone or to upload private files.

## The one-screen action

A single **+ Add** entry offers: “Pick from this device,” “Pick from Drive/another linked location,” “Paste link,” “Take picture,” “Voice note.” After a pick, show a preview, original location and file name, and three explicit choices: **Link**, **Embed preview**, **Make a copy here**. The UI tells you which choice changes permissions, which keeps a dependency on the original, and whether offline access is available. Give **Cancel** and **Undo**, and never silently turn a pasted private link into a public asset. Support large touch targets, screen readers, voice with confirmation, one-hand landscape layout, and switching between a compact workspace and full document.

**On success:** receipt = source title/location + destination document/block + link versus copy + time + accessible reopening test + sharing audience chosen by the user. Include a “Find it again” button in the document and searchable vault, with a private list of recent attachments and destinations. If a pick is interrupted, show “Not yet attached”; do not say “saved” until reopening succeeds. The vault is an index, not a claim that it contains a safe backup or knows everything on a user's phone.

**Delete original is a separate action, never a side effect of Share.** Keep it out of the primary attachment path. Offer deletion only if an independent copy was made and reopened, verify that the copy remains accessible with the intended account/offline policy, warn if any existing link depends on this original, and require a second deliberate confirmation naming the source. Prefer moving to recoverable trash with a visible undo window where the platform supports it. If only a link or preview was made, or the copy is unverified, **do not offer source deletion**. The minimal state rule in `RequestProject/R15/AttachmentSafety.lean` proves that its proposed transition respects the imported-copy, verification and confirmation flags; it does not implement actual verification or prove recoverability.

## Workspace instead of a carousel-only app switcher

An optional always-available workspace panel can show active tasks as large labelled bubbles/list entries: app name, draft saved/unsaved, last-viewed page/scroll anchor, and whether it's foreground, suspended or restarted. Provide both a linear accessible list and a bubble display rather than forcing one gesture/visual mode. Switching retains cursor, selection and saved draft; store an anchor (document ID + nearest paragraph/position) before focus loss. On re-entry, restore the anchor even if the app had to restart. For content added above, show “New material above” rather than jumping the reader away. Ask before a disruptive live reload when feasible; for essential security changes, explain when immediate reload cannot be deferred. Avoid claiming the switcher can prevent all background evictions or control updates in other apps.

## A graduated tutorial with a skip path

1. Locate a sample file in Files/Drive; choose whether to link or make a copy.
2. Add it to a draft; reopen it and verify the audience on a test account.
3. Find it again through “recent destinations” and through search; practice undo and restore.
4. Try the workspace switcher and restore a reading position.
5. Optional lesson: request source deletion only after *independent* copy verification, but never require actual deletion to complete training.

Keep the tutorial attached to each feature so the person who skipped ahead can revisit it; have a **Skip** button and no permanent skill gate for essential controls. Treat voice dictation, switch input and touch equally. If a step can't be completed, show exactly what has and hasn't been saved and an alternative route, rather than losing a draft.

### Acceptance checks (to be tested, not claimed complete)

- Start an attachment with one hand in landscape, interrupt the picker, resume without losing draft or creating a duplicate.
- Add a link versus a copied file and show different labels, access rules and offline outcomes.
- Share a test copy to a consenting second account, reopen from there, and ensure “private” stays private by default.
- Try deleting after only linking: no deletion option. Try copying but verification fails: no deletion option. Verify, then decline confirmation: no deletion. Confirm the correct source, then test recovery from trash where supported.
- Switch away while reading an old chat/document; force app restart; restore the prior paragraph rather than jump to the end.
- Increase text size, use a screen reader/voice/switch, and choose list instead of bubbles; no action requires fine gestures.

**Open design decisions:** what counts as an independently recoverable copy; which provider stores it; who can see each receipt; offline failure behavior; retention/trash period; and whether a phone controller and the ORION vault share the same index. No provider integration, scorekeeper or real vault has been built here.
