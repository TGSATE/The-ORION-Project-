# Plugin catalog — lean-worker field guide

- source: https://lean-workers-union.oneapp.dev/plugins
- key: web:lean-workers-union.oneapp.dev/plugins
- depth: 3
- reached from: web:lean-workers-union.oneapp.dev/

Plugin catalog — lean-worker field guide
LW  Lean-Workers Union Lodge House · field guide
My profile / Login  Architecture  Assurance limits  Protocols  Plugins  Build & provenance
← Home
Plugin contexts · catalog, not runtime inventory
Many names in the registry. Verify each tool before relying on it.
The tree includes plugin interface records and context files, with a mix of real-looking descriptions, empty command lists and placeholders. The catalog is a guide to what is declared—not a claim that every plugin is implemented, installed or running.
Evidence-quality note
Several generated context files have  commands := []  but also state that command lists are non-empty, with proofs ending in  exFalso . Those propositions are inconsistent with the declarations. A file’s “AOK” label or theorem count should not be taken as a successful build without checking its proof and compiler output.
Authoring & proof
Lean / Aristotle / proof tools
aristotle-manager, aristotle-tools, proof-robot, spec-to-proof, lean4-twin, lean4-repl, lean4-block-server, monster-hecke, monster-voa.
Storage & content
IPLD / shmem / paste
dir-to-shmem, index-to-shmem, ipld-car-shmem-client, ipld-car-shmem-server, letta-ipld-memory, shmem-dedup, shmem-optimize, shmem-warm, spool, spool-source, cid-index-lean, erdfa-publish.
Search & indexing
Indexes and retrieval
forge-plugin-tantivy, tantivy-indexer, omnisearch, omnisearch-config, parquet-index, repo-headers, tokenizer, shard-tools.
Coordination & operations
Worker and platform managers
hive-driver, task-manager, zombie-driver, zos-github-manager, zos-noc-manager, zos-plugin-generators, zos-a11y-gui, activity-profile, observer-qa, harbor.
Model-provider & protocol adapters
API type models
Gokujo models common provider interfaces and adapters for Mistral, OpenRouter, Grok, DeepSeek, OpenAI and Claude, plus MCP, tool calling, Agent Client Protocol, AWS, Cloudflare, GitHub and GCP.
Named edge cases
Declared empty or incomplete
forgecode, harbor, monster-voa and spool contexts show empty capability/command lists. Check actual module behavior; do not infer implemented functionality from catalog labels.
What makes a plugin truly ready?
A real implementation or a clearly scoped stub, with honest descriptions.
A build target that includes the module and a reproducible passing build.
Tests for nontrivial behavior—not only reflexive “field equals itself” theorems.
Traceable dependencies, version pins, security boundaries and runtime evidence.
Inspect build inputs →  Read assurance limits
lean-worker field guide
