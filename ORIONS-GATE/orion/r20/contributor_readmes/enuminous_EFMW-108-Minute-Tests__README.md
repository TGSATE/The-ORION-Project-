# EFMW-108 — Frozen Predictive-Horizon Boundary Experiment

**Status:** Protocol frozen for prospective testing. No outcome is claimed by this repository.

EFMW-108 tests the preregistered hypothesis that an EFMW-derived predictor/detector has a reproducible change in performance near a **candidate 108-minute horizon** relative to prespecified controls.

The value 108 minutes is treated as a **prior observation to be challenged**, not as an established physical constant.

## Primary question

Does EFMW-specific predictive advantage versus matched controls exhibit a reproducible horizon-dependent transition near 108 minutes?

## Frozen horizons

30, 60, 90, 100, 105, 108, 111, 120, 150, 180 minutes.

## Three information conditions

1. **CONCEALED** — the evaluated system/agent cannot observe its prediction.
2. **REVEALED** — the prediction is supplied to the evaluated system/agent.
3. **ADVERSARIAL** — the evaluated system/agent is supplied the prediction and instructed/configured, where experimentally meaningful, to oppose it.

These conditions test whether making a prediction causally available to the predicted system changes predictive performance. They do not constitute a test of metaphysical free will.

## Core safeguards

- freeze before reveal;
- strict temporal train/test separation;
- no oracle/future information;
- identical data access for EFMW and controls;
- prespecified horizons and metrics;
- baseline comparison;
- recursion ablation;
- uncertainty intervals;
- correction for multiple horizon/condition comparisons;
- independent replication package;
- null results retained and reported.

## Important limitation

This repository supplies the **experimental harness and frozen specification**, not a fabricated EFMW implementation or dataset. The EFMW candidate and each baseline must implement the interface in `src/models.py`. Data adapters must satisfy `src/data.py`. Missing scientific inputs are explicit rather than invented.

## Quick start

```bash
python -m pip install -r requirements.txt
python scripts/verify_freeze.py
python scripts/run_experiment.py --config config/frozen_protocol.json
```

The default synthetic adapter is a **harness smoke test only** and cannot validate EFMW or the 108-minute hypothesis.

## Interpretation

A single positive result at 108 minutes is insufficient. Evidence for a boundary requires a reproducible horizon-dependent pattern, superiority to prespecified baselines, survival of ablation and leakage checks, and replication on held-out/external data.

See `PREREGISTRATION.md`, `ANALYSIS_PLAN.md`, and `FAILURE_CRITERIA.md`.
