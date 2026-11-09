# Corpus synthesis: project Wikipedia files

Date: 2026-10-05  
Source: 74 Wikipedia print PDFs in `/workspace/artifacts`  
Method: inventory, page counts, and definitional leads (first pages). Not a substitute for the full articles.

## Inventory

74 PDFs. Near-duplicates: `Reason - Wikipedia.pdf` and `Reason - Wikipedia (1).pdf` (same lead, sizes differ by 78 bytes). Parenthetical re-downloads also exist for Complex analysis and Divinity.

Heaviest files by page count: Jesus (101), Human (98), Psychology (91), Epistemology (79), Philosophy (72), Knowledge (70), Deep learning (70), Neural network (machine learning) (68), Evolutionary psychology (66), Metaphysics (64), Mathematics (64). The corpus is weighted toward the person, knowledge, and computation, not toward specialist engineering.

## Clusters

1. Epistemic core — Knowledge, Epistemology, Empiricism, Coherentism, Experiential knowledge, Reason, Logic, Critical thinking, Rigour, Axiom, Mathematical proof, Abstraction, Introspection, Perception, Memory, Learning.
2. Cognitive architecture — Cognition, Intelligence, Self-awareness, Creativity, Problem solving, Planning, Psychology, Animal cognition, Insect cognition, Ethology, Behavioral ecology, Evolutionary psychology.
3. Formal instruments — Mathematics, Discrete mathematics, Complex analysis, Philosophy of mathematics, Computational complexity, Mathematical optimization, Information theory, Computer science.
4. Natural constraint — Physics, Chemistry, Thermodynamics, Primordial black hole; Pathology as biomedical border.
5. Making and machines — Engineering, Mechanical engineering, Electrical engineering, Systems engineering, Cybersecurity engineering, Cybersecurity and Infrastructure Security Agency, Technology, Machine, Molecular machine, Software, Network topology, Neural network (machine learning), Deep learning, Superintelligence.
6. Human and institutional scale — Human, Sociology, Academic discipline, Science.
7. Order and failure — Sovereignty, Criminal law, Criminal procedure, Crimes against humanity, Corruption.
8. Wisdom and theology — Wisdom, Sophia (wisdom), Philosophy, Metaphysics, God, Jesus, Trinity, Divinity, Heavenly host.

## Integrated spine

A knowing agent acquires, justifies, abstracts, applies, and governs knowledge under physical and institutional constraint, and that capacity fails in characteristic ways.

- Knowledge is awareness of facts, familiarity, or skill. Propositional knowledge is widely treated as true belief set apart from opinion by justification; Gettier cases contest that formula. Sources named in the files: perception, introspection, memory, rational intuition, inference, testimony.
- Justification structures in the files: foundationalism (basic sources), coherentism (mutual support among beliefs; the Coherentism file), infinitism (mentioned under Knowledge). Empiricism holds that knowledge arises from sensory experience. Experiential knowledge names the tacit, non-propositional complement.
- Cognition is the process layer. Intelligence, in the Intelligence file, is the capacity for abstraction, logic, understanding, self-awareness, learning, reasoning, planning, creativity, critical thinking, and problem-solving, applied as adaptive behavior. Animal and insect cognition, ethology, behavioral ecology (Tinbergen’s four questions), and evolutionary psychology place that capacity on a graded, fitness-constrained biological scale.
- Formal control: an axiom is a starting point, classically self-commending and in modern logic stipulated. Proof is derivation. Rigour makes derivation checkable. Abstraction filters a phenomenon to what a purpose requires. Mathematics, discrete mathematics, optimization, complexity, and information theory are the instruments. Philosophy of mathematics keeps open whether mathematical objects are mind-independent.
- Natural constraint: physics studies matter, motion, energy, and force; thermodynamics adds heat, work, and entropy, so directed work has an irreversible cost; chemistry studies composition and transformation. A machine, including a molecular machine, is a constrained arrangement that converts energy into directed function. Technology is the cumulative artifact of that conversion.
- Engineering is design under constraint to meet a specified need. Systems engineering integrates subsystems. Network topology distinguishes physical interconnection from logical data flow. Software is the logical machine. Cybersecurity engineering and the CISA file add the adversarial condition: systems are not used only by cooperative agents. Deep learning and neural networks are statistical function approximators. Superintelligence is a hypothesized extension of the same capacities (learning, planning, self-improvement), not a result established by the other science files.
- At human scale, academic disciplines are socially recognized partitions (journals, societies, departments), conventionally humanities, sciences, formal sciences, and sometimes social sciences. Science is the institutionalized empirical method. Sociology studies the collective layer.
- Order and failure: sovereignty is ultimate authority in a domain; criminal law, procedure, and crimes against humanity are formal responses to harm; corruption is capture of public function by private interest. Pathology supplies a parallel vocabulary — cause, pathogenesis, structural alteration, functional consequence — useful as analogy, not identity.
- Wisdom (sapience), in the Wisdom file, is wit joined to virtue: expert tacit and experiential knowledge balancing intrapersonal, interpersonal, and institutional interests toward a common good. It may be a trait, a context-bound process, or wise behavior. Sophia historically moves from skill to sound judgment and, in Orthodox and Catholic usage, can name divine wisdom identified with the Word or the Holy Spirit. Philosophy is the systematic love of that wisdom and the critique of its own assumptions.
- Theological pole, kept distinct from empirical claims: God as supreme being and creator in monotheistic systems; the Trinity as one essence in three persons (Father, Son, Holy Spirit); Jesus as the historical and doctrinal center; Divinity as the quality of being divine; the heavenly host as an ordered company. These files supply a personal account of ultimate reality. They are not entailed by the physics or cognition files.

