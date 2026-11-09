# Architecture — lean-worker field guide

- source: https://lean-workers-union.oneapp.dev/capabilities
- key: web:lean-workers-union.oneapp.dev/capabilities
- depth: 3
- reached from: web:lean-workers-union.oneapp.dev/

Architecture — lean-worker field guide
LW  Lean-Workers Union Lodge House · field guide
My profile / Login  Architecture  Assurance limits  Protocols  Plugins  Build & provenance
← Home
Architecture · file-tree overview
One repository, several very different layers.
The tree mixes formal descriptions, model-level theorems, executable Rust/JavaScript components, build tooling and interface catalogs. A module existing in the tree is not evidence that it is built, deployed, or connected to a live system.
Read the claims at the right level
Lean theorems establish propositions about Lean definitions. They do not by themselves instrument a running agent, validate external telemetry, establish cloud deployment, or execute a provider API call. Several integrations explicitly contain placeholders and unfilled proofs.
01 · Twin & tool model
`minimal/` and `minimal/RequestProject/`
Agent state, capabilities, environment, constraints, memory, skill lists, credit counters, command-result structures, tool-call provenance and parsed execution-trace models.
The files include specific theorems, but some embedded records are hand-authored examples. The tree alone cannot show whether a trace was captured from a real process.
02 · Peer protocol
`minimal/Protocol/`
An idealized model of authenticated prover calls, nonce freshness, allow-listed executables, fuel budgets, certificates, caller acceptance and cross-check outcomes.
Its `Tag` model carries the key and payload directly; the source explicitly describes this as idealized, not production cryptography.
03 · Logging proxy model
`minimal/Proxy/`
A reference-monitor model that gates file/network/process calls, records receipts, chains hashes, and lets a dashboard model verify journal entries.
The concrete example uses a 64-bit FNV-style hash and an idealized signature in the Lean model; its own comments caution that the hash is not collision-free.
04 · Gokujo tooling
`minimal/Gokujo*` and `tools/gokujo/`
A single-file CLI concept for scanning, building, checking, infrastructure generation and agent workflows, plus provider, protocol, cloud, GitHub, skill and DAO models.
The documentation makes broad capability statements. Check specific source and actual build output before treating those statements as verified product behavior.
05 · Plugin contexts
`contexts/plugins/` and `minimal/`
Plugin interface records and small theorems about declared names, capabilities and versions. Files are largely repetitive context declarations.
Some contexts declare empty command lists yet claim non-empty commands through `exFalso`; those statements cannot be true as written. See the  catalog notes .
06 · Service sources
Pastebin and relay rescue
`tools/kant-zk-pastebin/` includes an Actix/Rust service, IPFS/DASL-related modules and UI handlers. `minimal/DeskServer-rescue/` contains a Node relay and Cloudflare Worker source plus regression tests.
The rescue README explicitly describes operational limitations and deployment uncertainty. Source inclusion is not a deployment attestation.
Review assurance limits →  Inspect build inputs
lean-worker field guide
