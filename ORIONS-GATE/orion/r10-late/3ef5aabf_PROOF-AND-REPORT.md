# EFMW and the Chinese Room: a bounded proof attempt

**Record:** EFMW-CR-001, version 0.1.0, 4 October 2026.  
**Requested by:** Matthew Chenoweth Wright.  
**Prepared with:** ChatGPT.  
**Status:** An analytic derivation and an executed toy experiment. This is not a Lean-checked theorem, a validated implementation of the full EFMW framework, or a resolution of the Chinese Room.

## Outcome

A minimal recursive learner acquired reliable associations between four arbitrary actuator symbols and external effects in this constructed task. Its action accuracy was 100% across 192 simulated worlds. A conventional sample mean also achieved 100% and estimated the effects more accurately. The operational grounding criterion passed; the frozen criterion for an advantage over that baseline failed.

The derivation establishes a conditional result about learning effect vectors and selecting actions. The attempted inference from those properties to intrinsic understanding remains unproved. The mathematical specification does not constrain an understanding predicate, so both affirming and denying that predicate are compatible with its equations. This is a limitation of this specification, not a proof that machines cannot understand.

## 1. Frozen target, assumptions, and provenance

The target is: an implemented recursive learner can acquire **intervention-relative reference** for initially opaque symbols. A stronger proposed conclusion is that this constitutes understanding in the sense contested by the Chinese Room argument. Those are separate claims.

The model borrows the exponential-memory pattern used in the earlier EFMW residual discussion. We introduce its application to actuator displacements here. It is an ordinary exponential moving average (EWMA), not a derivation from EFMW's physical field equations. No claim is made that this four-entry estimator implements the complete cognitive envelope, linguistic semantics, self-model, or consciousness.

The protocol, parameters, seeds, controls, and numerical pass/fail thresholds were written and SHA-256 hashed before the first experiment execution. See `protocol.json` and `freeze.json`. This is a local freeze within one session, not external preregistration. A syntax error in the first attempted invocation was corrected before any experimental outcomes were produced; it did not change the protocol. All results come from the first successful execution.

Inputs supplied by the designer include a two-dimensional coordinate system, an additive dynamics hypothesis, four actuator handles, a balanced probing schedule, target displacements, a distance metric, and a nearest-effect action policy. The particular mapping from handles to effects is withheld from every learner. It is known to the environment, evaluator, and explicitly labeled oracle.

## 2. A precise operational model

Let the symbol set be A = {dax, wug, zup, kiv}. Each symbol invokes one actuator. The environment is a position x in R^2, with dynamics

\[
x_{t+1}=x_t+v_a.
\]

The four unknown vectors v_a are a bijection onto {(1,0), (0,1), (-1,0), (0,-1)}. The physical intervention is applying actuator a and observing its displacement. The learner receives

\[
d_{a,n}=v_a+\epsilon_{a,n}.
\]

Index n counts observations of that actuator, not overall wall-clock updates. Its estimate is

\[
m_{a,n+1}=\lambda m_{a,n}+(1-\lambda)d_{a,n+1},
\qquad m_{a,0}=0,
\qquad \lambda=0.97.
\]

Equivalently, it corrects its current estimate by 0.03 times the prediction residual. Memory here is only a vector per actuator. Given a requested displacement g, the policy selects

\[
a^*(g)=\operatorname*{argmin}_{a\in A}\|m_{a,n}-g\|_2.
\]

The meaning-like relation we can measure is specific: which world displacement this actuator symbol predicts and enables. This does not define intrinsic understanding or ordinary Chinese comprehension. The symbols are nonsense actuator labels, not Chinese text.

## 3. Conditional theorem: effect learning and correct action

**Assumptions:** the effect v_a is constant over the calibration period; all actuators are sampled; the observation equation above holds; 0 <= lambda < 1; and the stated estimator and policy are used.

Subtract v_a from the update and iterate:

\[
m_{a,n}-v_a
=\lambda^n(m_{a,0}-v_a)
+(1-\lambda)\sum_{k=1}^{n}\lambda^{n-k}\epsilon_{a,k}.
\]