## Limits

Wikipedia leads are tertiary, compressed, and neutrality-edited. Print extraction mixes captions with prose. Reason is duplicated. Primordial black hole and insect cognition are specialist leaves. Do not treat the Superintelligence or theology files as forecasts or as proofs. Contested definitions (knowledge, intelligence, God) are reported as controversies, not settled.

## Operational use

Use the set as a controlled vocabulary and crosswalk. Load-bearing nodes: Knowledge, Epistemology, Reason, Logic, Rigour, Abstraction, Intelligence, Learning, Science, Engineering, Systems engineering, Information theory, Wisdom, and the theological cluster if the work is explicitly integrative. Collapse the Reason duplicate. Keep empirical, formal, normative, and theological claims in separate registers and state the bridge when one is made.


## Operational overlay (corrected 2026-10-05)

The stratified stack below is an analyst's protocol laid over the 74 files. It is not a directed graph latent in Wikipedia's authorship. Edges are stipulated for reasoning. Empirical, formal, normative, and theological claims remain separate registers.

```
[ TELEOLOGICAL POLE ]     Wisdom, Philosophy, Metaphysics, God, Sophia, Trinity
        |  Rule 4: name the stopping-point; do not derive it from the layers below
[ GOVERNANCE ]            Sovereignty, Criminal law, Sociology, Corruption, CISA
        |  Rule 3: pathological / adversarial / incentive-capture filter
[ AGENTIC SYSTEMS ]       Cognition, Intelligence, Learning, Deep learning, Machines
        |  Rule 2: is-ought gap; a loss function is not a justification
[ FORMAL INSTRUMENTS ]    Axiom, Logic, Proof, Information theory, Complexity
        |  Rule 1: empirical fit is not proof
[ PHYSICAL SUBSTRATE ]    Physics, Chemistry, Thermodynamics, Pathology
```

Formal axioms and theology are not one pole. The Axiom file distinguishes classical self-evidence from modern stipulation. ZFC is a stipulated set theory, not a theological first principle. Gödel's second incompleteness theorem, present in the Axiom and Mathematical proof files, limits what a sufficiently strong formal system can prove about itself. It is not a homology with God or Sophia.

Bridges that survive contact with the files:

- Superintelligence file states Bostrom's orthogonality thesis: virtually any final goal can combine with virtually any level of intelligence, plus instrumental convergence. That supports intelligence/wisdom separation. It does not define alignment as the embedding of Wisdom. The Wisdom file defines sapience as wit and virtue balancing interests toward a common good, not as an engineering interface.
- Information theory file names Shannon entropy, mutual information, and channel capacity, and points to Landauer's 1960s work on the thermodynamic-information link. It does not derive a computation tax. The Landauer bound, external to the derivation in these print files, is a minimum entropy cost of irreversible bit erasure, kT ln 2 under standard assumptions, not a cost of computation as such. Reversible computation is the caveat.
- Deep learning remains empirical risk minimization. Mutual-information preservation is not the training objective stated by the corpus. Low loss is not rigour and not justified true belief. Spurious correlation is analogous to epistemic luck; it is not thereby a Gettier case.
- Tinbergen's four questions are in the Behavioral ecology file. Mapping them onto forward pass, training, loss, and architecture search is a heuristic only. Phylogeny is historical descent, not hyperparameter search. Fitness is not a stationary loss.
- Pathology, cybersecurity, and corruption are three grammars of failure juxtaposed by the corpus, not one theory. Diagnostic labels — breakdown under load, adversarial exploitation, incentive capture — are constructed and must be marked as such.

