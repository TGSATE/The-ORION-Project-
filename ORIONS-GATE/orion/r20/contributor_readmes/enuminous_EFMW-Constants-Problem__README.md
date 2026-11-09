# EFMW Constants Problem

A corrected successor to the 2025 essay **One Paper to Join Them All**.

This repository separates established identities from the open EFMW generative hypothesis.

## Core thesis

The meaningful unification target is not merely to show that physical constants are related. Standard physics already does that. The stronger target is to reduce the number of independent **dimensionless** inputs.

## Contents

- `index.html` — full public paper
- `DEPENDENCY_MAP.md` — identities, inputs, conventions, targets
- `CLAIMS_BOUNDARY.md` — scientific-status boundary
- `EFMWConstants/Core.lean` — Lean 4 formalization
- `EFMWConstants/Main.lean` — export surface
- `verify_constants.py` — numerical sanity checks
- `.github/workflows/lean.yml` — CI

## Build

```bash
lake update
lake build
python verify_constants.py
```

Lean proves consequences of the stated definitions and assumptions. It does not prove that EFMW derives any measured physical constant. In particular, the integer-ratio toy model is only an interface example; independent prespecification of parameters is an empirical/provenance condition outside Lean's object-level proof.

The numerical verifier uses the NIST 2022 CODATA recommended values, currently the latest available CODATA adjustment.
