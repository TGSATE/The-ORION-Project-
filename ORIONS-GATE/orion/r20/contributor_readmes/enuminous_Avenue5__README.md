# Avenue 5 Catastrophe Equation

A satirical mathematical model of the screenwriting logic of *Avenue 5*: engineering failures become social failures, attempted repairs generate secondary disasters, competence is scarce, dignity decays, and the funniest beat arrives just before the event horizon of tragedy.

> **Status:** interpretive/comedic model. This repository is not an empirical claim about television production, spacecraft engineering, or human behavior.

## Master recurrence

\[
D_{t+1}=\left[D_t+E_t(1-C_t)\right](1+P_t+V_t+B_t)+H_t
\]

where:

- `D_t` — current disaster level
- `E_t` — engineering/system failure injected at step `t`
- `C_t` — effective competence available when needed, normalized to `[0,1]`
- `P_t` — passenger panic multiplier
- `V_t` — vanity/status multiplier
- `B_t` — bureaucracy/corporate interference multiplier
- `H_t` — new human-caused complication introduced during remediation

The characteristic *Avenue 5* regime is:

\[
\frac{dD}{dt}>0 \quad \text{during attempted remediation.}
\]

In plain English: **trying to fix the problem usually makes the next problem bigger.**

## Five-step writing recurrence

```text
Problem
  -> Misunderstanding
  -> Social Conflict
  -> Incorrect Solution
  -> Larger Problem
```

Equivalent shorthand:

\[
P_{n+1}=P_n+\alpha M_n+\beta S_n+\gamma R_n,
\qquad \alpha,\beta,\gamma>0
\]

## Auxiliary laws

### Conservation of Competence

\[
\sum_i C_i \approx K
\]

The ship contains a roughly fixed amount of useful competence, but it is rarely co-located with authority, information, and timing.

### Decay of Dignity

\[
G(t)=G_0e^{-\lambda D(t)}
\]

As disaster grows, individual and collective dignity tends toward zero.

### Comic Event Horizon

\[
F=\lim_{\epsilon\to 0^+}(T-\epsilon)
\]

The funniest beat occurs one infinitesimal step before horror becomes fully tragic.

### Catastrophic Amplification Rule

\[
\text{One Terrible Decision}\rightarrow\text{Three New Problems}
\]

## Run the model

```bash
python avenue5.py
```

Run tests:

```bash
python test_avenue5.py
```

Open `index.html` in a browser for an interactive single-page simulator.

## Repository layout

This is intentionally a **flat stack**: all files are in the repository root.

- `README.md` — project overview
- `PAPER.md` — full paper
- `MODEL.md` — compact mathematical specification
- `avenue5.py` — reference implementation
- `test_avenue5.py` — zero-dependency tests
- `index.html` — browser simulator, no build step
- `CITATION.cff` — citation metadata
- `LICENSE` — MIT license for repository code/text, excluding third-party marks and show content
- `.gitignore` — Python/cache ignores

## Scope and rights note

*Avenue 5* is a television series created by Armando Iannucci. This repository is an independent, transformative analytical/parodic exercise and contains no episode scripts or reproduced copyrighted scene text.