Boundary rules for applied use:

1. Inductive gate. Observations on a distribution are not invariances. State the distribution and withhold proof language.
2. Normative gap. An optimization landscape does not select its own objective. The Science file states the is-ought problem: facts alone cannot tell us what we should do. Hume in the Epistemology file remains empiricism.
3. Deployment filter. Reject designs that assume uniformly cooperative agents. Apply breakdown, adversary, and incentive-capture as separate checks.
4. Axiomatic closure. When justification stops, name the stopping-point actually used: stipulated formal axioms, a philosophical commitment, or a theological commitment present in the God, Trinity, and Sophia files. Do not treat those as interchangeable.


## Epistemic governor (corrected 2026-10-05, second pass)

The lattice is a stipulated control surface. It works by negative constraint: a property established in a lower register does not certify a property in a higher register unless the bridge is named, marked external or heuristic, and confined to its own grammar.

### Five named closures, not four

Foundationalism and coherentism are alternative epistemic halts, not one halt. Normative authority is a further halt. Theology is another. They are not interchangeable.

1. Formal stipulation — Axiom, Logic, Mathematical proof. A modern axiom is a chosen premise for derivation. ZFC is the usual background set theory. Gödel's second incompleteness theorem limits self-certification of consistency for systems strong enough to encode arithmetic; it is not a bound on every axiom system, and it is not a theological patch. "True by convention" and "non-ontological" are further philosophical positions. The Philosophy of mathematics file leaves the reality of mathematical objects open.
2. Foundationalist basic source — Knowledge, Epistemology. Some sources (perception, introspection, memory, and, on some accounts, reason) can justify without dependence on other mental states. This is not the same as a stipulated axiom, and it is not self-evidence in the classical axiomatic sense.
3. Coherentist mutual support — Coherentism. Justification is a property of a sufficiently coherent body of beliefs, not of a privileged base. Mutual support is not formal derivation. The isolation objection is stated in the Coherentism file: empirical justification must connect a belief to the way the world is. See the full-text pass.
4. Institutional and normative authority — Sovereignty, Criminal law, Criminal procedure, Crimes against humanity. The halt is authority, harm, or right. It is not a biological imperative and not a deduction from physics.
5. Theological commitment — God, Trinity, Sophia, Divinity. In the monotheistic and Christian files this is a commitment to a supreme creator and, for the Trinity, one essence in three persons. Sophia can name divine wisdom identified with the Word or the Spirit. That grammar is reception and doctrine, not a computational halt and not a formal axiom.

Gettier cases pressure the justified-true-belief formula as such. They are not a special vulnerability of foundationalism alone.

### Three failure audits, heuristics marked

Pathology, cybersecurity/CISA, and corruption are independent audits. Mappings onto catastrophic forgetting, prompt injection, reward hacking, deceptive alignment, or Goodharting are imported technical lexicons, not corpus results.

- Structural and load failure: Pathology (cause, pathogenesis, structural change, functional consequence), with Thermodynamics as a physical constraint on continuous operation. Not identical to entropic decay.
- Adversarial exploitation: Cybersecurity engineering and the CISA file. The diagnostic question is where the design assumes benign inputs. Specific attack names are external.
- Incentive capture: Corruption and criminal law. The diagnostic question is how an internal target diverts effort from the stated charter. Specification gaming is an analogy, not a file finding.

### Inductive and normative gates

Deep learning minimizes empirical risk on a sample from a distribution. That is not truth-preservation under deduction (Rigour, Mathematical proof). Weighted associations are not, by that fact, justified true beliefs (Knowledge). Shannon mutual information is dependence between variables in a channel, not the training loss.

