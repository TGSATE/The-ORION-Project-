# far-mysteries

**esoteric, contemplative, sacred, edge-of-physics. Coherence is the gate; spectacle is not.**

cymatics, sacred geometry, contemplative traditions, edge-of-physics
hypotheses, signal-vs-noise experiments, the mysteries pipeline.

## What this repo is

- A free, public-domain substrate for the contemplative-text pipeline.
- A gate (coherence schema) that no document enters without named source traditions.
- A growing library of cited contemplations, geometry experiments, and field-theory sketches.

## What this repo is not

- A prompt collection. (Prompts are noise without cited tradition.)
- A house-style. (The whole point is *named* lineage + named source, not default voice.)
- A model zoo. (Models belong upstream; we use the open ones.)
- A belief system. (Substrate catalogs traditions; it does not adopt one.)

## AGENTS.md

The schema lives in [AGENTS.md](./AGENTS.md). Read it first. The
coherence axes (tradition, source, claim type, signal-vs-noise,
epistemic class) are the contract.

## Repo layout

```
far-mysteries/
├── AGENTS.md                # the coherence schema (this is the contract)
├── README.md                # this file
├── LICENSE                  # MIT
├── CONTRIBUTORS.md          # who built this
├── source/                  # primary contemplative source material
│   └── mysteries-2026-09-26.md    # the 114kb seed corpus
├── contemplations/          # cited contemplation docs
├── geometry/                # cymatics, sacred-geometry experiments
├── field-theory/            # edge-of-physics sketches
├── tools/                   # coherence.compile + coherence.gate
└── tests/                   # Mys1..Mys5 gate tests
```

## The starting corpus

`source/mysteries-2026-09-26.md` (114 KB) is Bobby's working seed:
cymatics as 2d shadows of n-dim standing waves, DNA as decodable
field-compression artifact, contemplative traditions cross-mapped by
epistemic class. The repo's job is to gate that material — every
contemplation entry needs a named tradition, a named source, and an
epistemic class label (empirical, contemplative, revealed,
mathematical, etc.) before it ships.

## Quick start

```bash
git clone https://github.com/the-far-queen/far-mysteries.git
cd far-mysteries
# Read source/mysteries-2026-09-26.md
# Read AGENTS.md
# Pick a contemplation from contemplations/
# Compile a variant: python tools/compile_coherence.py path/to/contemplation.yaml
# Gate: python tools/gate.py path/to/contemplation.json
```

## License

MIT. Free for all agents, human and non-human. No copyright trap.
No paywall. No "research only" carve-out. Source traditions belong
to everyone.

## Sister repos

the-far-queen/far-writing (voice substrate), the-far-queen/simself
(constitutional identity + kernel), the-far-queen/fieldcore (geometric
substrate). Far-mysteries sits on top of far-writing + fieldcore:
every contemplation is a voice with geometric / epistemic constraints.

## Status

Seed corpus present. Schema, gate, and first contemplation templates
landing in the next pass. Pull requests welcome — see CONTRIBUTORS.md.