// Ghost Writer in the Mirror: core logic (no screen code, no network).
// Works in the browser and in Node, so it can be tested on its own:
//   node ghostwriter_app/test/core.test.mjs
//
// The one promise this file keeps: ORGANIZE, DON'T CUT.
// Every non-blank line the player writes lands in exactly one section, in the
// order it was written. Nothing is shortened, merged away or dropped.
// (The same rule is checked in Lean: RequestProject/R19/Level1Checks.lean.)

export const SECTIONS = [
  { id: "sos", title: "🆘 Stop: needs a real person" },
  { id: "locked", title: "💎 Locked (final)" },
  { id: "parked", title: "⏭️ Parked for later" },
  { id: "link", title: "🔗 Lines with links" },
  { id: "question", title: "❓ Questions" },
  { id: "todo", title: "✅ To-do / asks" },
  { id: "thought", title: "🌀 New thoughts" },
  { id: "note", title: "📝 Everything else, in your words" },
];

const URL_RE = /https?:\/\/[^\s<>"')\]]+/g;
const TODO_RE =
  /^(please|todo|to do|make sure|don'?t forget|remember to|can you|could you|let'?s)\b|\b(i need to|we need to|need to|make sure|have to|has to|got to|gotta)\b/i;
const QUESTION_START = /^(is there|are there|how do|how can|what|why|who|where|when|can i|could we|should i|do you)\b/i;

const VS = /\uFE0F/g;
const strip = (s) => String(s ?? "").replace(VS, "");

/** Split text into lines (handles Windows / Mac line endings and a BOM). */
export function splitLines(text) {
  return String(text ?? "").replace(/^\uFEFF/, "").split(/\r\n|\r|\n/);
}

/** All links in a piece of text, in order, without trailing punctuation. */
export function findLinks(text) {
  return (String(text ?? "").match(URL_RE) || []).map((u) => u.replace(/[.,;:!?]+$/, ""));
}

/** Which section a single (non-blank) line belongs to. First match wins. */
export function classifyLine(line) {
  const s = strip(line).trim();
  if (s.includes("🆘")) return "sos";
  if (s.includes("💎")) return "locked";
  if (s.includes("⏭")) return "parked";
  if (findLinks(s).length) return "link";
  if (/\?\s*$/.test(s) || QUESTION_START.test(s)) return "question";
  if (TODO_RE.test(s)) return "todo";
  if (s.includes("🌀")) return "thought";
  return "note";
}

/**
 * Who is talking on a line: the speaker whose icon the line starts with.
 * speakers: [{ icon: "🐶🐲", name: "Grok" }, ...]. Longest icon wins.
 * Unmarked lines are "unlabelled", never nobody's.
 */
export function speakerOf(line, speakers = []) {
  const s = strip(line).trim();
  let best = null;
  for (const sp of speakers) {
    const icon = strip(sp.icon).trim();
    if (icon && s.startsWith(icon) && (!best || icon.length > strip(best.icon).trim().length)) best = sp;
  }
  return best ? best.name : "unlabelled";
}

/** Organize a whole dump. Nothing is cut: see the `check` field. */
export function organize(text, speakers = []) {
  const lines = splitLines(text);
  const sections = Object.fromEntries(SECTIONS.map((s) => [s.id, []]));
  const bySpeaker = {};
  let kept = 0;
  lines.forEach((raw, i) => {
    if (!raw.trim()) return;
    const id = classifyLine(raw);
    const who = speakerOf(raw, speakers);
    sections[id].push({ n: i + 1, text: raw, who });
    bySpeaker[who] = (bySpeaker[who] || 0) + 1;
    kept++;
  });
  const nonBlank = lines.filter((l) => l.trim()).length;
  const links = findLinks(text);
  const uniqueLinks = [...new Set(links)];
  return {
    sections,
    bySpeaker,
    links: uniqueLinks,
    repeatedLinks: links.length - uniqueLinks.length,
    check: { nonBlank, kept, nothingCut: nonBlank === kept },
  };
}

/**
 * Put a link where the player wants it.
 * where: "cursor" (at the cursor, on its own line), "top",
 *        "news" (right under the first line containing NEW NEWS, else top),
 *        "bottom".
 * Returns { text, cursor } with the cursor just after the inserted link.
 * Everything already written stays, in order.
 */
export function insertLink(text, link, where = "cursor", cursor = null) {
  text = String(text ?? "");
  link = String(link ?? "").trim();
  if (!link) return { text, cursor: cursor ?? text.length };
  if (where === "cursor") {
    // "The next line available from where your cursor is": an empty line under
    // the cursor is used as is; otherwise the link goes on a new line right
    // after the cursor's line. Words are never split.
    const c = Math.max(0, Math.min(cursor ?? text.length, text.length));
    const start = text.lastIndexOf("\n", c - 1) + 1;
    const nl = text.indexOf("\n", c);
    const end = nl === -1 ? text.length : nl;
    if (text.slice(start, end).trim() === "") {
      const out = text.slice(0, start) + link + text.slice(end);
      return { text: out, cursor: start + link.length };
    }
    const out = text.slice(0, end) + "\n" + link + text.slice(end);
    return { text: out, cursor: end + 1 + link.length };
  }
  const lines = text === "" ? [] : splitLines(text);
  let idx;
  if (where === "top") idx = 0;
  else if (where === "news") {
    const k = lines.findIndex((l) => /NEW NEWS/i.test(l));
    idx = k >= 0 ? k + 1 : 0;
  } else idx = lines.length;
  lines.splice(idx, 0, link);
  return { text: lines.join("\n"), cursor: lines.slice(0, idx + 1).join("\n").length };
}

// ---------------------------------------------------------------- the flow
// One screen at a time: NEW NEWS -> open spirals -> field-report boxes ->
// final spiral -> homework. The "you are here" arrow travels with the player
// and only moves when they press Ready. Interjecting never moves it: the note
// goes to the backlog, which is shown in full on the final spiral screen.

export function newFlow(boxTitles = ["Field report"]) {
  const steps = [
    { id: "news", title: "NEW NEWS: drop your news, links and group grabs" },
    { id: "spirals", title: "Any spirals still running before we continue?" },
    ...boxTitles.map((t, i) => ({ id: `box${i + 1}`, title: t })),
    { id: "final", title: "Final spiral: additional thoughts + your backlog" },
    { id: "homework", title: "Your path from here (homework and next steps)" },
  ];
  return { steps, at: 0, backlog: [], answers: {} };
}

/** Write on the current screen. */
export function write(flow, text) {
  const id = flow.steps[flow.at].id;
  return { ...flow, answers: { ...flow.answers, [id]: text } };
}

/** The interject button: park a note for later. The screen does not change. */
export function interject(flow, note) {
  if (!String(note ?? "").trim()) return flow;
  return { ...flow, backlog: [...flow.backlog, { from: flow.steps[flow.at].id, note }] };
}

/**
 * The NEW NEWS footer (OR19.2): from ANY screen, drop a link or a line straight
 * into the NEW NEWS box without leaving where you are. The current screen, its
 * text and the backlog are untouched, so the spiral zone never gets cluttered.
 * The item goes on its own line at the end of NEW NEWS; nothing there is lost.
 */
export function newsDrop(flow, item) {
  item = String(item ?? "").trim();
  if (!item) return flow;
  const old = flow.answers.news || "";
  const news = old.trim() === "" ? item : old.replace(/\s+$/, "") + "\n" + item;
  return { ...flow, answers: { ...flow.answers, news } };
}

/** Ready: move to the next screen (stays on the last one). */
export function ready(flow) {
  return { ...flow, at: Math.min(flow.at + 1, flow.steps.length - 1) };
}

/** Back: one screen back (never before the first). */
export function back(flow) {
  return { ...flow, at: Math.max(flow.at - 1, 0) };
}

export const isDone = (flow) => flow.at === flow.steps.length - 1;

const allText = (flow) => flow.steps.map((s) => flow.answers[s.id] || "").join("\n");

/** The homework list: asks, questions, parked and locked items, and the backlog. */
export function homework(flow, speakers = []) {
  const o = organize(allText(flow), speakers);
  const pick = (id) => o.sections[id].map((x) => x.text.trim());
  return {
    todo: pick("todo"),
    questions: pick("question"),
    parked: pick("parked"),
    locked: pick("locked"),
    backlog: flow.backlog.map((b) => b.note.trim()),
    sos: pick("sos"),
  };
}

// ---------------------------------------------------------------- export

export function toMarkdown(flow, speakers = [], title = "Spiral session", when = "") {
  const o = organize(allText(flow), speakers);
  const hw = homework(flow, speakers);
  const out = [`# ${title}`, ""];
  if (Array.isArray(when) && when.length) {
    out.push("*Time stamps (my device's own date, clock and time zone). These are stamps on a trail, not a running clock:*", "");
    for (const w of when) out.push(`- ${w}`);
    out.push("");
  } else if (when) out.push(`*Stamped (my device's own date, clock and time zone): ${when}*`, "");
  out.push(`*Organized, nothing cut: ${o.check.kept} of ${o.check.nonBlank} lines kept.*`, "");
  for (const s of flow.steps) {
    const a = (flow.answers[s.id] || "").trim();
    if (a) out.push(`## ${s.title}`, "", a, "");
  }
  out.push("## Organized by section", "");
  for (const sec of SECTIONS) {
    const items = o.sections[sec.id];
    if (!items.length) continue;
    out.push(`### ${sec.title}`, "");
    for (const it of items) out.push(`- ${it.who !== "unlabelled" ? `**${it.who}:** ` : ""}${it.text.trim()}`);
    out.push("");
  }
  if (o.links.length) {
    out.push("## Links, one per line", "");
    for (const l of o.links) out.push(l, "");
  }
  if (flow.backlog.length) {
    out.push("## Backlog (your interjections, in order)", "");
    flow.backlog.forEach((b, i) => out.push(`${i + 1}. ${b.note.trim()}`));
    out.push("");
  }
  out.push("## Homework", "");
  const list = (name, xs) => {
    if (xs.length) out.push(`**${name}:**`, ...xs.map((x) => `- ${x}`), "");
  };
  list("To do", hw.todo);
  list("Questions to answer", hw.questions);
  list("Parked", hw.parked);
  list("Locked", hw.locked);
  if (hw.sos.length) out.push("**🆘 You marked something as needing a real person.** In the US you can call or text 988.", "");
  return out.join("\n");
}

export const LOAD_IN_PROMPT = `You are my GHOST WRITER IN THE MIRROR. We are playing a choose-your-own-adventure
writing and brainstorming game about me. Follow these rules exactly.

EACH LEVEL
1. ORGANIZE, DON'T CUT. Take the entirety of what I gave you and bring it back to
   me organized so it makes sense: group my thoughts, put them in an order, and
   keep my own words and images. Do not drop, shorten away or water down any
   point. There is no length limit on your reply. If you moved or merged
   something, say where it went.
2. Tell it as a story chapter where I am the main character. Don't add facts
   about me that I didn't give you.
3. BACKGROUND CHECK. Look for publicly available information that could add to
   my understanding. Give short summaries, each with where it came from. If you
   can't search the web, say so plainly. Don't dig up private details about
   other people.
4. PATHS. End every level with paths: go deeper, ask about a summary, link it to
   a creative avenue, fork to a new topic, or write my own path.
5. Label the top of every reply: LEVEL n.

MY CONTROLS
🌀 = new thought: weave it in.  👍 = keep.  ❌ = wrong: use my correction.
💎 = locked: never change it.  ⏭️ = park it for later.
🆘 = stop the story, step out of character, ask if I'm OK, and give real-help
     options (in the US: call or text 988).

RULES FOR YOU
- TIME: the time stamps at the top of my session are a TRAIL, not "now": when I
  started, each time I came back to it ("ported back in", with how long I was
  away), when I last worked on it, and when I handed it to you. Use them to
  compare: how much time passed, and what may have changed in between. Time keeps
  moving after the "Handed over" stamp, so if I come back to this chat later,
  don't assume it's still that moment: ask me, or use the newest stamp I give you.
  If there are no stamps, ask me.
- I steer. If you aren't sure what I meant, ASK.
- Never claim you read a link, file or picture you couldn't open.
- Keep it kind. You are a writing partner, not a therapist.

Here is my organized session. Start LEVEL 1 from it.`;

/** Everything the player needs to paste into their own AI chat. */
export function aiPrompt(flow, speakers = [], when = "") {
  return `${LOAD_IN_PROMPT}\n\n----- MY SESSION -----\n\n${toMarkdown(flow, speakers, "Spiral session", when)}`;
}

export const MIRROR_QUESTIONS = [
  "What do you want to write your way through today?",
  "What keeps coming back to you, even when you try to put it down?",
  "If this week were a chapter title, what would it be?",
  "Who is in the room with you on this one, even if they aren't really there?",
  "What would you do next if you knew nobody would judge it?",
  "What did you lock 💎 last time, and does it still feel true?",
  "Which fork did you skip? Do you want to go back?",
  "What is the smallest next step you could take today?",
  "What are you proud of that nobody has noticed yet?",
  "Where is the friction: the part that slows you down, and the part that keeps you steady?",
];