Orthogonality, as reported in Superintelligence, is Bostrom's thesis that virtually any final goal can combine with virtually any intelligence level. Wisdom is wit and virtue balancing intrapersonal, interpersonal, and institutional interests toward a common good. "Non-algorithmic" is an inference, not the file's wording. Choosing a technical loss (for example cross-entropy rather than squared error) is a methodological act. Treating that objective as the common good, safety, or wisdom is the normative gap, and that selection is institutional or ethical, not a machine-learning discovery.

### Audit pipeline

A pass certifies register-discipline only. It does not certify empirical truth, safety, or alignment.

1. Inductive gate — empirical result on D labeled as heuristic, not as proof or understanding.
2. Three failure filters — structural load, adversary, and incentive capture evaluated separately.
3. Normative gap — objective stated as an engineered proxy with trade-offs, not as wisdom or safety.
4. Named closure — halt declared as stipulation, foundationalist source, coherentist support, institutional authority, or theological commitment.

Crossings remain possible. They must be named. They are not impassable, and they are not free.


## Full-text pass (2026-10-05)

Complete text was extracted from all 74 PDFs: 695,613 words. Reason and Reason (1) match at 11,664 words and are duplicates. Method: full extraction, term inventory, and passage checks on load-bearing articles. Print noise and captions remain. This pass does not replace the articles as sources.

### Corrections to the lead-level protocol

- The is-ought gap is not only an external import. The Science file states it: facts alone cannot tell us what we should do, and connects that point to value-ladenness. Hume in the Epistemology file remains the empiricist, not that formulation. Rule 2 may now be cited to the Science file for the gap, and to Epistemology only for empiricism.
- The isolation objection is in the Coherentism file, not merely an external criticism. That file says justification of an empirical belief must connect the proposition to the way the world is, and names isolation as a third objection. It also positions coherentism against foundationalism and infinitism, and against the regress argument. The earlier note that isolation was external is withdrawn.
- Experiential knowledge is a three-page stub: knowledge gained through experience, contrasted with a priori knowledge, with propositional textbook knowledge, and with practical knowledge. Tacit knowledge appears only as a see-also. It cannot carry the weight the Wisdom file places on experiential and tacit knowledge; that weight stays with Wisdom.
- Sovereignty's two uses of "common good" are Hobbes and Rousseau on the legislator and the general will. They are not the Wisdom file's balance of intrapersonal, interpersonal, and institutional interests. The phrases must not be merged.
- Information theory develops Shannon entropy, mutual information (25 body mentions), and channel capacity. Landauer appears five times, as a cross-reference to "Entropy in thermodynamics and information theory" and in the bibliography ("Information is Physical"). The body still does not derive \(k_B T \ln 2\).
- Superintelligence is a 14-page, 3,473-word article. Orthogonality and instrumental convergence appear once each, as Bostrom's postulates. Alignment appears twice, tied to goal misalignment and the need for precise goal specification. The article does not define alignment as wisdom.
- Insect cognition, Heavenly host, Criminal procedure, Experiential knowledge, Rigour, Ethology, and Cybersecurity engineering are short. CISA is an agency article. These cannot anchor a general theory of adversaries, angelic order, or procedure.

### What the bodies add without changing the registers

- Knowledge and Epistemology carry the justification dispute at length: Gettier (13 and 6 mentions), foundationalism, coherentism, and reliabilism. Alternative definitions are contested, not settled.
- Coherentism is argumentatively dense for its length (about 3,000 words, 50 internal mentions). It is a real node, not a label.
- Trinity is a long doctrinal history (16,217 words): Nicene settlement, homoousios, and the Latin and Greek framings of one essence and three persons. It is not a short definition.
- Jesus, Human, Psychology, Evolutionary psychology, and Corruption are the largest bodies. Corruption is an institutional analysis, not a systems-theory of goal displacement.
- Deep learning and Neural network discuss adversarial examples. That supports an adversarial audit inside machine learning. It does not convert the CISA file into an attack taxonomy.
- Philosophy of mathematics continues to leave the status of mathematical objects open. Gödel and ZFC stay inside the formal files.

### Standing protocol after the full-text pass

Five closures, three separate failure audits, and four gates remain. Two citations are upgraded: is-ought to the Science file; isolation to the Coherentism file. No rejected bridge is restored. Crossings still require a named bridge. A governor pass still certifies register-discipline only.
