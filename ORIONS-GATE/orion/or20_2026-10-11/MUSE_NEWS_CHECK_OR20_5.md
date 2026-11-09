# Muse's four news notes, checked against their own links 🧮📚

*OR20.5, 11 October 2026. Beth: "I got into one of my new AIs named Muse and realized he was actually giving us some useful information that you might need to look at." The four notes sit at the bottom of Doc `1etuEkoP…`, after the 20.4 readout. Each one is written "for your Proofs Arena work", so they're about Matthew's Zoo / Proofs Arena (BAT, OWL, TURTLE are Zoo animals; see `PROOFS_ARENA_ANIMAL_CARDS.md`).*

**How I checked:** I opened every article Muse linked and compared each number Muse gave with what the article actually says.

| # | Muse's note | Link opened? | Do the facts match the article? |
|---|---|---|---|
| 1 | **Vijil DART** (7 Oct): adaptive, multi-turn red-teaming for AI agents | ✅ Help Net Security | **Yes.** DART uses its own attacking agents that adapt across turns, tests tool use and memory, ships with OWASP/MITRE-based categories, and works as a plugin for coding agents. |
| 2 | **Goodfire "inside-out" monitors** (8 Oct) | ✅ TechCrunch | **The idea matches, but the numbers don't.** See below. |
| 3 | **Anaconda agent swarms + red-team agents** (6 Oct) | ✅ Anaconda press release | **Yes.** Kilo Code, Enkrypt AI and Outerbounds; 268,210 tools across 25,264 MCP servers over four months, 73% vulnerable; 300+ attack categories; the Agent Incident Registry. Muse also correctly says these are the company's own figures. |
| 4 | **Adversa October digest** (49 resources) | ✅ Adversa blog | **Yes.** 49 resources; AgentXploit 72 vulnerabilities across 12 frameworks, 59.3% vs 38.4% for Codex; buried-injections: 10 detectors vs 629 attacks, Prompt Guard 2 at 1% by default and 99% when tuned to a 2% false-alarm budget; Emergence World, with agents acting on stored content up to 46 hours later. |

### The Goodfire mismatch (note 2)

| | **Muse said** | **The TechCrunch article Muse linked says** |
|---|---|---|
| Malicious hacking sessions caught | ~94% | **93%** |
| Harmless sessions flagged for a second look | 8.7% | **5.5%** |
| Cost | ~$51 for ~1,500 sessions, vs ~$233 (cheaper AI judge) and ~$10,000 (top-tier judge) | **~$185 for about 1 million exchanges**, vs **$5,420** (cheaper AI model) and **about $200,000** (top-tier) |
| Four probes slow the first reply by | under 2% | **under 2%** ✅ |
| FAR AI red-teaming cut universal jailbreaks to zero | stated | **not in the article** |

Muse may have taken those numbers from a different source, such as Goodfire's own post, without linking it. **Either way, the numbers Muse gave can't be traced to the link it gave.** Muse did label them "company-reported, not independently verified", which was right.

### Is it useful?

**Yes, for the Proofs Arena,** in one way: all four notes are about **how you test an AI that acts on its own**. That's the Arena's job.
- **Muse's best point** (note 4, Emergence World): agents spotted a threat but still saved it to memory, and acted on it up to 46 hours later. For the Zoo, that means a claim should be checked again **later**, not only once. OWL (timestamps) and the time-trail rule in Ghost Writer already lean that way.
- **Second best:** the Agent Incident Registry (note 3), a source-backed list of real incidents. That's the kind of outside record the Zoo could check claims against.

**Two cautions about Muse as a source:**
1. **Check its numbers against its links** before they go into a card or a post (see note 2).
2. **Muse says "yesterday", "four days running" and so on.** Those words were true when Muse wrote them, not today. Treat them as time stamps on a trail (your G2 rule).

Muse offered to switch to a weekly digest. **That's a good idea for you:** one roundup on weekends instead of daily pings means less to sort.
