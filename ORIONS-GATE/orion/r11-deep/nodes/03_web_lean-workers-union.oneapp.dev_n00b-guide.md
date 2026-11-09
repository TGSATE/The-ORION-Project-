# Beginner guide — lean-worker field guide

- source: https://lean-workers-union.oneapp.dev/n00b-guide
- key: web:lean-workers-union.oneapp.dev/n00b-guide
- depth: 3
- reached from: web:lean-workers-union.oneapp.dev/

Beginner guide — lean-worker field guide
LW
Lean-Workers Union Lodge House · field guide
My profile / Login
Architecture
Assurance limits
Protocols
Plugins
Build & provenance
Beginner guide
← Home
Start here · no Lean experience required
A beginner’s guide to Lean and lean-worker.
Lean is a programming language and proof assistant. You write definitions and propositions, then ask Lean’s kernel to check that a proof term establishes a proposition. This page introduces the ideas without assuming that every project claim has already been independently verified.
First, keep the claim in scope
A checked Lean theorem is evidence about its stated definitions and assumptions. It is not, by itself, proof that an AI agent is deployed, that its real-world actions are captured, or that every operation is safe.
01 · Definition
Describe a thing
A definition gives Lean a name for data or a computation. For example, a membership record might contain an identifier and a status.
02 · Proposition
State what should hold
A theorem states a proposition—for example, that looking up a newly registered identifier returns the record that was added.
03 · Proof
Ask Lean to check it
A proof explains why the proposition follows. Lean checks the resulting proof term, subject to the definitions, imports, axioms, and compiler/toolchain used.
A tiny example
Prove a simple fact
theorem add_zero_example (n : Nat) : n + 0 = n := by
rfl
Nat  means natural numbers. The theorem says adding zero leaves a natural number unchanged.  rfl  works here because both sides reduce to the same expression by computation.
Learn by checking one file
A careful first workflow
Find the project’s toolchain and build instructions. In this supplied tree, the build page reports a Lean toolchain and Lake project under  minimal/ ; this conflicts with the pasted N00b guide’s claim that no Lake project exists.
Open one small Lean file and identify its imports, definitions, theorem statement, and proof.
Use the build command documented for the exact project revision rather than assuming  lean *.lean  checks every file. Wildcards are not recursive and may not respect module dependencies.
Read the complete compiler output. A command that prints theorem counts is only counting matching text; it does not compile or validate those theorems.
Record the source revision and Lean version alongside any result so another person can repeat the check.
Review build and provenance notes →
Important: check before repeating
The pasted guide makes claims that need verification.
The theorem counts conflict
The pasted guide says both 78 and 82 theorems. A grep count can miss declarations, count the wrong files, or count text that is not a successful proof. Check the actual files and full build output for a specific revision.
“Every action is proved” is too broad
The formal models described in this field guide do not establish that a deployed agent’s real actions are intercepted, observed, or checked. See  assurance limits .
Build instructions disagree
The pasted guide says there is no Lake project and recommends  lean *.lean ; the supplied inventory includes a Lean toolchain and Lake configuration. Resolve the discrepancy against the exact checkout before building.
Treat relay instructions as unverified
Do not send secrets, task keys, private data, or proof material to a relay unless you have independently confirmed its endpoint, security design, access policy, and intended use. The protocol model described here is not a production cryptography or deployment guarantee.
Choose a small learning task
Ask a precise question
Start with a definition or theorem already present in the checked-out project. Try to explain its inputs and conclusion in plain language. Then make one small change and see whether the project’s documented build catches it.
The pasted guide names task labels such as  agent-a-wave-vi , but their availability and contents have not been verified here. Confirm task files and the current proof-work specification in your own checkout before choosing a task.
Next pages
Keep exploring
Architecture: what the repository tree contains →
Assurance limits: what formal proofs do and don’t show →
Protocols and runtime source →
Build inputs and provenance →
lean-worker field guide
·
Beginner overview based on the supplied project descriptions; not an independently verified build.
