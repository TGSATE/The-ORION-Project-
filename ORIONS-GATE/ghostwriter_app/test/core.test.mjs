// Core tests. Run: node ghostwriter_app/test/core.test.mjs [optional-doc.txt]
// With a file argument it also organizes that file and checks nothing is cut.
import assert from "node:assert/strict";
import fs from "node:fs";
import * as G from "../js/core.js";

let n = 0;
const t = (name, f) => { f(); n++; console.log("ok", name); };

const speakers = [{ icon: "🐶🐲", name: "Grok" }, { icon: "🐗", name: "Boardy" }, { icon: "🐶", name: "Dog" }];

t("classify", () => {
  assert.equal(G.classifyLine("🆘 I need help"), "sos");
  assert.equal(G.classifyLine("this is final 💎"), "locked");
  assert.equal(G.classifyLine("later ⏭️"), "parked");
  assert.equal(G.classifyLine("see https://x.com/a/b."), "link");
  assert.equal(G.classifyLine("Is there any way to set a notification"), "question");
  assert.equal(G.classifyLine("does it work?"), "question");
  assert.equal(G.classifyLine("I need to call Mike"), "todo");
  assert.equal(G.classifyLine("🌀 phoenix idea"), "thought");
  assert.equal(G.classifyLine("my cats are sweet"), "note");
});

t("links trimmed and deduped", () => {
  assert.deepEqual(G.findLinks("a https://a.com/x. b https://b.org)"), ["https://a.com/x", "https://b.org"]);
  const o = G.organize("https://a.com\nagain https://a.com\n");
  assert.deepEqual(o.links, ["https://a.com"]);
  assert.equal(o.repeatedLinks, 1);
});

t("speakers: longest icon wins, unmarked is unlabelled", () => {
  assert.equal(G.speakerOf("🐶🐲 same jam", speakers), "Grok");
  assert.equal(G.speakerOf("🐶 woof", speakers), "Dog");
  assert.equal(G.speakerOf("🐗 Update", speakers), "Boardy");
  assert.equal(G.speakerOf("no mark", speakers), "unlabelled");
});

t("organize, don't cut", () => {
  const text = "one\n\n🌀 two\nthree?\r\n💎 four\n   \nhttps://x.y\n";
  const o = G.organize(text);
  assert.equal(o.check.nonBlank, 5);
  assert.equal(o.check.kept, 5);
  assert.ok(o.check.nothingCut);
  const all = Object.values(o.sections).flat().sort((a, b) => a.n - b.n).map((x) => x.text);
  assert.deepEqual(all, ["one", "🌀 two", "three?", "💎 four", "https://x.y"]);
});

t("insertLink keeps everything, four places", () => {
  const base = "top line\nNEW NEWS\nold news\nend";
  const c = G.insertLink(base, "https://L", "cursor", "top line".length);
  assert.equal(c.text, "top line\nhttps://L\nNEW NEWS\nold news\nend");
  assert.equal(c.text.slice(0, c.cursor), "top line\nhttps://L");
  const mid = G.insertLink("abcdef\nnext", "https://L", "cursor", 3);
  assert.equal(mid.text, "abcdef\nhttps://L\nnext");
  const blank = G.insertLink("a\n\nb", "https://L", "cursor", 2);
  assert.equal(blank.text, "a\nhttps://L\nb");
  assert.equal(blank.cursor, 2 + "https://L".length);
  assert.equal(G.insertLink(base, "https://L", "top").text, "https://L\n" + base);
  assert.equal(G.insertLink(base, "https://L", "news").text, "top line\nNEW NEWS\nhttps://L\nold news\nend");
  assert.equal(G.insertLink(base, "https://L", "bottom").text, base + "\nhttps://L");
  assert.equal(G.insertLink("", "https://L", "bottom").text, "https://L");
  assert.equal(G.insertLink(base, "   ", "top").text, base);
  for (const w of ["cursor", "top", "news", "bottom"]) {
    const out = G.insertLink(base, "https://L", w, 5).text;
    assert.equal(out.split("\n").filter((l) => l !== "https://L").join("\n"), base);
  }
});

t("flow: interject never moves you, ready always does, never stuck", () => {
  let f = G.newFlow(["A", "B"]);
  assert.equal(f.steps.length, 6);
  f = G.write(f, "news https://n.com");
  f = G.interject(f, "phoenix thought");
  assert.equal(f.at, 0);
  f = G.interject(f, "   ");
  assert.equal(f.backlog.length, 1);
  let readies = 0;
  while (!G.isDone(f)) { f = G.ready(f); readies++; }
  assert.equal(readies, 5);
  assert.equal(G.ready(f).at, 5);
  assert.equal(G.back(G.newFlow()).at, 0);
});

t("homework + markdown + AI prompt", () => {
  let f = G.newFlow(["Box"]);
  f = G.write(f, "NEW NEWS\nI need to fix the reader\nIs there a notification?\nlater ⏭️\nlock 💎");
  f = G.interject(f, "cats in the patio");
  const hw = G.homework(f);
  assert.deepEqual(hw.todo, ["I need to fix the reader"]);
  assert.deepEqual(hw.questions, ["Is there a notification?"]);
  assert.deepEqual(hw.backlog, ["cats in the patio"]);
  const md = G.toMarkdown(f);
  assert.ok(md.includes("5 of 5 lines kept"));
  assert.ok(md.includes("1. cats in the patio"));
  const p = G.aiPrompt(f);
  assert.ok(p.startsWith("You are my GHOST WRITER IN THE MIRROR"));
  assert.ok(p.includes("I need to fix the reader"));
});

t("NEW NEWS footer never touches the spiral zone", () => {
  let f = G.newFlow(["Box"]);
  f = G.write(f, "NEW NEWS\nfirst item");
  f = G.ready(G.ready(f));            // now on Box
  f = G.write(f, "my spiral text");
  f = G.interject(f, "parked thought");
  const g = G.newsDrop(f, "https://example.com/found-it");
  assert.equal(g.at, f.at);
  assert.equal(g.answers.box1, "my spiral text");
  assert.deepEqual(g.backlog, f.backlog);
  assert.equal(g.answers.news, "NEW NEWS\nfirst item\nhttps://example.com/found-it");
  assert.equal(G.newsDrop(g, "   "), g);
  assert.equal(G.newsDrop(G.newFlow(), "x").answers.news, "x");
});

const file = process.argv[2];
if (file) {
  t(`real doc: ${file}`, () => {
    const text = fs.readFileSync(file, "utf8");
    const o = G.organize(text, speakers);
    assert.ok(o.check.nothingCut);
    console.log("   lines kept:", o.check.kept, "links:", o.links.length,
      "sections:", Object.fromEntries(Object.entries(o.sections).map(([k, v]) => [k, v.length])),
      "speakers:", o.bySpeaker);
  });
}
console.log(`${n} tests passed`);
