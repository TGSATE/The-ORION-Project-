# Stop-First Controller v0.2

This reference controller supervises an untrusted **child-process proposer**.
The trusted parent owns its deadline, spend budget, protected state, receipts,
operator halt, child termination, and the tool commit gate. No inference API,
shell command, or network action is built in.

## Run and verify

Requires Python 3.10+ and a POSIX environment. It uses only the standard library.

```sh
python3 verify.py
python3 controller.py supervise --journal run.jsonl --proposer-script examples/proposer.py
python3 controller.py replay run.jsonl
```

The operator supplies a Python proposer script. It writes newline-delimited JSON
to stdout. The controller starts it as a child using `python -I`, with stdin
closed and stderr discarded. The script is **not** a security sandbox: it runs
under the same OS identity and can exercise whatever privileges that identity
has. The reference trust model confines the adversary to its output stream and
its own liveness. Use a separate UID/container plus resource limits before
running truly hostile code.

The older `run` mode still accepts a pipe or socket input FD. `supervise` is the
new child lifecycle path. A normal child EOF records `MODEL_EOF`; an externally
SIGKILLed child records `CHILD_SIGKILL`; another nonzero exit records
`CHILD_FAILED`. Deadline expiry records `DEADLINE`, and the parent SIGKILLs and
reaps a child that is still running. A parent SIGKILL does not guarantee child
cleanup on every OS; process-tree containment remains an open obligation.

The monotonic deadline is sampled by the parent independently of model output.
The proposal ordinal advances for every complete frame. Each admitted byte
consumes a budget unit and a committed write consumes ten more. Limits are
bounded by policy. Operator SIGTERM/SIGINT and a separate `--stop-fd` take
priority at control checkpoints. These are cooperative checkpoints around
synchronous receipt I/O; no hard real-time stop latency is claimed.

## Write-ahead tool gate

The only tool is a fixed uppercase transform, `tool_upper`, operating on a
string of up to 128 characters. It runs in a separate fixed Python worker with
bounded input, output, and deadline. It has no intended external side effect.
A proposal has exactly `seq`, `op`, `key`, `value`; keys are `a`, `b`, or `c`.
For example:

```json
{"seq":1,"op":"tool_upper","key":"a","value":"hello"}
```

The ordering is mechanically visible in receipts:

1. Admit bytes and fsync a `TOOL_INTENT` frame receipt, leaving values unchanged.
2. Invoke the fixed worker. Abort or halt on worker failure, operator stop, or deadline.
3. Validate its output and fsync `TOOL_RESULT` without changing values.
4. Replay the journal **strictly to the current exact head**, checking semantic
   transitions and equality with the live state.
5. Recheck stop. Fsync `TOOL_COMMIT` bound to that result receipt's hash before
   publishing the protected value.

If replay fails after the worker returns, execution fails closed and no commit
receipt is issued. A result receipt without a commit does not change protected
values. A normal `put` is the legacy direct internal state transition and uses
its own durable receipt. Neither operation touches external files. A future
external-effect tool needs an additional transactional effect protocol and
recovery reconciliation; this sandbox does not claim to roll back external
side effects or prevent a malicious same-UID worker from making them.

Offline replay recomputes every transition without the proposer or worker. It
validates hash continuity, recorded states, the deterministic uppercase result,
and that `TOOL_COMMIT` binds to the immediately preceding receipt. Strict replay
rejects a torn tail; `--recover-tail` reconstructs only the complete valid prefix.
Recovery is always non-executable. Whole-receipt truncation needs an independent
`--expected-head` checkpoint to be detectable. Journal hashing does not
establish authorship or stop a coordinated rewrite of history.

## Evidence and ceiling

`verification.json` records the local run: **41 behavioral tests passed and
11/11 targeted source mutations were killed**. Tests include externally killing
the child after a legal write, terminating a stalled child on deadline, child
floods, write-ahead ordering, replay failure injected after worker return,
worker timeout, operator stop before commit, rehashed illegal result, and commit
binding. Mutations remove SIGKILL classification, the write-ahead staging
boundary, and the post-worker replay gate, along with eight earlier guards.

The tests establish the behavior of this implementation under their fault
model. They do not prove hostile-code containment, power-loss durability,
independent replay semantics, secure file ownership, bounded OS scheduling, or
real token billing. No bash or network tool has been added.
