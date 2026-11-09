// Screen code for Ghost Writer in the Mirror. All logic lives in core.js.
import * as G from "./core.js";
import { CONFIG } from "./config.js";
import * as S from "./safety.js";

const $ = (id) => document.getElementById(id);
const KEY = "ghostwriter.session.v1";

function load() {
  try {
    const s = JSON.parse(localStorage.getItem(KEY));
    if (s && s.flow && Array.isArray(s.flow.steps)) return s;
  } catch (_) { /* start fresh */ }
  return { flow: G.newFlow(CONFIG.boxes), speakers: CONFIG.speakers.slice(), q: 0 };
}
let state = load();
const save = () => localStorage.setItem(KEY, JSON.stringify(state));

// SOS cool-off ladder (OR20.3). Kept on this device only.
const SKEY = "ghostwriter.safety.v1";
let safety = (() => {
  try { const x = JSON.parse(localStorage.getItem(SKEY)); if (x && Array.isArray(x.seen)) return x; } catch (_) { /* fresh */ }
  return S.newSafety();
})();
const saveSafety = () => localStorage.setItem(SKEY, JSON.stringify(safety));
let helpOpen = false;  // the player tapped 🆘 themselves
const when = () => S.timeContext(new Date()).line;

// Time trail (OR20.4): stamps, not one "now". Each session keeps when it started,
// every time the player came back ("ported back in"), and when it was last touched.
const stamps = () => S.trailLines(state.trail, Date.now());
function touchTrail() {
  state.trail = S.touch(state.trail, Date.now());
  save();
}

// Touchstone (OR20.4): one trusted person, kept on this device only.
const TKEY = "ghostwriter.touchstone.v1";
let touchstone = (() => { try { return JSON.parse(localStorage.getItem(TKEY)) || {}; } catch (_) { return {}; } })();
const deadline = () => S.timeContext(new Date(Date.now() + S.CHECK_HOURS * 3600e3)).line;
function markSos() { if (!safety.sosSince) { safety = { ...safety, sosSince: Date.now() }; saveSafety(); } }
function clearSos() { if (safety.sosSince) { safety = { ...safety, sosSince: 0 }; saveSafety(); } }
function renderTouch() {
  const has = Boolean(touchstone.phone);
  const who = touchstone.name ? touchstone.name : "my touchstone";
  $("touch-sos").textContent = "📲 Text " + who;
  $("touch-ok").textContent = "💚 Tell " + (touchstone.name || "them") + " I'm OK";
  $("touch-sos").href = has ? S.smsHref(touchstone.phone, S.touchstoneText("sos", deadline())) : "#";
  $("touch-ok").href = has ? S.smsHref(touchstone.phone, S.touchstoneText("ok")) : "#";
  for (const id of ["touch-sos", "touch-ok"]) $(id).setAttribute("aria-disabled", String(!has));
  $("touch-set").open = !has;
}

/** Check new writing for harm talk. Returns true if a cool-off started. */
function scan(text) {
  const line = S.findHarmTalk(text);
  if (!line) return false;
  const before = safety;
  safety = S.trigger(safety, Date.now(), line);
  if (safety !== before) markSos();
  saveSafety();
  return safety !== before;
}

function renderSafety() {
  const now = Date.now();
  const st = S.status(safety, now);
  $("now").textContent = "🕰️ Now: " + when();
  const show = helpOpen || st.mode !== "open";
  $("sos-panel").hidden = !show;
  $("sos-checkin").hidden = st.mode !== "spiral-only";
  $("sos-close").hidden = st.mode !== "open";
  $("sos-pause").hidden = st.mode !== "open";
  if (st.mode === "cool-off") {
    $("sos-title").textContent = "🆘 Cool-off: ⏭️ is paused";
    $("sos-msg").textContent = "Something you wrote sounded like you might hurt yourself or someone else, so moving on is paused for a while. Keep writing in your spiral box below: breathe, name what you feel, say what you need. When the timer ends you choose: 🌀 keep spiralling, or ⏭️ move on.";
    $("sos-timer").textContent = "⏳ " + S.formatLeft(st.msLeft) + " left";
  } else if (st.mode === "spiral-only") {
    $("sos-title").textContent = "🌀 Spiral-only until someone checks in";
    $("sos-msg").textContent = "You've already been through a full day's cool-off. Your spiral box stays open, and so does the crisis line. ⏭️ comes back after a professional, a group, or someone you trust has seen you settle.";
    $("sos-timer").textContent = "";
  } else {
    $("sos-title").textContent = "🆘 You asked for a real person";
    $("sos-msg").textContent = "Asking for help never counts against you. Reach someone now, or pause yourself for a few minutes and come back to your spiral.";
    $("sos-timer").textContent = "";
  }
  if (!S.canMoveForward(safety, now)) $("ready").disabled = true;
  if (show) renderTouch();
}

function esc(s) {
  return String(s).replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));
}

