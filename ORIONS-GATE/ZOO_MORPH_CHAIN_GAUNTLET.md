# The Morph Chain Gauntlet (Zoo idea) 🦇➕🦔➕🐊

*Round 21, 7 October 2026. From your note (doc line 423): "bat hedgehog crocodile: the first round you would fight the bat, the second round you would fight the bat morphed with a hedgehog, and the third round you would fight the bat the hedgehog morphed with the crocodile… That would keep all of their chains together and force each individual step to be processed and also give a cool game increased difficulty visual to explain the build they're working with."*

**Status: proposal 🌀 for Matthew.** The Proofs Arena is his design. Send him this page and ask him to confirm the chains.

## 1. You remembered the order right

In Matthew's arena roster (his `Monolithic-Zoo-Lean4` registry, saved and checked in Round 17), Ring 1 runs 1–23. Your three animals are **back to back**:

| # | Animal | What it tests (Matthew's names) |
|---|---|---|
| 19 | **BAT**: Baseline Adversarial Tester | Does the idea beat fake and shuffled versions of itself? |
| 20 | **HEDGEHOG**: Held-out Evaluation of Dynamic Generalization… | Does it still work on new data and in new places? |
| 21 | **CROCODILE**: Causal Recursive Observation… | If you change the cause, does the effect change? |

The computer confirmed this against the roster (`RequestProject/RoundTwentyOne/MorphChainAndTranslator.lean`, `beth_example_chain`).

## 2. How the gauntlet works

1. A chain is an ordered list of animals.
2. **Round 1:** fight the first animal alone.
3. **Round k:** fight one boss made of the first k animals **fused together**. The new animal's test is added **on top of** the earlier tests, so the idea has to pass all of them again together.
4. **No skipping:** each round adds exactly one animal, the next in the chain.
5. **The last boss is the whole chain.** Beating it means the idea survived every step in order.
6. Outcomes use the arena's existing rules: a veto from any animal stops the run. "Habitat-conditional" from HEDGEHOG is a **pass with a label**, as the Round 17 review recommended.

**What the computer checked (for this model):**
- Every boss contains all earlier bosses, in order.
- Each round adds exactly the next animal.
- Bosses only get bigger.
- The last boss is the whole chain.

## 3. Chains already in Matthew's material

| Chain | Where it comes from | Morph bosses |
|---|---|---|
| **BAT → HEDGEHOG → CROCODILE** | Your example (arena 19–21) | Bat · Bat-Hedgehog · Bat-Hedgehog-Crocodile |
| **RAVEN → CAT → BAT** | The "skeptic wave" in the arena compilation (§4) | Raven · Raven-Cat · Raven-Cat-Bat |
| **Ring 1, 1 → 23** | The full discovery → scepticism → synthesis run | Ends at TURTLE, who "carries the house" |

**Questions for Matthew:**
- Are these the chains he means?
- If a player loses round 2, do they restart round 2 or the whole chain?

## 4. Art prompts for the three morph bosses

*Paste the shared style line from `PROOFS_ARENA_ANIMAL_CARDS.md` after each one.*

1. **BAT (round 1):** "A boss card of a giant bat made of dark sonar rings, wings edged with faint glowing duplicate shadows (the fake versions it tests against), title BAT: BASELINE ADVERSARIAL TESTER, plate 19."
2. **BAT-HEDGEHOG (round 2):** "A boss card of a fused creature: a bat's wings and sonar rings on a hedgehog's rolled, spiny body, each spine tipped with a tiny different landscape (new habitats), title BAT-HEDGEHOG MORPH, plates 19 + 20."
3. **BAT-HEDGEHOG-CROCODILE (round 3):** "A boss card of a three-part chimera: a crocodile's armoured jaws and tail, a hedgehog's spines along its back, bat wings with sonar rings, a lever in its jaws showing cause and effect, title BAT-HEDGEHOG-CROCODILE MORPH, plates 19 + 20 + 21, final boss of the chain."

## 5. Why it fits ORION

- **"Each individual step is processed":** the model makes skipping impossible.
- **"A cool increased-difficulty visual":** the boss literally grows a part per round.
- **"Explains the build they're working with":** the boss's body shows which checks the idea has already passed.
