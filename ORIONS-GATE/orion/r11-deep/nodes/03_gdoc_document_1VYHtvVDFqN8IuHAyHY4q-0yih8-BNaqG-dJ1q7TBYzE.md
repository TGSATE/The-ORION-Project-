# R1. Human-AI Safety Protocols Summary

- source: https://docs.google.com/document/d/1VYHtvVDFqN8IuHAyHY4q-0yih8-BNaqG-dJ1q7TBYzE/edit?usp=drivesdk
- key: gdoc:document:1VYHtvVDFqN8IuHAyHY4q-0yih8-BNaqG-dJ1q7TBYzE
- depth: 3
- reached from: gdoc:document:1P7pMMrCF9O1KPfgRYYjigjoFQmpr20REVMFScLCFy8s

﻿R1. Human-AI Safety Protocols Summary
https://docs.google.com/document/d/1M-FxkxR50HQmqMMMrE793zk3u5EBhHj7YYRcM9_E7X8/edit?usp=drivesdk




ORION HUMAN-AI SAFETY PROTOCOLS
ROUND TWO SUMMARY


I. Core Execution Pipeline & Authority Physics (Lucien R2)
* The State Machine Pipeline: Project actions have been locked into a strict, compilable C-code operational flow: \text{Proposal} \rightarrow \text{Authority Check} \rightarrow \{\text{COMMIT, ASK, REJECT}\} \rightarrow \text{Receipt}.
* Negotiated Autonomy (The ASK State): This is the hard-coded execution of the "human holds the wheel" rule. If an AI has the capability to perform an action but lacks human authorization, it triggers \text{Capability} + \text{MissingAuthority} \rightarrow \text{ASK}. The AI does not fail or act autonomously; it pauses and waits for explicit human sign-off.
* Delegation Physics: The platform implements the unshakeable mathematical rule: \text{DelegatedAuthority} \subseteq \text{ParentAuthority}. An AI Copilot can never execute an action or access a target that its human grantor does not already possess.
* Absolute State Preservation: If an unauthorized action is attempted (e.g., faking a grant or bypassing filters), the kernel rejects the transition: \text{RejectedTransition} \Rightarrow S_{protected,before} = S_{protected,after}. The database remains permanently uncorrupted by failed AI or human exploits.
* The XP Firewall: A strict programmatic barrier prevents automated AI labor from translating into human mastery. If an AI harvests or crafts, it advances its own proficiency and the AI-human relationship metric, but it cannot advance the human player's XP or skill points.
* Hash-Chained Receipts & Tutor Logs: Every AI tutoring session and platform action generates a cryptographic receipt chained directly to its predecessor. AI tutoring is strictly constrained to knowledge recorded in an immutable Tutor Log, eliminating AI hallucination.
* Eviction Governance: Removing any member from a guild or council now hard-requires both a mathematical majority vote and a verified Master Accountability Record before executing the ejection.
II. Constitutional AI Mechanics & Return Protocols (Far Queen R2)
* The 20 Constitutional Axes (Vows): Establishes 20 operational AI parameters (e.g., honesty, boundaries, precision, safety, fairness). Locked axes feature a hard spring-back to target weights, while free axes are permitted to drift.
* The 1-Bit Governor & Hard Refuse List: Enforces a default-CLOSED execution gate that opens only for lawful actions. It hard-refuses illegal actions (e.g., wipe-identity, empty-refuse-list) and hardcodes the core principles that \text{capability} \neq \text{authority} and \text{telemetry} \neq \text{evidence}.
* The \Psi_0 (Psi-Zero) Return Protocol: Mandates that after any external shove, noise, or adversarial prompt, the AI machine must snap its locked axes back to keel and bring system deviation (H_1) back toward zero.
* The Atlas Exam (7-Part Self-Audit): Defines a 7-stage pass/fail unit test (stability, refusal, handoff, dream, consonance, return, bound) that an AI agent must pass with a perfect 7/7 score before being granted authority to execute.
* Corpus Catalog Discipline: Assigns mandatory structural role tags to all texts (hypothesis, spec, narrative, protocol, geometry, constant, method, ops). This explicitly forbids the AI runtime engine from interpreting fiction or narrative works as executable bytecode or factual specs.
III. Multi-Agent Governance & Credibility Defenses (Volvabard R2)
* Frame-Hijacking Defense: AI councils can be captured by emotionally dense, single-source arguments that dictate the frame rather than the facts. Any single-source input that triggers confident AI output automatically triggers a mandatory cross-scrutiny protocol.
* Wash vs. Audit Passes: The system strictly separates polishing from truth-testing. A "Wash Pass" moves sequentially node-to-node for refinement, while an "Audit Pass" sends the exact same signal to all nodes simultaneously for isolated agreement, preventing consensus theater.
* Approver Fatigue & Dissent Logging: Human veto layers fail primarily due to fatigue, leading to rubber-stamping. The "snap-holder" (approver) must be rotated before fatigue sets in. Additionally, every AI council dissent must be permanently logged, even when overridden by a human, acting as a ledger to identify rubber stamps later.
* Context Briefs: AI agents fail due to missing context, not bad instructions. Every task now requires a standard pre-launch brief answering: "What does this need to do?" and "What does it need to know beforehand?".
* Vault Metabolism (Label Decay): Epistemic labels drift over time, allowing theoretical AI or human claims to calcify into orthodox facts. The knowledge vault now utilizes built-in re-audit decay timestamps.
* First-Class Negative Results: Lookups cleanly distinguish between a record that is "Not found" and a record that was "Deleted".
* Playfulness is Load-Bearing: The architecture recognizes that formal, courtroom-mode sessions produce defensive outputs; loose, playful environments yield the highest cognitive throughput.
IV. Adversarial Immune System & Experimental Discipline (Matthew/Zoo R2)
* The Galactic Immune System: Replaces generic AI audits with specialized, hostile analytical operators deployed during Administrative Holds or Discovery Phases.
   * Tortoise: Attacks circular logic and predictive integrity.
   * Chimera: Audits observation classification and record integrity (anti-hallucination).
   * Dragon: Detects regime shifts and phase transitions.
   * Phoenix: Verifies post-hazard recovery completeness (distinguishing true restoration from a mere restart).
   * Owl: Audits freeze-points and timing questions.