function renderProgress() {
  $("progress").innerHTML = state.flow.steps
    .map((s, i) => `<span class="${i < state.flow.at ? "done" : i === state.flow.at ? "now" : ""}">${i + 1}. ${esc(s.title.split(":")[0])}</span>`)
    .join("");
}

function renderOrganized() {
  const all = state.flow.steps.map((s) => state.flow.answers[s.id] || "").join("\n");
  const o = G.organize(all, state.speakers);
  $("check").textContent = `${o.check.kept} of ${o.check.nonBlank} lines kept${o.check.nothingCut ? " ✅ nothing cut" : ""}.`;
  let html = "";
  for (const sec of G.SECTIONS) {
    const items = o.sections[sec.id];
    if (!items.length) continue;
    html += `<h4>${esc(sec.title)}</h4><ul>` +
      items.map((it) => `<li>${it.who !== "unlabelled" ? `<span class="who">${esc(it.who)}:</span> ` : ""}${esc(it.text.trim())}</li>`).join("") + "</ul>";
  }
  if (o.links.length) html += `<h4>🔗 Links, one per line</h4>` + o.links.map((l) => `<p>${esc(l)}</p>`).join("");
  $("organized").innerHTML = html || "<p class='small'>Nothing written yet.</p>";
  $("backlog").innerHTML = state.flow.backlog.map((b) => `<li>${esc(b.note)}</li>`).join("") || "<li class='small'>Empty: no interjections.</li>";
}

function renderHomework() {
  const hw = G.homework(state.flow, state.speakers);
  const part = (t, xs) => (xs.length ? `<h4>${t}</h4><ul>${xs.map((x) => `<li>${esc(x)}</li>`).join("")}</ul>` : "");
  $("hw").innerHTML =
    (hw.sos.length ? `<p><strong>🆘 You marked something as needing a real person.</strong> In the US, call or text 988.</p>` : "") +
    part("✅ To do", hw.todo) + part("❓ Questions to answer", hw.questions) +
    part("🌀 Backlog", hw.backlog) + part("⏭️ Parked", hw.parked) + part("💎 Locked", hw.locked) ||
    "<p class='small'>No homework. You're clear.</p>";
}

function render() {
  const f = state.flow;
  const step = f.steps[f.at];
  renderProgress();
  $("step-title").textContent = step.title;
  $("box").value = f.answers[step.id] || "";
  $("mirror-q").textContent = f.at === 0 && !f.answers.news ? G.MIRROR_QUESTIONS[0] : "";
  $("ready").textContent = G.isDone(f) ? "✅ Done" : "Ready ➡️ next box";
  $("ready").disabled = G.isDone(f);
  $("back").disabled = f.at === 0;
  const atFinal = step.id === "final", atHw = step.id === "homework";
  $("final").hidden = !(atFinal || atHw);
  $("homework").hidden = !atHw;
  if (atFinal || atHw) renderOrganized();
  if (atHw) renderHomework();
  renderSafety();
  $("speakers").innerHTML = state.speakers
    .map((s, i) => `<li><span>${esc(s.icon)}</span><span>${esc(s.name)}</span><button data-del="${i}" class="ghost" aria-label="Remove">✖</button></li>`)
    .join("");
}

$("box").addEventListener("input", (e) => { state.flow = G.write(state.flow, e.target.value); touchTrail(); });
$("ready").onclick = () => {
  if (scan($("box").value) || !S.canMoveForward(safety, Date.now())) { render(); window.scrollTo(0, 0); return; }
  state.flow = G.ready(state.flow); save(); render(); window.scrollTo(0, 0);
};
$("sos").onclick = () => { helpOpen = true; markSos(); render(); window.scrollTo(0, 0); };
$("sos-close").onclick = () => { helpOpen = false; clearSos(); render(); };
$("touch-save").onclick = () => {
  touchstone = { name: $("touch-name").value.trim(), phone: $("touch-phone").value.trim() };
  localStorage.setItem(TKEY, JSON.stringify(touchstone));
  renderTouch();
};
for (const id of ["touch-sos", "touch-ok"]) {
  $(id).addEventListener("click", (e) => { if (!touchstone.phone) { e.preventDefault(); $("touch-set").open = true; $("touch-name").focus(); } });
}
$("touch-ok").addEventListener("click", () => { if (touchstone.phone) clearSos(); });
$("wb-ok").onclick = () => {
  clearSos(); $("welcome-back").hidden = true;
  if (touchstone.phone) location.href = S.smsHref(touchstone.phone, S.touchstoneText("ok"));
};
$("wb-rough").onclick = () => { $("welcome-back").hidden = true; helpOpen = true; render(); window.scrollTo(0, 0); };
$("sos-pause").onclick = () => { safety = S.selfPause(safety, Date.now()); saveSafety(); helpOpen = false; render(); };
$("checkin-save").onclick = () => {
  safety = S.checkIn(safety, Date.now(), $("checkin-who").value);
  if (!safety.spiralOnly) safety = { ...safety, sosSince: 0 };
  saveSafety(); $("checkin-who").value = ""; render();
};
// The clock and the timer tick on their own; the arrow and your text don't move.
setInterval(() => {
  const wasLocked = $("ready").disabled && !G.isDone(state.flow);
  renderSafety();
  if (wasLocked && S.canMoveForward(safety, Date.now())) render();
}, 1000);
$("back").onclick = () => { state.flow = G.back(state.flow); save(); render(); };
$("mirror").onclick = () => {
  state.q = (state.q + 1) % G.MIRROR_QUESTIONS.length;
  $("mirror-q").textContent = "🪞 " + G.MIRROR_QUESTIONS[state.q];
  save();
};

