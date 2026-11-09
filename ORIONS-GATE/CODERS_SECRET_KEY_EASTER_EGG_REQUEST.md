# 🚨 For the coders: the secret dragon key 🪩♾️⏭️

*9 October 2026. Beth's request: an emoji code that, typed at login, gives a player instant access to their dragon, without the code being written in the game's source.*

---

## 1. Plain answers for Beth

**Is it in the build now? No.** I searched every file in the project:
- **No login screen, password check or redeem box exists** in any code here. The only game code, the `site/` web page, has no accounts at all.
- 🪩♾️⏭️ shows up in **41 files**, all notes, readouts, Doc snapshots and the X bio drafts. **None of them use it as a password.**
- Manual §6.12 already lists it as a **design**: the Hidden Key cipher quest. Nobody has built it.

**Can it be done without the code being in the build? Yes.** This is normal practice. The game keeps only a **fingerprint** of the code (a "hash": a scrambled value you can check a guess against but can't turn back into the code). The real code stays with you. Details in §3.

**⚠️ But 🪩♾️⏭️ itself is no longer secret.**
- It's in the X bio draft as *"Key in plain sight: 🪩♾️⏭️"*.
- It's in your open Round 15 and 16 Google Docs and in at least 40 project files.
- Deleting it from the build now **won't hide it**. Anyone who has seen a Doc, the bio or a copy of this project already has it. Git history keeps old copies too.

**My suggestion: keep 🪩♾️⏭️ as the public clue and pick a NEW secret code as the real answer.** That matches the "hidden in plain sight" quest from manual §6.12: the icon everyone can see points to a code only solvers find. **Don't type the new code into any Doc, chat or file, including to me.** Give it only to the coder who sets it up (§3, step 4).

**Who decides?** You wrote "voters"; I've read that as **coders**. The coders have to build it, but whether the team votes on it is your call.

**I can't contact anyone myself.** The message in §2 is ready to copy and send.

---

## 2. Copy-and-send message to the coders 📋

> **🚨 ORION priority request from Beth: secret dragon key (please read before the next build)** 💛
>
> I want an Easter egg: a secret emoji code that gives a logged-in player their dragon instantly.
>
> 1. **This is NOT a login password or backdoor.** Players sign in the normal way, then type the code into a hidden "redeem" box. It unlocks their dragon and nothing else: no other accounts, admin powers or rules.
> 2. **The code must NOT be written anywhere in the source code, the game files or the repo.** Store only a salted slow hash (Argon2id or bcrypt) on the **server**, set through a secret setting or environment variable, never committed. Check guesses on the server, never in the app or browser.
> 3. **Before hashing, strip U+FE0F** (the invisible emoji style mark) and normalise to NFC, so the code works on every phone and keyboard.
> 4. **Rate-limit it:** a few tries per account per hour, one redeem per account, and log attempts.
> 5. **It must be swappable:** if it leaks, we change the stored hash and the old code stops working, with no new build.
> 6. **The public icon 🪩♾️⏭️ is the clue, not the answer.** I'll give the real code privately to whoever sets this up.
> 7. **Kids' accounts:** it grants only the dragon (an in-game item). It never skips age gates or parent approval.
>
> **Please reply with the three-line readback:** what you understood, who's building it, and what you need from me.

---

## 3. Technical notes for whoever builds it 🛠️

1. **Shape:** the code is a redeem code checked after sign-in, like a console promo code. It is **not** a shared master password. A shared password that opens accounts is a backdoor: whoever learns it gets into everyone's account, children's included.
2. **Where the secret lives:** only the hash goes on the server, in an environment variable or secrets manager (e.g. `DRAGON_KEY_HASH`), never in git. The source contains only the checking logic, which is safe to publish.
3. **Why server-side:** a hash shipped inside the app can be guessed offline. A three-emoji code is short, so a fast hash could be cracked by brute force. Server-side checking with rate limits closes that hole.
4. **Setting it:** Beth tells one trusted admin the code **in person or by phone**. The admin runs the hash tool once on their own machine, puts the result in the server setting, and tells no one.
5. **Emoji clean-up:** `🪩♾️⏭️` has invisible U+FE0F marks after ♾ and ⏭, and some keyboards leave them out. Remove U+FE0F and apply NFC before hashing, both when setting and when checking.
6. **Grant:** add the dragon to the signed-in player's own account, mark that account "redeemed", and change nothing else.

---

## 4. Checked in Lean ✅

`RequestProject/RoundTwentyFour/DragonKeyRedeemCode.lean` builds with no unfinished proofs and only Lean's standard axioms. These results check a **model of the design**, not real game code (none exists yet):

- **The emoji clean-up works:** 🪩♾️⏭️ with the style marks and 🪩♾⏭ without them read as the same code after U+FE0F is removed.
- **The right code works:** a first-time player who enters it, with or without the marks, gets their dragon.
- **A wrong code changes nothing.**
- **No one's login ever changes** when anyone redeems, the redeeming player's included.
- **No other player's account changes.**
- **The stored fingerprint is never changed** by redeeming.
- **One redeem per player:** after a successful redeem, any further try changes nothing.
- **A leaked code can be retired:** once the stored fingerprint is swapped for a new code's, the old code stops working.

The model leaves the fingerprint (hash) function abstract. It doesn't check that any real hash is secure; that comes from using a standard one such as Argon2id or bcrypt.

---

## 5. Beth's follow-up: separate codes, and keeping one person out 🐗

*Beth: "I will establish a different code for Elon later, hoping we can keep him out via biometrics and 1/1 login … until he figures out how to get my mom in line with her Alexa."*

**Separate codes per person: yes, easy.** Each code is tied to **one account**, works once, and lives on the server as a hash, the same as §3. Giving someone their own code (or not giving them one) is the simplest gate there is.

**Keeping a specific account out: yes.** The server keeps a **block list** of accounts. A blocked account's redeem is ignored before the code is even checked, so a correct code doesn't help. Lifting the block means flipping that one entry.

**"1/1 login" (one person, one account):** ask the coders for phone or email verification plus a passkey (Face ID / fingerprint unlock on the person's own phone). The phone checks the face or finger and **ORION never stores it**. That gives the biometric feel without holding anyone's biometric data.

**Biometrics, a caution:** spotting one particular person by face or fingerprint would mean **collecting and storing biometric data**. Some places have strict rules about that, especially for children. Ask a qualified adviser before going that route; I can't give legal advice. A block list on his account does the job without it.

**Small fact check 😄:** Alexa is **Amazon's** (Jeff Bezos's company), not Elon's. Elon's AI is **Grok**. So if Mom's trouble is with an Echo / Alexa speaker, Amazon support is where to go. If you meant Grok, then Elon's the right target. 🐉

**Checked in Lean** (same file, two more results):
- **A blocked account gets nothing,** whatever it types, even the correct code.
- **When the block is lifted,** that account redeems by the normal rules.

**Add to the coders' message:** *"8. Per-person codes, one account each, plus a server-side block list I control. Passkey sign-in for 1/1 accounts; don't store anyone's face or fingerprint."*
