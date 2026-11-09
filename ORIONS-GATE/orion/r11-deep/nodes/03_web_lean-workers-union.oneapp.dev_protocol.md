# Protocols & runtime — lean-worker field guide

- source: https://lean-workers-union.oneapp.dev/protocol
- key: web:lean-workers-union.oneapp.dev/protocol
- depth: 3
- reached from: web:lean-workers-union.oneapp.dev/

Protocols & runtime — lean-worker field guide
LW  Lean-Workers Union Lodge House · field guide
My profile / Login  Architecture  Assurance limits  Protocols  Plugins  Build & provenance
← Home
Protocol models · included runtime source
Models describe behavior. Services perform work.
The repository puts proof-oriented protocol models next to service code and experimental integration modules. Their presence does not imply the formal model is wired into each runtime component.
Lean · `minimal/Protocol/`
Prover request and certificate model
The model includes admission, shared-key tags, replay protection via caller/nonce pairs, job allow-lists, fuel ceilings, response binding, and a `KernelSound` hypothesis used in the end-to-end result theorem.
The protocol’s tag structure is explicitly idealized; no network transport, real MAC, public-key verification, or key provisioning is implemented by these definitions.
Lean · `minimal/Proxy/`
Reference-monitor and receipt chain model
The abstract monitor models caller authentication, freshness, path/host/executable policy, byte ceilings, receipt logging, chained hashes and dashboard verification.
`Proxy/Example.lean` is a computed example against a deterministic stand-in system. `ProxyReport.lean` writes a model trace; it is not a capture of the host’s actual syscalls.
JavaScript · relay rescue
A mailbox with explicit operational caveats
`DeskServer-rescue/` includes a Node HTTP relay, a Cloudflare Worker router, per-room state module, regression tests and Wrangler configuration. Its README says room state is in memory, not archived, and the invite is trust-on-first-use rather than peer identity.
The rescue documentation also says a separately named patched worker was deployed while the originally named production worker remained inaccessible and unpatched at the time described. That is a source-documented historical status, not a live check.
Rust · `tools/kant-zk-pastebin/`
Paste sharing with content-addressing integrations
The Actix application declares paste, browse, upload, IPFS proxy, plugin and gallery routes. `Cargo.toml` lists Actix, serde, SHA-256, CBOR/IPLD and a local `rust-unixfs` path dependency.
The `README.md` and source differ in maturity and behavior; inspect the actual handler and storage implementation before asserting all API descriptions or IPFS guarantees.
Cross-check before relying on runtime status
The dump contains historical relay logs and a rescue report, not live service probes. No deployment has been verified in preparing this guide. Use the source files and an independently recorded test/build run as your evidence.
Read model assurance limits →  Inspect build sources
lean-worker field guide