This identity follows by induction: the next recurrence multiplies each existing term by lambda and adds the newest weighted noise term.

**Noiseless consequence.** With every epsilon equal to zero,

\[
m_{a,n}-v_a=\lambda^n(m_{a,0}-v_a)\longrightarrow 0.
\]

Thus the vector estimate converges to that actuator's actual effect. At lambda = 1 the update ignores observations and the conclusion fails in general; this boundary is checked separately.

**Bounded-noise consequence.** If ||epsilon_{a,k}|| <= eta, the triangle inequality and finite geometric sum give

\[
\|m_{a,n}-v_a\|
\leq \lambda^n\|m_{a,0}-v_a\|+\eta(1-\lambda^n).
\]

This is an error bound, not a claim that persistent noise disappears. A constant-step EWMA generally retains nonzero variance under continuing independent measurement noise.

**Unique action identification.** Let Delta = min_{a != b} ||v_a-v_b|| > 0 and delta = max_a ||m_{a,n}-v_a||. If delta < Delta/2, the nearest-effect policy chooses the correct actuator for every goal g equal to one of the true effects. For the correct actuator a, its estimated distance to g is at most delta. For any competing b,

\[
\|m_{b,n}-v_a\|\geq\|v_b-v_a\|-\|m_{b,n}-v_b\|
\geq\Delta-\delta>\delta.
\]

Therefore the correct actuator is the unique minimizer. Here Delta = sqrt(2). If two actuators have identical effects, their identities are not distinguishable by this effect measurement; only their equivalence class is identifiable.

The bounded-noise worst-case inequality does not guarantee the experimental result with the selected noise amplitude: eta can be 0.8 sqrt(2), greater than Delta/2. The numerical experiment evaluates the specified random-noise distribution rather than claiming every bounded-noise trajectory succeeds.

**New positions and sequences.** Correct selection transfers to any initial position because the environment is translation-invariant by construction. For a sequence of k actuators, endpoint error is at most the sum of their effect-estimation errors, hence at most k delta. Vector addition and translation invariance are supplied assumptions. They are not language composition learned by the agent.

**Status:** demonstrated by the stated analytic argument. The included finite rational checks verify examples of the identity and bound; they are not a universal machine-checked proof.

## 4. What the noise analysis predicts

For independent, zero-mean coordinate noise with variance sigma^2, zero initial estimate, and a unit-length true effect,

\[
\mathbb E\|m_{a,n}-v_a\|^2
=\lambda^{2n}
+2\sigma^2\frac{1-\lambda}{1+\lambda}(1-\lambda^{2n}).
\]

The first term is squared initial bias. The second follows by summing the variances of independent weighted observations in the two coordinates. Uniform noise in [-0.8,0.8] has coordinate variance 0.8^2/3. The ordinary sample mean has mean-squared vector error 2 sigma^2/n in this stationary world.

At n = 128, ordinary averaging is expected to estimate these stationary effects better than this constant-step EWMA. That is consistent with the observed result. There is no surprise advantage to interpret as new physics or special semantics. This experiment does not test changing effects, where recency weighting might have a different tradeoff.

## 5. Executed experiment

Every one of the 24 symbol-to-effect bijections was tested with eight noise replicates, giving 192 worlds using seeds 1001 through 1192. All learners received the same 128 probes per symbol in each world. Evaluation froze the estimates and used all four target displacements from 16 new starts per target, plus all 16 ordered two-actuator sequences from new starts.

The starts share a world's learned parameters and are not independent learning trials. The world is the reporting unit. The two-step task is a consistency check of supplied additive structure, not an independent language benchmark. Counterfactual prediction errors reuse the same learned effect estimates and are not independent corroboration.

| Model or control | Correct action | Mean effect-vector RMSE | Mean two-step endpoint RMSE |
|---|---:|---:|---:|
| Recursive EWMA, lambda 0.97 | 100.00% | 0.081107 | 0.127004 |
| Ordinary sample mean | 100.00% | 0.055715 | 0.087980 |
| Latest observation only | 88.67% | 0.659515 | 1.042205 |
| No observation updates | 25.00% | 1.000000 | 1.414214 |
| Feedback assigned to the wrong symbol | 0.00% | 1.607500 | 2.274044 |
| Oracle with the correct mapping supplied | 100.00% | 0.000000 | 0.000000 |