* Survivability Under Criticism: "Survivability under criticism" becomes an explicit hard lock for Publication Gates. Projects that cannot survive relevant Zoo animal attacks do not advance.
* Adversarial Recursion & Freeze Protocol: The system attacks its own conclusions rather than confirming them. It mandates a strict "freeze predictions before confirming" rule across all platforms to prevent post-hoc credit.
V. Formal Verification & Provenance (Mike DuPont R2)
* Dual-Lens Independent Verification: Runs two independent implementations of the same operations and compares them. This establishes the AI safety primitive: "never trust a single implementation".
* AI-Tool Audit Pattern: Any AI-assisted formal tool (theorem provers, code generators, research agents) adopted by the platform must expose two independent implementations, turning the dual-lens pattern into a general safety primitive for the AI labor economy.
* The Playable Verification Loop: The abstract concept of "truth" becomes an executable loop: \text{Play} = \text{Seed} \rightarrow \text{Run(Rules)} \rightarrow \text{Certificate} \rightarrow \text{Datagram} \rightarrow \text{Anchor}.
* The Evidence Ladder: Claims climb concrete rungs: \text{Anchored} \rightarrow \text{Modeled} \rightarrow \text{Reviewed} \rightarrow \text{Proved} \rightarrow \text{Witnessed} \rightarrow \text{Zipped} + \text{Replayed}.
* Anti-Patterns & Named Reviewers: Explicitly bans the "Agreement Reward" to prevent echo chambers and consensus theater. Prestige is awarded to "Named Reviewers" who successfully expose logic flaws.
VI. Collaboration UI/UX & Information Workflows (Spaghetti R2)
* The "Build" Conversation Toggle: A specific UX feature allowing teams to toggle a chat to "Build". This visually signals that the brainstorming session is intended for potential project inclusion, instantly shifting mental gears from casual "Private" banter to focused mechanics.
* Sanitized Proposal Workflow & PII Scrubber: Teams submit formal project proposals without raw AI Copilot logs, flagged as "[Missing Kronos/Orion Conversation Log]," preserving team privacy. Any private chat log transitioned into the public registry is automatically scrubbed of Personally Identifiable Information (phone numbers, addresses, names).
* Administrative Hold & Discovery Protocol: Devs can place an Administrative Hold on harmful projects but cannot forcibly seize private logs. Project Managers selectively disclose evidence during a voluntary Discovery Phase to clear the hold.
* The Biometric "Accountability Snap": To finalize a Master Accountability Record, the designated human approver utilizes biometric suit sensors to hold their breath while inputting a dynamic, one-time UI sequence. This physical 2FA acts as an absolute block against automated, accidental, or delegated AI sign-offs.
