# What is actually blocking the links (checked 2026-10-13, ~16:00 UTC)

Short version: **I can't find a bug, and nothing about your links is wrong.** My workspace has a blanket rule that lets a connection start but stops anything from being sent or received through it. The rule treats every website the same way.

## What I tested, step by step
| Step | Result | What it means |
|---|---|---|
| 1. Look up the address of a site (DNS) | Works (e.g. `example.com` → its real addresses) | Name lookup works fine. |
| 2. Open a connection to the site | Works for real sites, fails for a made-up test address | The network path exists, and something does answer. |
| 3. Start a secure (https) conversation | **Cut off the moment I say "hello"** (connection reset) | This is where it stops. |
| 4. Same as 3, but without naming the site / naming a different site | Still cut off | It isn't filtering by site name. It blocks everything. |
| 5. Plain (non-secure) http | Gets no answer at all, until it times out | Also blocked. |
| Sites tried | Google Docs, Blogger, X, example.com, Wikipedia, GitHub, pypi.org | All fail the same way. |

## Conclusion
- The block is the same for every website, and it hits after the connection opens, the first time any data is sent. A broken site, an expired link or a sharing setting wouldn't look like this. This is what a deliberate "no outbound web traffic" setting looks like.
- **I can't switch this off from inside my workspace,** and I can't get around it either. I've flagged the issue to the Harmonic team.
- I did 4 timed retries (5 minutes apart, 15:34–15:49 UTC). All 4 failed the same way. See `LINK_RETRY_LOG.txt`.

## What works right now
Paste the text, attach screenshots, or upload files (PDF, .txt, .docx, images). Anything you attach to your message reaches me.
