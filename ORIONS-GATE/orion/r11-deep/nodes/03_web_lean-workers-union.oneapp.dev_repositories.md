# Build & provenance — lean-worker field guide

- source: https://lean-workers-union.oneapp.dev/repositories
- key: web:lean-workers-union.oneapp.dev/repositories
- depth: 3
- reached from: web:lean-workers-union.oneapp.dev/

Build & provenance — lean-worker field guide
LW  Lean-Workers Union Lodge House · field guide
My profile / Login  Architecture  Assurance limits  Protocols  Plugins  Build & provenance
← Home
Source inventory · toolchains · external inputs
Read the build declarations before trusting the build story.
This inventory is extracted from the provided files. It is not a complete lockfile audit, a live repository lookup, a verified compiler run, or proof that all listed systems are deployed.
The dump has overlapping and inconsistent build descriptions
The README says there is no toolchain or Lake project in  minimal/ , while the supplied tree includes  minimal/lean-toolchain ,  lakefile.toml , a manifest, and Nix/pipelight configurations. Treat actual checked-in files and reproducible CI logs as authoritative for a specific revision.
Lean & Lake
Declared versions and packages
Toolchain:   minimal/lean-toolchain  names  leanprover/lean4:v4.28.0 .
Lake project:   minimal/lakefile.toml  declares Mathlib v4.28.0 from  leanprover-community/mathlib4 .
Lock data:   minimal/lake-manifest.json  lists Mathlib and inherited packages including plausible, LeanSearchClient, import-graph, ProofWidgets4, aesop, quote4, batteries, and lean4-cli.
Other setup:  root  flake.nix  declares nixpkgs, flake-utils, Lean, Mathlib, Gokujo and pipelight inputs.
Rust service
Pastebin dependency declarations
tools/kant-zk-pastebin/Cargo.toml  declares Actix Web, serde, Tera, chrono, sha2, ciborium, ipld-core, multibase, multipart, OpenAPI tooling, and other crates. It also names local path dependencies:  vendor/rust-ipfs/unixfs  and  erdfa-publish .
The supplied tree does not include the Cargo.lock or the complete local vendor source, so resolved versions and transitive source provenance cannot be fully inventoried here.
Build automation
CI and deployment references
The supplied  .github/workflows/lean.yml  references checkout, Nix install and cache actions; shell steps install Lean tools, attempt staged Lake builds and a Gokujo check, and include a pipelight deployment job with a secret token.
The workflow content itself contains apparent issues (including variable-name mismatches and a schedule key nested under a job), so do not infer successful CI or deployment from the YAML’s presence.
External tools & code
What a fuller provenance record needs
Exact source revision and clean working-tree status for every repository.
Resolved Rust dependency lockfile plus local vendor/submodule commits.
Lean compiler build logs, Lake manifest, and exact CI action SHAs.
Artifact digests and an attestation binding source, toolchain, build procedure and output.
Contributor notices from the actual source history and license files.
Avoid mixing roster records with dependencies
The tree includes a registry of project names and plugin descriptions, plus formal API models for GitHub, Cloudflare, AWS and model providers. Those names do not automatically mean each API, provider or project is a build dependency. Consult the package manifests and import graph for a concrete target.
Review runtime modules →  Browse plugin catalog
lean-worker field guide
