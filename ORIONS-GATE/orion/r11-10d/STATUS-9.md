# Codex Membrane v0.3 — Local Verification Status

## Canonical posture

- CORPUS: mature as architecture, open as canon
- CONSTITUTION: encoded
- ENFORCEMENT: executable local reference
- RELATION ENFORCEMENT: source-bound + state-gated
- CROSS-CORPUS AUDIT: executable reference
- MYTHOS-TO-CODE TAINT: transitive graph audit implemented
- CANON: unsealed
- AUTHORITY: O0 / NONE
- WITNESS: W0
- INDEPENDENT REPRODUCTION: NOT EARNED

## Fresh local run

- Unit tests: 27/27 PASS
- Hostile/input mutations: 18/18 KILLED
- Source-code mutants: 10/10 KILLED
- Claim + corpus receipts: 15 generated, 15 exact replays PASS
- Receipt tamper controls: PASS
- Reject-path protected-state invariance: PASS

## What changed from v0.2

1. Individual relation checks now require source support/reviewer or derivation provenance according to relation state.
2. Canon state transitions are explicit and fail closed on skipped stages.
3. Claims at relation-reviewed or later canon states cannot contain unresolved relations.
4. Cross-corpus ontology links require explicit human review and cannot affect authority.
5. Corpus graphs are audited for L1–L6 leakage classes.
6. Mythos taint propagates through semantic dependency edges and fails if it reaches operational behavior.
7. Receipt v2 supports exact model-free replay and detects tampering.
8. The source itself is mutation-tested; ten deliberate verifier weakenings are detected by focused probes.

## Evidence ceiling

All results above are local package execution. They are not independent witness evidence and do not promote W0, O0, canon status, empirical metaphysics, or any descendant theorem claim.

The verifier validates declared structure and policy invariants, not metaphysical truth or the external truth-quality of cited evidence.