document.querySelectorAll(".linkbar button").forEach((b) => {
  b.onclick = () => {
    const box = $("box");
    const r = G.insertLink(box.value, $("link").value, b.dataset.where, box.selectionStart);
    box.value = r.text;
    state.flow = G.write(state.flow, r.text);
    save();
    $("link").value = "";
    box.focus();
    box.setSelectionRange(r.cursor, r.cursor);
  };
});

// NEW NEWS footer: drop news from any screen without leaving your spiral.
$("news-add").onclick = () => {
  const v = $("news-drop").value;
  if (!v.trim()) return;
  state.flow = G.newsDrop(state.flow, v);
  save();
  $("news-drop").value = "";
  $("news-ok").textContent = "✅ Filed under NEW NEWS. You're still here.";
  if (state.flow.steps[state.flow.at].id === "news") $("box").value = state.flow.answers.news;
  setTimeout(() => ($("news-ok").textContent = ""), 2500);
};
$("news-drop").addEventListener("keydown", (e) => { if (e.key === "Enter") $("news-add").click(); });

$("interject").onclick = () => { $("interject-text").value = ""; $("interject-dlg").showModal(); };
$("interject-dlg").addEventListener("close", () => {
  if ($("interject-dlg").returnValue === "save") {
    scan($("interject-text").value);
    state.flow = G.interject(state.flow, $("interject-text").value);
    save();
    render();
  }
});

$("sp-add").onclick = () => {
  const icon = $("sp-icon").value.trim(), name = $("sp-name").value.trim();
  if (!icon || !name) return;
  state.speakers.push({ icon, name });
  $("sp-icon").value = $("sp-name").value = "";
  save(); render();
};
$("speakers").addEventListener("click", (e) => {
  const i = e.target.dataset.del;
  if (i !== undefined) { state.speakers.splice(Number(i), 1); save(); render(); }
});

async function copy(text, btn) {
  try { await navigator.clipboard.writeText(text); }
  catch (_) {
    const t = document.createElement("textarea"); t.value = text; document.body.appendChild(t); t.select();
    document.execCommand("copy"); t.remove();
  }
  const old = btn.textContent; btn.textContent = "✅ Copied"; setTimeout(() => (btn.textContent = old), 1500);
}
$("copy-md").onclick = (e) => copy(G.toMarkdown(state.flow, state.speakers, "Spiral session", stamps()), e.target);
$("copy-ai").onclick = (e) => copy(G.aiPrompt(state.flow, state.speakers, stamps()), e.target);
$("download-md").onclick = () => {
  const blob = new Blob([G.toMarkdown(state.flow, state.speakers, "Spiral session", stamps())], { type: "text/markdown" });
  const a = document.createElement("a");
  a.href = URL.createObjectURL(blob);
  a.download = `spiral-session-${new Date().toISOString().slice(0, 10)}.md`;
  a.click();
  setTimeout(() => URL.revokeObjectURL(a.href), 1000);
};
$("new").onclick = () => {
  if (!confirm("Start a new session? Download or copy this one first if you want to keep it.")) return;
  state.flow = G.newFlow(CONFIG.boxes); state.trail = S.newTrail(Date.now()); save(); render();
};

// Header, footer and the money buttons come from config.js.
$("app-name").textContent = CONFIG.appName;
$("credit").textContent = CONFIG.creditLine;
const money = [
  [CONFIG.fundraiserUrl, "💛 Help fund the ORION build"],
  [CONFIG.supportUrl, "☕ Support the creator"],
  [CONFIG.shopUrl, "📘 Get the workbook"],
  [CONFIG.bookingUrl, "🗓️ Book a spiral session"],
  [CONFIG.homeUrl, "🌀 More from TGSATE"],
].filter(([u]) => u);
$("money").innerHTML = money.map(([u, t]) => `<a href="${esc(u)}" target="_blank" rel="noopener">${t}</a>`).join("");

// Coming back (OR20.4): stamp the return on the trail, and if the player left in
// SOS mode at least 12 hours ago, ask how they are before anything else.
{
  const now = Date.now();
  const lastSeen = state.trail ? state.trail.last : undefined;
  if (S.cameBackFromSos(safety.sosSince, lastSeen, now)) {
    $("wb-gap").textContent = S.formatGap(now - lastSeen);
    $("welcome-back").hidden = false;
  }
  touchTrail();
}

if ("serviceWorker" in navigator && location.protocol.startsWith("http")) {
  navigator.serviceWorker.register("sw.js").catch(() => {});
}
render();
