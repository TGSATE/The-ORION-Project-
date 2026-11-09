# Backrooms Protocol: EFMW Filmic Analysis

A compact mathematical formalization of filmic interpretation under unstable spatial, temporal, perceptual, and mnemonic coherence.

**Status:** conceptual mathematics / analytic model. This repository does not claim that *Backrooms* demonstrates EFMW physics. It treats a filmic world as a dynamical observation system and formalizes the interpretive problem faced by an embedded observer.

## Core system

Let

\[
\mathcal B=(X,T,O,M,H,A,\Pi)
\]

with state space \(X\), temporal relation \(T\), observation map \(O\), memory operator \(M\), hypothesis space \(H\), action set \(A\), and update operator \(\Pi\).

At step \(t\):

\[
x_t\in X,
\qquad
o_t=O(x_t,a_{t-1}),
\qquad
m_t=M(m_{t-1},o_t),
\qquad
h_t=\Pi(h_{t-1},o_t,m_t).
\]

The observer chooses

\[
a_t=\pi(h_t,m_t),
\]

and the world evolves by

\[
x_{t+1}=F(x_t,a_t,\eta_t).
\]

Thus the minimal recursive loop is

\[
x_t\to o_t\to m_t\to h_t\to a_t\to x_{t+1}.
\]

## Backrooms condition

Ordinary filmic/world coherence assumes approximate preservation of spatial identity, temporal order, observation, and memory:

\[
\mathcal C_t
= w_s C_s(t)+w_\tau C_\tau(t)+w_o C_o(t)+w_m C_m(t),
\qquad
\sum_i w_i=1.
\]

A Backrooms regime occurs when

\[
\mathcal C_t<\theta_C
\]

while the observer continues to require a predictive model \(h_t\).

Define decoherence pressure

\[
D_t=1-\mathcal C_t.
\]

The interpretive problem is therefore

\[
\min_{h\in H}\;L(h;o_{0:t},m_{0:t})+\lambda K(h)
\]

subject to

\[
D_t\gg 0,
\]

where \(L\) is predictive error and \(K\) penalizes gratuitous explanatory complexity.

## Invariant-first protocol

Do not first ask what the world *is*. Estimate what survives transformation.

For candidate observable \(q:X\to\mathbb R^n\) and transformation \(g\), define

\[
\Delta_q(g,x)=\|q(gx)-q(x)\|.
\]

Then

\[
q\in\mathcal I_\varepsilon
\iff
\mathbb E[\Delta_q(g,x)]\le\varepsilon.
\]

The experimentally defensible ontology at time \(t\) is bounded by the current invariant set:

\[
\Omega_t\subseteq \sigma(\mathcal I_\varepsilon).
\]

## Misattribution / premature coherence

Let \(p_t(h)\) be belief over interpretations. An associative system can collapse onto a nearby but unsupported hypothesis:

\[
h_t^*=\arg\max_h p_t(h).
\]

Confidence is unjustified when

\[
p_t(h_t^*)-p_t(h_t^{(2)})<\delta
\]

but the system emits \(h_t^*\) as certain.

After contradiction \(e\), a local repair changes only a nearby coordinate:

\[
h' = R_{\mathrm{local}}(h,e),
\]

whereas the Backrooms Protocol requires global reopening:

\[
p_{t+1}(h)\propto p(e\mid h)p_t(h),\qquad h\in H.
\]

If source confidence falls below \(\theta_s\), attribution is suspended:

\[
\max_h p_{t+1}(h)<\theta_s
\implies
\text{VERIFY}.
\]

## Filmic analysis functional

For a film sequence \(S=(f_1,\ldots,f_N)\), define feature streams

\[
z_t=(s_t,\tau_t,o_t,m_t,c_t),
\]

representing spatial continuity, temporal continuity, observational reliability, mnemonic reliability, and causal continuity.

The Backrooms Filmic Index is

\[
\operatorname{BFI}(S)
=\frac1N\sum_{t=1}^N
\left[
\alpha(1-s_t)+
\beta(1-\tau_t)+
\gamma(1-o_t)+
\mu(1-m_t)+
\kappa(1-c_t)
\right],
\]

with nonnegative weights summing to one.

Recursive interpretive load is

\[
R(S)=\sum_{t=2}^N d(h_t,h_{t-1}),
\]

and epistemic instability is

\[
E(S)=\sum_{t=2}^N
\mathbf 1\!\left[
\arg\max_h p_t(h)\ne
\arg\max_h p_{t-1}(h)
\right].
\]

A strongly Backrooms-like sequence has simultaneously

\[
\operatorname{BFI}(S)\uparrow,
\qquad
R(S)\uparrow,
\qquad
E(S)\uparrow.
\]

## EFMW filmic recursion

The compact form is

\[
\boxed{
\mathcal R_t:
(x_t,o_t,m_t,h_t,a_t)
\mapsto
(x_{t+1},o_{t+1},m_{t+1},h_{t+1},a_{t+1})
}
\]

with coherence residual

\[
\boxed{
\rho_t=
\|\widehat o_t(h_{t-1})-o_t\|
+\lambda_m\|\widehat m_t-m_t\|
+\lambda_\tau\,d_\tau(t,t^-)
}
\]

and trigger

\[
\boxed{
\rho_t>\theta_\rho
\implies
\text{REOPEN}(H),\;\text{TEST}(\mathcal I),\;\text{VERIFY}(\text{source}).
}
\]

That implication is the **Backrooms Protocol**.

## Interpretation boundary

The mathematics describes an analysis procedure for narratives and observers under coherence failure. It is not empirical evidence for anomalous spacetime, altered physical laws, or EFMW as a physical theory.

## License

MIT. See `LICENSE`.
