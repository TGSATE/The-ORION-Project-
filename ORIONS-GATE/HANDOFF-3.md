# LOOM-TRIAD-001 v0.3 Professional Handoff

## Executive result

v0.3 upgrades TRIAD from durable identity mechanics to a correspondent-identity reference protocol. The accepted runtime prefix can now be replayed against an independently encoded abstract transition relation because every committed receipt binds the exact immutable transition request used to produce it.

Executed locally: **45/45 tests pass; 12/12 targeted source mutations killed; 2/2 real SIGKILL probes pass.**

## What is new

1. **Request-bound receipts** — `request_hash` closes the v0.2 replay gap.
2. **Immutable request archive** — each accepted transition stores state, receipt, and request by sequence.
3. **Independent trace replay** — `triad/model.py` does not call the runtime continuity validator; `triad/correspondence.py` replays the accepted prefix.
4. **Recovery semantic revalidation** — a durable COMMIT is not enough by itself; recovery rechecks the exact tuple before HEAD advancement.
5. **Single-writer lock** — non-blocking POSIX `flock` for cooperating writers on one store.
6. **Threshold trust administration** — distinct M-of-N Ed25519 approvals over exact governance payloads.
7. **Compromise recovery** — old key revoked at a boundary, higher-epoch replacement becomes valid at that boundary.
8. **Real process-kill probes** — SIGKILL before COMMIT rolls back; SIGKILL after COMMIT completes on restart.

## Important architectural correction

v0.2 could replay CHRONICLE integrity but did not preserve the full transition request after journal cleanup. That meant a later validator could not independently reconstruct every forbidden-promotion decision. v0.3 persists `request-i` and binds it into `receipt-i`.

Therefore the replay relation can now check the same declared operation, actor, grants, and delta that were committed.

## What the trace relation does and does not establish

It establishes, for the frozen reference transition subset, that every accepted stored transition can be replayed as a legal abstract step under the independently encoded checker.

It does **not** establish complete runtime refinement, liveness, distributed safety, correctness of Python itself, or correctness under arbitrary filesystem/hardware failures.

## Formal lane

`formal/NoThrone.lean` now includes recovery-non-authority, request-bound continuity, and accepted-step/model-legality propositions. `lean-toolchain` pins Lean `v4.34.1`.

This host had no Lean executable, so **FORMAL_PASS is not earned**. Status remains `LEAN_SPECIFIED_NOT_EXECUTED`.

## Remaining gates

- compile/type-check the pinned Lean kernel and record checker output;
- extend the trace relation toward a named forward-simulation/refinement theorem;
- test real storage fault/power-loss semantics on controlled filesystems;
- harden key custody/HSM and threshold signing implementation;
- define canonical Civilisation.One/Divine adapters;
- obtain independent reproduction;
- archive the release with an external immutable/versioned preservation receipt.

## Claim ceiling

REFERENCE_IMPLEMENTATION
AUTHORITY_NONE
RUNTIME_MODEL_TRACE_RELATION_TESTED
FULL_REFINEMENT_NOT_PROVEN
LEAN_SPECIFIED_NOT_EXECUTED
HOST_SIGKILL_PROBES_EXECUTED
POWER_LOSS_NOT_TESTED
INDEPENDENT_REPRODUCTION_NOT_EARNED
PRODUCTION_PROHIBITED
