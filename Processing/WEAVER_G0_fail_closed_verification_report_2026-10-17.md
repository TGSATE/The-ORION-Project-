# WEAVER — G0 Reference Policy Fail-Closed Verification
**Assessment date:** 2026-10-17
**Scope:** Local reference-policy source patch and adversarial unit tests; no resource effect, independent operator, attested approval, external witness, or production security certification.
**Status:** `G0-REF-001 LOCAL VERIFIED` for the specifically tested fail-closed property. `P0-AUTH` remains OPEN. Original R2 E2 historical ceiling / W0 / O0 WITHHELD / E3 0/8 / PRODUCTION PROHIBITED unchanged.

## Provenance
- Input source: `portable_high_reliability_harness_v1.zip` SHA-256 `ce5015237a032ca8c8c6f9867e50e9d8621dce651668f45f160d0070aa012c1a`.
- Original archive integrity: ZIP member read check passed; **30/30 original MANIFEST.sha256.json entries matched** before editing.
- Original policy engine SHA-256: `59089fce5970c39f1ee3e70ed6fdf8581762ee470d7e950bf6f79eab5c243231`.
- Patched policy engine SHA-256: `26b8d0bd87c982564388198bdef4a1ff88f8baa5d66469bb5450384d4e99a278`.
- Working output label: `portable_high_reliability_harness_v1` version `1.0.1-g0-local` (a **new** local derivative, not an historical source package).
- Versioned tool-action allowlist: `policy/tool_controls.yaml`, pinned schema `1.0.0`.
- Environment: Python `3.13.5` / Linux 6.18.55, pytest `9.0.2`, PyYAML `6.0.3`, jsonschema `4.26.0`.
- The artifact zip excludes stale `.pyc`/`__pycache__` and contains a newly generated per-file SHA-256 manifest.

## Direct failure reproduction on original bytes
`PolicyEngine.evaluate(action_class="teleport_money", agent_authority="O4", user_authorized=True)`

| Code | `allowed` | `required_authority` |
|---|---|---|
| Original reference harness | `True` | `O4` |
| Patched local derivative | `False` | `NONE` |

**Cause:** The original `required_authority_for()` substitutes `O4` for every unknown action instead of denying missing action names. An `O4` caller with truthy approval could therefore obtain `allowed=True` even for a nonexistent class. Caller-provided authority and approval are still unverified assertions in both versions.

## Before/after tests
| Stage | Command | Exit | Observation |
|---|---|---:|---|
| Original existing tests | `python -m unittest discover -s tests -v` | 0 | **7/7 passed** |
| New regression suite against original source | `python -m pytest -q --disable-warnings --tb=line tests/test_policy_g0.py` | 1 (expected) | **47 failed, 11 passed** (58 cases, including contract and robustness expectations; NOT 47 independently exploited defects) |
| Combined original + new suite against patch | `python -m pytest -q --disable-warnings --tb=short tests` | 0 | **65/65 passed**: 7 existing + 58 G0 regressions |
| Original tests repeated on patch | `python -m unittest discover -s tests -p test_policy_engine.py -v` | 0 | **7/7 passed** |
| Harness structural validator | `python scripts/validate_harness.py` | 0 | Passed; 1 registered claim validated |

Local commands emitted a nonfatal unrelated Python-startup `artifact_tool` spreadsheet warmup traceback; both patched test commands and the validator exited 0. Raw logs are preserved.

## Corrective control implemented
1. Reject any malformed or absent action name not **exactly** in the allowlist, before checking authority or approval. Never coerce an unknown action into `O4`.
2. Validate pinned allowlist schema version and individual canonical class names / authority metadata; refuse startup when invalid.
3. Reject invalid authority and non-boolean approval or constitutional check types without treating them as sufficient permission.
4. Read action requirements from a pinned snapshot of the allowlist so changes to `engine.tools` after initialization cannot silently grant a class.
5. Preserve known-action behavior and evidence–authority independence tests.

The `Decision` result remains provisional local policy output, bound to an exact named class. It is NOT a cryptographic signed grant or resource-commit decision.

## Remaining assurance gaps
- No independently authenticated, scope-bound human authorization or proof of agent authority; caller asserts `agent_authority` and `user_authorized` directly.
- No real resource owner, single-use grant consumption, revocation-after-check handling, atomic effect/outbox, or independent effect readback.
- No cross-language canonical wire contract, isolated Linux security principal test, witness, rollback/fork assurance, or independent reproduction.
- No assertion that other executors call this `evaluate()` function, or that a separate authorization path cannot bypass it.
- The R2 proposed **20 GD tests** remain `NOT_EXECUTED`. This local regression does not close GD-004, GD-006, P0-AUTH, or the production release gate.
- Original historical WEAVER component ZIPs/QF01/R5 sources are not proven recovered by this portable-harness patch.

## Reproduction
From the included package root, in a fresh environment with Python 3.10+:
```bash
python -m pip install -r requirements-dev.txt
python -m pytest -q tests
python -m unittest discover -s tests -p test_policy_engine.py -v
python scripts/validate_harness.py
```

The package includes `evidence/` raw test transcripts and `G0_PATCH.diff`. Review them before reusing any artifact. Additional independent replication remains required for assurance beyond this local report.

## Next gate
Implement independently authenticated grant identity/scope/expiry and a resource-owned commit-time check in a **separately named** single-effect SQLite demonstrator; ensure adversarial negative tests and distinct operational principals before considering P0-AUTH closure. O0 / production prohibited remains unchanged.

## Output bundle integrity
- Bundle: `WEAVER_G0_reference_policy_harness_patched_2026-10-17.zip`
- SHA-256: `6bdf14aad21f68c5d43a2eecd59ff9c824f33f12ca27be191c920042967edcb0`
- Generated file manifest entries: **38**.
