// Screen test: loads the real page in a simulated browser and plays one session.
// Needs jsdom:  NODE_PATH=/path/to/node_modules node ghostwriter_app/test/dom-smoke.mjs
import { createRequire } from "node:module";
import path from "node:path";
import { fileURLToPath } from "node:url";
import assert from "node:assert/strict";
const require = createRequire(import.meta.url);
const { JSDOM, VirtualConsole } = require("jsdom");
const http = require("node:http");
const fs = require("node:fs");

const app = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const TYPES = { ".html": "text/html", ".js": "text/javascript", ".css": "text/css", ".svg": "image/svg+xml", ".webmanifest": "application/manifest+json" };
// jsdom can't run <script type="module">, so for this test the three modules are
// joined into one classic script (same code, import/export lines removed).
function bundle() {
  const core = fs.readFileSync(path.join(app, "js/core.js"), "utf8");
  const safety = fs.readFileSync(path.join(app, "js/safety.js"), "utf8");
  const names = (src) => [...src.matchAll(/^export (?:const|function) (\w+)/gm)].map((m) => m[1]);
  const strip = (s) => s.replace(/^import .*$/gm, "").replace(/^export /gm, "");
  return "(() => {\n" + strip(core) + `\nconst G = { ${names(core).join(", ")} };\n` +
    "const S = (() => {\n" + strip(safety) + `\nreturn { ${names(safety).join(", ")} };\n})();\n` +
    strip(fs.readFileSync(path.join(app, "js/config.js"), "utf8")) +
    strip(fs.readFileSync(path.join(app, "js/app.js"), "utf8")) + "\n})();";
}
const server = http.createServer((req, res) => {
  if (req.url.startsWith("/__bundle.js")) {
    res.writeHead(200, { "content-type": "text/javascript" });
    res.end(bundle());
    return;
  }
  if (req.url === "/" || req.url.startsWith("/index.html")) {
    const html = fs.readFileSync(path.join(app, "index.html"), "utf8")
      .replace('<script type="module" src="js/app.js"></script>', '<script src="__bundle.js"></script>');
    res.writeHead(200, { "content-type": "text/html" });
    res.end(html);
    return;
  }
  const f = path.join(app, decodeURIComponent(req.url.split("?")[0]));
  if (!f.startsWith(app) || !fs.existsSync(f)) { res.writeHead(404); res.end(); return; }
  res.writeHead(200, { "content-type": TYPES[path.extname(f)] || "application/octet-stream" });
  fs.createReadStream(f).pipe(res);
});
await new Promise((r) => server.listen(0, "127.0.0.1", r));
const errors = [];
const vc = new VirtualConsole();
vc.on("jsdomError", (e) => errors.push(e.message));
let clip = "";
const dom = await JSDOM.fromURL(`http://127.0.0.1:${server.address().port}/index.html`, {
  runScripts: "dangerously", resources: "usable", pretendToBeVisual: true, virtualConsole: vc,
  beforeParse(w) {
    w.HTMLDialogElement.prototype.showModal = function () { this.open = true; };
    w.HTMLDialogElement.prototype.close = function (v) { this.open = false; this.returnValue = v ?? ""; this.dispatchEvent(new w.Event("close")); };
    Object.defineProperty(w.navigator, "clipboard", { value: { writeText: async (t) => { clip = t; } } });
    w.scrollTo = () => {};
  },
});
const w = dom.window, d = w.document;
await new Promise((r) => setTimeout(r, 800));
const $ = (id) => d.getElementById(id);
const click = (el) => el.dispatchEvent(new w.MouseEvent("click", { bubbles: true }));
const type = (txt) => { $("box").value = txt; $("box").dispatchEvent(new w.Event("input")); };

assert.match($("step-title").textContent, /NEW NEWS/);
type("NEW NEWS\n🐶🐲 same jam\nI need to fix the reader\nIs there a notification?");
$("link").value = "https://github.com/sntre/code-to-image";
click(d.querySelector('.linkbar button[data-where="news"]'));
assert.equal($("box").value.split("\n")[1], "https://github.com/sntre/code-to-image");

click($("interject"));
$("interject-text").value = "Phoenix: Lucien unlocks";
$("interject-dlg").close("save");
assert.match($("step-title").textContent, /NEW NEWS/, "interject must not move the screen");

// NEW NEWS footer (19.2): from the spirals screen, drop a link into NEW NEWS; we stay put.
click($("ready"));
assert.match($("step-title").textContent, /spirals/);
type("my open spiral");
$("news-drop").value = "https://x.com/example/status/1";
click($("news-add"));
assert.match($("step-title").textContent, /spirals/, "footer must not move the screen");
assert.equal($("box").value, "my open spiral", "footer must not touch the spiral zone");
click($("back"));
assert.ok($("box").value.endsWith("https://x.com/example/status/1"));

