# Independent reproduction protocol

An external reproducer should:

1. unpack the exact release bytes;
2. verify `MANIFEST.sha256`;
3. record OS, architecture, Python, pytest, cryptography, and Lean versions;
4. run `./reproduce.sh` without modifying source;
5. retain complete stdout/stderr and exit codes;
6. compute the source ZIP / release bundle SHA-256 independently;
7. emit a signed or otherwise attributable reproduction receipt identifying the reproducer and environment.

A self-run does not satisfy this gate. `INDEPENDENT_REPRODUCTION_NOT_EARNED` remains until a genuinely separate environment/principal produces its own receipt.
