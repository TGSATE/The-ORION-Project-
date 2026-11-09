# Engine architecture: second pass, pushed further (☂️1.8)

📅 Tuesday 13 October 2026 · Lean files: `RequestProject/Engine/OpenInquiries.lean` and
`RequestProject/Engine/GrokEngineMap.lean`. Both build with no gaps (`sorry`) and use only Lean's
standard axioms.

**Ground rule.** Everything here is mathematics (your Level B). None of it proves or disproves
a Level C or D reading. Each result shows exactly what the math under an engine does, where it is
stronger than the page says and where it is weaker.

Earlier rounds checked the raw counts (62 = 12 + 20 + 30, G = 42, 3-6-9 digital roots). This
pass answers the **"Open Research Inquiries"** that *Linguistic Topology and the Mechanics of the
Universal Engine* asks, then goes through all nine engines on Grok's map.

---

## ✨ Glitter: things that popped out

1. **The 120-point boundary is real geometry.** Each of the dodecahedron's 60 flat corners has
   2 edges along its face, which makes 120 *flags* (vertex + edge + face). Lean checks that all
   120 are different. A regular solid has as many symmetries as flags, so "60 × 2 = 120" is the
   skybox's full symmetry count. (That last step is the standard textbook fact and is not proved
   in Lean.) `boundary_120_flags`
2. **The "Trinity vertex" is exactly the folding map.** When the 12 pentagons fold up, each of
   the 20 vertices gets exactly 3 corners. Lean builds an exact one-to-one match:
   *60 corners ↔ 20 vertices × 3 states*. This answers the page's question "what operation f
   performs the compression?" The geometry gives 3 slots per vertex. Labelling them in, out and
   closed is your choice. `corner_fibers_three`, `corners_equiv_vertex_trinity`
3. **1:5:1 and 3:1:3 both use 7 points, but they are different shapes.** The Conical Diamond has
   **10 faces** (your ten anchors again) and Euler number 2: one closed shell. The hourglass has
   Euler number **3** = 2 + 2 − 1: two shells pinched together at the single point (0,0,0). So
   "same sum of 7" hides a real topological difference between container and process.
   `container_vs_process`
4. **Tri-Sphere gears: a flat ring of three would jam, and the Z-axis is the escape.** A closed
   ring of meshed gears can turn only when it has an even number of gears (proved for every
   size). Three in a flat ring is odd, so it locks. Your pages give Phase counterclockwise, Time
   clockwise and Space a *Z-axis* motion, which takes the third sphere out of the plane and out
   of the jam. `gear_ring_turns_iff_even`, `three_planar_gears_jam`
5. **What spin ½ needs.** The Plasma page asks for spin ½. In the standard math of rotations, a
   360° turn gives −1 and only 720° gets back to +1, while the sign is invisible on ordinary
   vectors. Any gear model that claims spin ½ has to reproduce this. `spin_half_turns`,
   `sign_invisible_on_vectors`
6. **13 levels: prime means you never get stuck.** Stepping through 13 levels by any fixed stride
   visits all 13. With 12 levels, strides 2, 3, 4 and 6 loop early.
   `thirteen_levels_every_stride_full`, `twelve_levels_get_stuck`
7. **Why the ×6 cipher is the "wrong" multiplier, and which ones work.** Mod 26, ×6 merges letters
   in pairs and reaches only 13 values. A multiplier works without losing letters exactly when it
   shares no factor with 26, so 5 and 7 work and 6 doesn't. `multiplier_lossless_iff`
8. **The 5:2 core is a genuine split.** Every digit 0–9 is fixed exactly by (its remainder mod 5,
   its remainder mod 2). It's the same math as the coprime codec from this round. `five_two_core`

## Answers to the page's own falsifiability questions

| Page's question | What Lean shows |
|---|---|
| What is invariant under the ×6 cipher? | Every word's ×6 value is 6 × its A=1 value, so every comparison between words is unchanged (`cipher6_same_comparisons`). The cipher adds no information. |
| What happens under modular reduction? | Mod 9, the digital root depends only on the letter's position mod 3: 9 letters give 6, 9 give 3 and 8 give 9 (`digitalRoot_cipher6`, `cipher6_letter_families`). Mod 26, ×6 is two-to-one (`cipher6_mod26_halves`). |
| What operation f compresses 60 → 20? | The corner-to-vertex folding map. It is exactly 3-to-1, and the faces glue correctly: 30 edges, each shared by 2 faces (`dodeca_edges`). |
| Why cube rather than another 24? | Nothing in the count forces it. The cube and octahedron share the same 24 rotations, and the tetrahedron's full symmetry group also has 24 elements (`cube_octahedron_rotations`, `tetrahedron_full_symmetries`). |
| What about a language whose count doesn't fit? | With "one or two framework constants", 19 is the **only** size from 1 to 36 that fails. With three constants, every size from 1 to 78 fits (`only_nineteen_misfits`, `everything_fits_with_three`). So a real Blind Mapping Test should fix the rule *and* the number of terms in advance. |
| U and L operators | On A–Z, a–z, 0–9 each is idempotent, each absorbs the other (U∘L = U, L∘U = L), both leave the digits alone, and each collapses 62 symbols to 36 (`conical_duality`). |

## The nine engines on Grok's map

| Engine | Exact result | Plain words |
|---|---|---|
| Nested Tri-Torus | `boundary_120_flags`, `five_factorial` | 120 = the dodecahedron's flags (= its symmetries) = 5!. |
| Avatar 1:5:1 + 3:1:3 | `container_vs_process` | Sphere-like container versus pinched double shell. |
| J = 3 resonance | `evenly_spaced_pulls_cancel`, `two_pulls_are_a_line` | Evenly spaced pulls cancel exactly ("zero net torque"). Three is the smallest number that balances in a plane rather than on a line. |
| Watermelon 144 → 000 | `watermelon_rollover` | In base 12, 144 is written `100`, so a two-dial counter rolls to `00`. Mod 9, 144 is 0. |
| Tri-Sphere gears | `gear_ring_turns_iff_even`, `spin_half_turns` | Odd flat rings jam. Spin ½ means a 720° return. |
| ORION Engine | `record_needs_review` | Every Generate → Record run passes Human Review, **if** no step is skipped. The order alone doesn't enforce it. |
| Ghost Rider | `governed_session_safe` | A gate guarantees a safe session exactly as far as its safety check reaches, and no further. |
| Biological mirrors | `resonance_breathing`, `heart_breath_lock` | 0.1 Hz = 6 breaths/min. At 60 bpm heart and breath line up every breath; at 64 bpm only every 3 breaths. |
| 13 Levels | `thirteen_levels_every_stride_full` | Prime 13: every stride reaches every level. |

**Also proved, as an honest limit:** the Gibbs page's mod-9 prime lattice is true (primes above
3 land on 1, 2, 4, 5, 7 and 8, the two "triangles" {1,4,7} and {2,5,8}), but every one of those
six channels also contains composites such as 25, 35 and 49. It filters out multiples of 3 and
nothing more (`prime_mod_nine`, `triangles_are_cosets`, `channels_hold_composites`).

**Not checked:** Grok's descriptions of the engines are its own summary. I compared them against
the copies of your site pages saved in earlier rounds (Nested Tri-Torus, 5:2 Geometry Upgrade,
Plasma Substrate, ORION Engine Architecture, Gibbs engine). I could not reach the live site this
round.