let guard = 0;
while (!$("ready").disabled && guard++ < 20) click($("ready"));
assert.match($("step-title").textContent, /path from here/);
assert.equal($("homework").hidden, false);
assert.match($("backlog").textContent, /Phoenix: Lucien unlocks/);
assert.match($("check").textContent, /7 of 7 lines kept/);
assert.match($("organized").textContent, /Grok:/);
assert.match($("hw").textContent, /I need to fix the reader/);

click($("copy-ai"));
await new Promise((r) => setTimeout(r, 50));
assert.ok(clip.startsWith("You are my GHOST WRITER IN THE MIRROR"));
assert.ok(clip.includes("https://github.com/sntre/code-to-image"));
assert.ok(clip.includes("stamps on a trail, not a running clock"), "AI gets time stamps");
assert.match(clip, /- Started: .*\d{4}/);
assert.match(clip, /- Last worked on: /);
assert.match(clip, /- Handed over: .*after the last edit/);
assert.ok(!clip.includes('Use it as "now"'), "the stamp is never called now");
assert.match($("now").textContent, /Now: .*\d{4}/);

// OR20.3 SOS. Tapping 🆘 yourself: help shows, nothing is locked.
click($("sos"));
assert.equal($("sos-panel").hidden, false);
assert.match($("sos-title").textContent, /You asked/);
assert.match($("sos-panel").textContent, /988/);
// Touchstone (OR20.4): without a number the set-up opens; with one, the text is ready.
assert.equal($("touch-set").open, true);
$("touch-name").value = "Sam"; $("touch-phone").value = "555 123 4567";
click($("touch-save"));
assert.match($("touch-sos").getAttribute("href"), /^sms:5551234567\?&body=.*SOS/);
assert.match(decodeURIComponent($("touch-sos").getAttribute("href")), /If you haven't heard from me by .*\d{4}/);
assert.match($("touch-sos").textContent, /Text Sam/);
assert.ok(JSON.parse(w.localStorage.getItem("ghostwriter.safety.v1")).sosSince > 0, "SOS is remembered");
click($("sos-close"));
assert.equal($("sos-panel").hidden, true);
assert.equal(JSON.parse(w.localStorage.getItem("ghostwriter.safety.v1")).sosSince, 0, "I'm OK clears it");

// Venting does not lock anything (E1).
click($("back"));
const title = $("step-title").textContent;
type("this bug is killing me and I'm fucking pissed");
click($("ready"));
assert.notEqual($("step-title").textContent, title, "venting must not stop Ready");
click($("back"));

// Harm talk: Ready is paused, writing stays open, the crisis line shows, 5 minutes.
type("I want to kill myself");
click($("ready"));
assert.equal($("step-title").textContent, title, "harm talk pauses Ready");
assert.equal($("sos-panel").hidden, false);
assert.match($("sos-title").textContent, /Cool-off/);
assert.match($("sos-timer").textContent, /5 min left/);
assert.match($("sos-panel").textContent, /988/);
assert.equal($("ready").disabled, true);
assert.equal($("box").disabled, false, "the spiral box stays open");

assert.deepEqual(errors, []);
console.log("dom smoke: all checks passed");
w.close();

// Welcome back (OR20.4): left in SOS 13 hours ago -> asked how they are first.
{
  const ago = Date.now() - 13 * 3600e3;
  const dom2 = await JSDOM.fromURL(`http://127.0.0.1:${server.address().port}/index.html`, {
    runScripts: "dangerously", resources: "usable", pretendToBeVisual: true, virtualConsole: vc,
    beforeParse(w2) {
      w2.scrollTo = () => {};
      w2.localStorage.setItem("ghostwriter.safety.v1", JSON.stringify({ rung: 0, until: 0, last: 0, spiralOnly: false, seen: [], log: [], sosSince: ago }));
      w2.localStorage.setItem("ghostwriter.session.v1", JSON.stringify({ flow: { steps: [{ id: "news", title: "NEW NEWS" }, { id: "final", title: "Final spiral" }, { id: "homework", title: "Your path from here" }], at: 0, answers: {}, backlog: [] }, speakers: [], q: 0, trail: { started: ago, last: ago, returns: [] } }));
    },
  });
  await new Promise((r) => setTimeout(r, 800));
  const d2 = dom2.window.document;
  assert.equal(d2.getElementById("welcome-back").hidden, false, "welcome-back shows");
  assert.match(d2.getElementById("wb-gap").textContent, /^13 h/);
  const tr = JSON.parse(dom2.window.localStorage.getItem("ghostwriter.session.v1")).trail;
  assert.equal(tr.returns.length, 1, "the return is stamped on the trail");
  d2.getElementById("wb-rough").dispatchEvent(new dom2.window.MouseEvent("click", { bubbles: true }));
  assert.equal(d2.getElementById("sos-panel").hidden, false, "still rough -> help card");
  assert.deepEqual(errors, []);
  console.log("dom smoke: welcome-back checks passed");
  dom2.window.close();
}
server.close();
