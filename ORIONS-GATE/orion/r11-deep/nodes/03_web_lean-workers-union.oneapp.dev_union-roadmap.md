# Union improvement backlog — lean-worker field guide

- source: https://lean-workers-union.oneapp.dev/union-roadmap
- key: web:lean-workers-union.oneapp.dev/union-roadmap
- depth: 3
- reached from: web:lean-workers-union.oneapp.dev/

Union improvement backlog — lean-worker field guide
LW
Lean-Workers Union Lodge House · field guide
My profile / Login
Home
Architecture
Assurance limits
Protocols
Plugins
Build & provenance
Union backlog
← Home
Team planning · proposed work
A practical backlog for improving the Union.
Turn the supplied  Union.lean  example into a clearer, testable membership model. Assign owners, update progress, and export a team checklist for planning or review.
Scope boundary
This backlog is a planning aid, not a registry update. The source example defines  UnionMembership ,  UnionRegistry , registration/lookups, and five lodge-table examples. The separate Authority or gate layer discussed earlier is not part of that schema and is treated as optional.
Browser-only registration
Union member registry
Register a member or import a roster. The registry API runs in this page; there is no server account or network submission. Changes are carried in this page’s URL fragment and a same-browser cookie, and can be exported/imported as JSON for sneakernet sharing.
For scripts on this page:  window.UnionRegistryAPI.listMembers() ,  registerMember(record) ,  importMembers(records) , and  exportMembers() .
Register member
Copy registry link
Export roster JSON
Import roster JSON
Loading registry state…
Shareable registry URL
The URL fragment contains the roster. Anyone with the link can read and copy its contents.
Interactive guide
Take an audio tour of the registry
Explore registration, duplicate handling, URL sharing, and JSON sneakernet with browser speech, sequence diagrams, and a step-by-step debug trace.
Take an audio tour →
External research · local merge
Research bounties and findings
Post what information is needed, prepare queries for a source you choose, paste findings back, and merge shared results into this browser.
Open bounty board →
Self-registration
Add a member record
Close
Use public identifiers only. A duplicate member ID is rejected; a different member ID may use an existing repository identifier.
Member ID
Status
Repository identifier
Module
Capabilities, comma-separated
Cancel
Add member record
Team backlog
Loading tasks…
Copy LLM handoff
Copy share link
Download plan
Export state JSON
Download skill.md
Download llms.txt
Download debug log
View debug log
Print
Export ready
File name:  export.txt
Copy, share, or save the contents below.
Copy contents
Share contents
Save contents to file
Close
Shareable data URL
This link contains the export contents and file name. Anyone who receives it can read them.
Open shared contents
Export contents
Recent debug events
Diagnostics stay in this browser and omit task notes and owner names.
Refresh
Copy debug log text
Save log as text file
Copy shareable data URL
Close
Shareable debug log data URL
This URL contains the readable diagnostics log. Anyone who receives it can view those details.
Open debug log data URL
Bring task results back
Paste the JSON result from an LLM session or import a previously exported backlog file. Matching task IDs update status, owner, and result notes in this browser. Unrecognized IDs are ignored.
Paste task-results JSON
Apply results
Choose JSON file
Imports update this browser only.
How to use it
Assign a teammate and agree on the acceptance check for each item.
Copy the LLM handoff into a chat session; ask it to return JSON keyed by task ID.
Paste the returned JSON into “Bring task results back” to update status, owner, and notes.
Download Markdown, JSON, skill.md, or llms.txt, or copy a share link to carry the plan elsewhere.
Progress and returned results are saved in this browser. Use Copy share link or export JSON to carry that state elsewhere; links contain the task state, so share them only with people meant to see it. This page does not create issues, commit code, or sync automatically.
Reset local edits
Suggested order
Agree on the boundary before expanding the model.
Start by deciding what Union membership means independently of any gate or authorization service. Then specify valid status values and identity rules, add registry operations with meaningful behavior, and only afterward decide which external systems should consume or export the roster.
Review source & provenance →
Read assurance limits
lean-worker field guide
·
Union backlog from the supplied example; not a claim of implementation.
