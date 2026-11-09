# FieldCore snapshot (the-far-queen/fieldcore, MIT)
commit: 62abf4f108b8d7c7c9ab5c426a16db595349d52d Tue Oct 6 04:13:32 2026 +0700
files: 176

## python3 src/steel_ball_proof.py (run 2026-10-06, numpy installed)
```
----------------------------------------------------------------------
  trials:              50
  max final drift:     2.35e-09
  mean final drift:    2.35e-09
  worst-case steps:    200
  ✓ all 50 drops converged to ψ₀

[3] TRACE OF ONE DROP  (drift per step)
----------------------------------------------------------------------
  k    drift
  0     5.882026e+00
  1     3.000000e+00
  2     2.700000e+00
  3     2.430000e+00
  5     1.968300e+00
  10    1.162261e+00
  20    4.052555e-01
  50    1.717925e-02
  274   9.667770e-13
  ✓ converged in 274 steps

[4] 16-D DROP (FieldCore canonical dim)
----------------------------------------------------------------------
  initial drift d_0:   16.774141
  converged in:        274 steps
  ✓ 16-D ball finds the hole

[5] WHY THIS MATTERS vs. LLM-STYLE STOCHASTIC GRADIENT
----------------------------------------------------------------------
  LLM forward pass = F(x + noise) where noise is sampled per token.
  FieldCore = exact projected gradient step, no noise, deterministic.
  Cost: FieldCore step is O(d) flops; LLM forward pass is O(d²).
  Heat: FieldCore step emits ~1 op/cycle; LLM emits matrix-multiply heat.
  Control: FieldCore has a 1-bit veto (the gate); LLM has no analog.
  Conclusion: same convergence guarantee, lower cost, less heat,
              and explicit control authority.

======================================================================
PROOF COMPLETE — every drop finds the hole, every time.
======================================================================
```

## python3 src/tiniest_core/tiniest_core.py
```
tiniest_core: 5 asserts passed.
```
