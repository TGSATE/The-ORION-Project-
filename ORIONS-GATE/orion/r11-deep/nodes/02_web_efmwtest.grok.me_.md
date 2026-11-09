# EFMW Bench

- source: https://efmwtest.grok.me/
- key: web:efmwtest.grok.me/
- depth: 2
- reached from: notion:3ef5aabf-6a11-8081-afd9-c90d1322d3bc

EFMW Bench                      Physics under test
EFMW Bench
Einstein–Feynman–Maxwell–Wright. The page integrates the public checks. It does not ask you to believe them.
□φ − (α²/c²) ∂²φ/∂t² = (4π/c²)(E + Pc)
EFMW receives no credit for explaining a result it did not predict. EXP-001 passed a frozen synthetic endpoint. That does not establish the framework as physics.
00   EXP-001  01   Cone  02   Exchange  03   Curvature  04   Lyapunov      Pass
Median paired lead 16.5 timesteps
Frozen criterion: median paired warning-lead gain of at least 10 timesteps against residual EWMA, seeds 1001–1040. This is the synthetic benchmark only.
Baseline lead
59.0
median timesteps
EFMW lead
78.0
median timesteps
Win rate
0.75
30 ahead, 10 behind
Wilcoxon p
0.003923
two-sided, tie-corrected
matches the published confirmatory record . Pre-onset false-positive rates, warmup 20: baseline  0.051311 , EFMW  0.061506 . Published compute ratio 1.117 is cited, not remeasured. Bootstrap interval [3.5, 18.5] is cited.
Plant and monitors
u = −0.45 x
a = 0.82 + 0.08 d
x ← a x + u + noise + 0.05 d + 0.012 d sin(0.18 t)
r = y − (0.82 y_prev + u)
b ← 0.90 b + 0.10 |r|
m ← 0.97 m + 0.03 r, score |m|
alarm:  3  steps above threshold, from onset
d ramps for 120 steps after a random onset in [140, 200). Failure is onset + 120. Lead is failure minus the alarm. The page does not resimulate the noise. It rescores the frozen observations.
Rescore
Episode  seed 1001       EWMA mix  0.10       Coherence mix  0.030       EWMA threshold  0.0456       Coherence threshold  0.0083       Sustain  3 steps     Restore frozen coefficients
Seed 1001
observation y
EWMA |residual|
EFMW |memory|
onset  194  · failure  314  · baseline lead   76  · EFMW lead  78  · gain   2
Seed  Onset  Base lead  EFMW lead  Gain
1001   194  76  78  2
1002   176  115  77  -38
1003   157  14  55  41
1004   183  92  111  19
1005   165  53  70  17
1006   171  46  77  31
1007   143  77  79  2
1008   161  56  74  18
1009   183  61  78  17
1010   181  23  79  56
1011   157  116  120  4
1012   184  57  73  16
1013   148  96  78  -18
1014   175  27  73  46
1015   173  47  95  48
1016   178  107  120  13
1017   199  91  83  -8
1018   193  29  78  49
1019   160  114  67  -47
1020   191  41  113  72
1021   150  88  90  2
1022   192  29  89  60
1023   155  26  65  39
1024   173  15  96  81
1025   184  87  66  -21
1026   177  43  52  9
1027   177  89  97  8
1028   174  103  77  -26
1029   173  41  58  17
1030   162  68  116  48
1031   193  120  102  -18
1032   165  39  57  18
1033   175  51  68  17
1034   176  18  103  85
1035   151  51  60  9
1036   162  94  52  -42
1037   163  81  79  -2
1038   166  82  72  -10
1039   171  79  82  3
1040   158  26  64  38
Published anchors, for the frozen coefficients only: baseline 59.0, EFMW 78.0, gain  16.5 , win rate 0.75, p = 0.003923.
Monitors, plant, and the confirmatory seeds are the public EFMW-EXP-001 harness. Candidate laws I–IV are the structures pulled out of the Lean formalization and run here as killable checks: preferred cone, Wright–Bianchi exchange, rotation–curvature degeneracy, recursive coherence. Source record: github.com/enuminous/EFMW-FULL.
