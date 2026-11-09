# Can Aristotle be one shared group project?

Short answer: Aristotle's public documentation doesn't describe team accounts,
shared projects, inviting members, or giving someone else admin access. So I
can't confirm that it's possible. That doesn't prove it's impossible either.
I've sent your request to the Harmonic team as a feature request.

## What the documentation does describe

- Every user signs up and creates **their own API key** at
  https://aristotle.harmonic.fun/keys
  (https://aristotle.harmonic.fun/docs/installation).
- Every project has a **project ID**. Work continues in the same project with
  `aristotle continue <project-id> "..."` or, in Python, `Project.from_id(...)`
  followed by `project.ask(...)`
  (https://aristotle.harmonic.fun/docs/overview, https://aristotle.harmonic.fun/docs/api).
- `aristotle submit "..." --project-dir ./folder` starts a project from a
  folder, and `aristotle download <project-id>` (or `project.get_files()`) gets
  the result back as a folder.

The documentation doesn't say whether someone using their own key can continue
a project that belongs to another person's account.

## A setup that works with the features above: one shared folder

The "machine" is really this project folder, and every result comes back as
that folder. So the group can share the folder instead of the account:

1. Keep the latest project folder somewhere everyone can reach: a shared
   Google Drive folder, Dropbox, or a GitHub repository (best, because it keeps
   track of who changed what).
2. Each collaborator signs up for Aristotle themselves and uses **their own**
   API key.
3. When someone wants to add something, they take the latest folder, put their
   material in (for example `umbrella/inbox/<their name>/`), and submit it with
   `aristotle submit "..." --project-dir ./folder`.
4. They put the returned folder back in the shared location so the next
   person starts from it.
5. Agree on one rule so work doesn't get lost: only one person runs at a time,
   or everyone pulls the newest copy before they submit.

This means you don't have to pass every message along yourself. It does need a
little coordination, because two runs started at the same moment would each
produce their own version of the folder.

## What I'd avoid

- **Don't share your API key or login.** The documentation describes keys as
  belonging to one person. Whether sharing is allowed is a question about the
  service terms, which I can't answer. See https://aristotle.harmonic.fun/terms,
  and the Harmonic team can help with questions about them.