RMSE is the square root of the mean squared Euclidean vector error within each world, then averaged across worlds. Units are the world's coordinate units. The oracle is a ceiling, not a learned comparator. The latest-observation control retains one observation per symbol; it is not a literally memoryless system. The corrupted-feedback control cyclically routes each observation to the next symbol's estimator, so it tests dependence on the correct association channel. Its failure cannot show that any other architecture lacks understanding.

The full learner selected all four correct actions in every tested world. Ordinary averaging did as well, with approximately 31.3% lower mean effect-vector RMSE. No claim of statistical independence is made for individual starts or paired sequence outputs, and no p-value is used to turn this engineered task into evidence about consciousness.

Frozen criteria:

- **Operational grounding: PASS.** Accuracy >= 90%; advantages over both disconnected and corrupted-feedback controls >= 50 percentage points; mean effect-vector RMSE < 0.25.
- **Advantage over sample mean: FAIL.** Required both at least 5 percentage points higher accuracy and at least 10% lower error. Neither occurred.
- **Intrinsic understanding: UNRESOLVED.** No numerical criterion was specified or awarded for this claim.

## 6. Attempting the missing semantic step

Write T for the mathematical specification of the environment, observation stream, learner, and policy. Let G(S) denote the operational grounding properties just derived. Let U(S) be the proposed additional assertion that system S intrinsically understands the symbols.

The limited derivation has the form T => G(S), with the stated assumptions and accuracy/error qualifications. The requested stronger conclusion needs G(S) => U(S).

**Underdetermination lemma for this specification.** If T is consistent and contains no occurrence of U or axiom constraining it, then T entails neither U(S) nor its negation.

**Proof.** Take any model M satisfying T. Expand it with a predicate U that is true of S to obtain M+. Expand the same M with a predicate U that is false of S to obtain M-. Every sentence of T retains the same truth value because none mentions U. Both expansions satisfy T. One satisfies U(S); the other does not. Therefore neither assertion follows from T. End of proof.

This is an elementary logical observation, not a novel theorem about consciousness. It does not establish that physically identical machines can in reality differ in understanding, or that understanding is nonphysical. It establishes only that this particular formalization leaves the relation unspecified.

Adding an axiom B: forall S, G(S) => U(S) permits a conditional derivation of U(S). The inference is valid; B is then the unresolved semantic sufficiency claim. Defining U to mean G would establish the stipulated operational definition while leaving Searle's disputed sense of understanding unaddressed. Merely calling stable estimates 'meaning' does not discharge this obligation.

The example itself sharpens the problem: the successful mechanism is a small adaptive actuator-calibration table. A claim that it proves broad linguistic understanding would exceed everything tested. Its success provides no criterion for distinguishing that broad capacity from successful low-dimensional calibration.

## 7. Zoo audit and evidence ledger

Only TORTOISE is used as a named Zoo operation. No new animal or retrospective scoring rule is introduced.

**Operation definition before application:** TORTOISE tests anti-circularity. Its input is a proposed derivation and its assumptions. It separates definitions, assumptions, derived statements, and measurements, then checks whether the desired conclusion has been assumed or used as its own evidence. Its output is a list of discharged and missing obligations. Passing an unconditional understanding claim requires a derivation that does not simply assume that grounding equals understanding.

| Operation | Input | Transformation and output | Criterion | Result |
|---|---|---|---|---|
| TORTOISE | T => G(S) => U(S), equations, protocol, outcomes | Separate proved effect-learning statements from the proposed G => U bridge | U must follow without presupposing U or defining away the dispute | Operational branch survives; unconditional understanding claim fails this proof attempt |

