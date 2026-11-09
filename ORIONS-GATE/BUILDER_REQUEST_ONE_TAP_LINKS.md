# A request for the builders: make links and code one tap, not one at a time 🔗📲

*R16·L7, 8 October 2026. Beth: "having to save them one at a time… this is tedious… Ask them to please build a more intuitive way of handling this with the platforms they're building." And: "If you see a link, you should just be able to click it and choose which bookmark you want to put it into."*

## Part 1: what you no longer have to do

**You don't have to download anyone's code.** I do it at every level. This level I listed 380 public repositories across Mike, Matthew, Bobby, Ryan, your own pages and two found entities, and downloaded the 87 that changed since 1 September. The record is `orion/round16_L7/TEAM_CODE_LEDGER_2026-10-08.tsv`, with each one's exact version, so anyone can check that we looked at the same thing.

**For anyone with a computer**, one command does the same thing:

```text
python3 orion/tools/grab_team_code.py
```

It needs only git and Python. It downloads, never uploads, and writes the same ledger.

**Your bookmarks stay useful as *your* map** (💎 = keep, 🤟 = love it, 🆘 = check). I'll keep reminding you which links you haven't marked.

## Part 2: the message to send the builders (copy it)

> **Feature request from Beth: one-tap link and code handling**
>
> Right now, gathering the team's code means opening every GitHub link and saving it one at a time. Coding links look like document files on my phone. I can't keep up, and players won't either. Can the platform you're building do this?
>
> 1. **Tap any link → pick a folder.** Every link in a readout or chat gets a button: "save to…" plus my folders (Mike, Matthew, Bobby, Ryan, ORION, Found). No copying and pasting.
> 2. **Follow a person, not a link.** I add someone's GitHub once. The platform pulls all their public repos and tells me what's new since I last looked.
> 3. **One ledger.** Each repo shows who, what it is, licence, last update and the exact version, on one page I can read on a phone.
> 4. **AI-ready summary.** One tap turns a repo into a plain-language summary I can paste into any AI. (Mike's Lodge House "Archive Desk" already does this for ZIP files; this would extend it to GitHub links.)
> 5. **My marks travel with the link.** 💎 / 🤟 / 🆘 stay attached when I move a link between folders.
> 6. **Nothing private, nothing posted.** It only reads public pages and never posts or stars anything for me.
>
> Whoever builds a working version gets the credit line on it in ORION.

## Part 3: who might already be close

- **Mike's Lean-Workers Union Lodge House** has an archive desk (ZIP → AI-ready summary) and "seats & invitations": the closest match. Its page says these are browser-local planning tools, not live services yet.
- **Ryan's Weaver_Os** focuses on receipts and replay, which matches point 3 (one ledger with exact versions).
- **The free "i-have-adhd" skill** (found via humancodex) changes how coding AIs write answers: action first, numbered steps, state restated each turn. Builders could install it in their own coding assistants so replies come back in a form you can scan.
