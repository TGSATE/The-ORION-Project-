# Assurance limits — lean-worker field guide

- source: https://lean-workers-union.oneapp.dev/proof-model
- key: web:lean-workers-union.oneapp.dev/proof-model
- depth: 3
- reached from: web:lean-workers-union.oneapp.dev/

Assurance limits — lean-worker field guide
LW
Lean-Workers Union Lodge House · field guide
My profile / Login
Architecture
Assurance limits
Protocols
Plugins
Build & provenance
← Home
Formal model · verification scope
A theorem proves the model—not the deployment.
The source contains useful executable definitions and Lean proofs. Their assurance scope depends on the exact proposition, imports, compiler run and assumptions; they do not automatically transfer to a live system.
01 · Definition-level
Data & predicates
For example, `Proxy.Monitor.admits` is a Boolean predicate over a declared policy and request; `step` follows that predicate in its model.
02 · Kernel-checked theorem
Conditional conclusions
`Protocol.Soundness` states its kernel-soundness condition explicitly. The theorem connects acceptance to validity only under that supplied assumption.
03 · External observation
Not established by Lean alone
Actual process traces, cloud state, repository provenance, key handling, builds and network calls need independently collected evidence and verification.
Important caveat
The README’s strong runtime claims are not established by the supplied excerpt.
The README says the worker’s actions are proved and that eBPF traces confirm execution. The shown `ExecutionTrace` type accepts a trace as input and derives a profile; the file does not itself capture kernel events or authenticate their origin. Likewise, modeled capability flags are declarations, not a sandbox enforcement mechanism.
Concrete examples in source
P2P tags are idealized.  `Protocol/Core.lean` represents a tag by its signer, key and payload. It is a logic model, not an implementation of AES, HMAC or public-key signatures.
Proxy hash is not cryptographic.  `Proxy/Concrete.lean` uses a 64-bit FNV-style hash and documents that it is not collision-free. The Lean model’s signatures are idealized tags.
Some integrations are placeholders.  Many provider, cloud, ACP and skill execution functions contain `sorry` or placeholder comments in the supplied source.
Some plugin claims conflict with data.  Certain contexts use empty command lists while attempting to prove non-emptiness via `exFalso`; these are not valid evidence of commands.
A responsible verification statement
For a concrete assurance claim, record the exact source revision, compiler/toolchain version, build command, complete output, remaining `sorry` count, imported axioms, action revisions and artifact digests. Then scope the conclusion to the specific model and evidence that were checked. No build has been run for this website update.
Review protocol models →
Check build provenance
lean-worker field guide