| Claim | Evidence status | Basis and limit |
|---|---|---|
| Stable noiseless effect estimates converge for 0 <= lambda < 1 | Demonstrated | Analytic recurrence solution under fixed-effect assumptions |
| A sufficient separation margin gives correct actuator choice | Demonstrated | Triangle-inequality argument with strict half-gap bound |
| This implementation meets the frozen toy grounding criterion | Demonstrated | Executed computation over the specified 192 worlds |
| This recurrence is uniquely EFMW or novel | Rejected for this recurrence | It is ordinary exponential averaging |
| This implementation outperforms the sample mean under the frozen criterion | Rejected | Equal accuracy and higher prediction error |
| The full EFMW framework has been validated or falsified here | Unresolved / not tested | It was not implemented in this experiment |
| Grounded calibration is sufficient for intrinsic understanding | Hypothesis/postulate | Requires a separately justified semantic bridge |
| The Chinese Room has been resolved | Unresolved | The essential sufficiency dispute remains |

Independence and leakage audit: no learned model reads the hidden mapping; the oracle is explicitly separated. No model is updated from evaluation outcomes. All numerical thresholds and seeds were frozen before results. The coordinate representation, additive composition rule, scoring ontology, exploration, and goals are supplied by the designer. Data generation, coding, evaluation, and the interpretation come from one local workflow. This is internal verification, not external replication or scientific validation of EFMW.

## 8. Known-result and philosophical checks

The recurrence is equivalent to the familiar constant-step update of an estimate toward an observed target. Sutton and Barto discuss exponential recency weighting and its distinction from sample averaging [3]. The result should not be labeled a new EFMW learning law.

Searle's original paper considers system-level, robot, and brain-simulation replies and denies that formal computation alone supplies intentionality. Merely showing sensorimotor success therefore does not by itself answer his stated objection [1].

Harnad proposes connecting symbols to nonsymbolic sensory and categorical representations, while explicitly acknowledging that grounding capacities do not guarantee subjective meaning [2]. This toy model is adjacent to that grounding program and much narrower than a full account of cognition. No literature-wide originality claim is made.

## 9. The next obligation

The next decisive step is to specify a proposed semantic bridge B with an independent justification and clear scope: for example, what additional causal organization beyond actuator calibration is claimed to suffice for a particular kind of understanding, and why. A harder benchmark alone would not supply that justification.

For any follow-up test of a concrete mechanism, freeze the environment family, baseline, intervention, metric, and threshold before execution. Success must concern the specified mechanism and survive the relevant controls; failure must count against it. If the bridge simply restates 'passing this test is understanding,' record that as a definition, not independent proof. No follow-up experiment is represented as already run here.

## Reproduction and contents

Run `python3 run.py --output reproduced-results.json` in this directory using Python 3. No third-party package, network connection, credentials, or private user data is required. The recorded run used Python 3.12.14. The program checks the frozen protocol hash before it executes. Its built-in checks exercise 1,024 exact noiseless recurrence cases, 2,048 exact bounded-noise cases, and actuator relabeling equivariance. These checks are explicitly finite.

- `run.py`: complete learner, controls, simulation, and verification checks.
- `protocol.json`: frozen design and thresholds.
- `freeze.json`: local freeze time and protocol hash.
- `results.json`: complete summary and per-world outcomes.
- `verification.json`: packaging and deterministic reproduction check.
- `MANIFEST.json`: file hashes, sizes, and execution record.
- `PROOF-AND-REPORT.md`: this derivation and audit.

## Sources

[1] John R. Searle (1980), *Minds, Brains, and Programs*, Behavioral and Brain Sciences 3(3), 417–424, target article. DOI: https://doi.org/10.1017/S0140525X00005756 . Author text mirrored at https://www.cs.tufts.edu/comp/50cog/readings/searle.html .

[2] Stevan Harnad (1990), *The Symbol Grounding Problem*, Physica D 42, 335–346. https://www.southampton.ac.uk/~harnad/Papers/Harnad/harnad90.sgproblem.html .

[3] Richard S. Sutton and Andrew G. Barto (2018), *Reinforcement Learning: An Introduction*, second edition, section 2.5. Primary text: https://msdnaa.eecs.berkeley.edu/~cs188/fa19/assets/files/SuttonBartoIPRLBook2ndEd.pdf .
