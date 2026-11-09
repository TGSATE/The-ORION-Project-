// SOS ladder + time tests. Run: node ghostwriter_app/test/safety.test.mjs
import assert from "node:assert/strict";
import * as S from "../js/safety.js";

let n = 0;
const t = (name, f) => { f(); n++; console.log("ok", name); };
const MIN = 60e3;

t("venting is not a crisis (E1)", () => {
  for (const v of ["this bug is killing me", "I'm so done with this", "I am fucking pissed",
    "kill the old build", "my arm fucking hurts", "I was about ready to go nuclear"]) {
    assert.equal(S.findHarmTalk(v), null, v);
  }
});

t("clear harm talk is caught", () => {
  for (const h of ["I want to kill myself", "thinking about suicide", "I'm gonna hurt myself",
    "I want to die", "I'm going to hurt someone", "I want to end my life", "self-harm again"]) {
    assert.ok(S.findHarmTalk(h), h);
  }
});

t("ladder climbs 5m,10m,30m,1h,3h,6h,12h,1day then spiral-only", () => {
  let s = S.newSafety(), now = 0;
  for (const m of S.LADDER_MINUTES) {
    s = S.trigger(s, now, `line ${now}`);
    assert.equal(S.status(s, now).mode, "cool-off");
    assert.equal(s.until - now, m * MIN);
    assert.equal(S.canMoveForward(s, now), false);
    now = s.until;
    assert.equal(S.status(s, now).mode, "open");
  }
  s = S.trigger(s, now, "once more");
  assert.equal(S.status(s, now).mode, "spiral-only");
  assert.equal(S.canMoveForward(s, now + 1e12), false);
  assert.equal(S.checkIn(s, now, "  "), s);          // a blank check-in does nothing
  s = S.checkIn(s, now, "my sister came over");
  assert.equal(S.status(s, now).mode, "open");
  assert.equal(s.rung, 0);
});

t("the same line never counts twice", () => {
  let s = S.trigger(S.newSafety(), 0, "I want to die");
  const again = S.trigger(s, 10 * MIN, "I want to die");
  assert.equal(again, s);
});

t("tapping SOS yourself never climbs the ladder", () => {
  let s = S.selfPause(S.newSafety(), 0);
  assert.equal(s.rung, 0);
  assert.equal(S.status(s, 0).mode, "cool-off");
  assert.equal(S.status(s, 5 * MIN).mode, "open");
});

t("a calm week resets the ladder", () => {
  let s = S.trigger(S.trigger(S.newSafety(), 0, "a"), 20 * MIN, "b");
  assert.equal(s.rung, 2);
  s = S.trigger(s, 20 * MIN + 7 * 864e5, "c");
  assert.equal(s.until - (20 * MIN + 7 * 864e5), 5 * MIN);
});

t("time context names the date, clock and zone", () => {
  const c = S.timeContext(new Date("2026-10-11T12:35:00Z"), "America/Chicago");
  assert.ok(c.date.includes("Sunday") && c.date.includes("11 October 2026"), c.date);
  assert.ok(/^7:35\s?AM$/.test(c.clock), c.clock);
  assert.ok(c.line.includes("America/Chicago"));
  assert.equal(S.formatLeft(90 * MIN), "1 h 30 min");
  assert.equal(S.formatLeft(1440 * MIN), "1 day");
  assert.equal(S.formatLeft(4.2 * MIN), "5 min");
});


t("time trail: stamps, not one now (OR20.4)", () => {
  let tr = S.newTrail(0);
  tr = S.touch(tr, 10 * MIN);          // still working: no return
  assert.equal(tr.returns.length, 0);
  tr = S.touch(tr, 10 * MIN + 3 * 3600e3); // came back 3 h later
  assert.equal(tr.returns.length, 1);
  assert.deepEqual(tr.returns[0], { left: 10 * MIN, back: 10 * MIN + 3 * 3600e3 });
  assert.equal(S.touch(tr, 0), tr, "a clock going backwards changes nothing");
  const lines = S.trailLines(tr, tr.last + 5 * MIN, (ms) => `T${ms / MIN}`);
  assert.equal(lines[0], "Started: T0");
  assert.match(lines[1], /^Ported back in: T190 \(away 3 h; last worked on T10\)$/);
  assert.equal(lines[2], "Last worked on: T190");
  assert.match(lines[3], /^Handed over: T195 \(5 min after the last edit, 3 h 15 min after the start\)$/);
  assert.equal(S.formatGap(2 * 864e5 + 4 * 3600e3), "2 days 4 h");
});

t("touchstone: text carries the check-in time; nothing sends by itself (OR20.4)", () => {
  const msg = S.touchstoneText("sos", "Monday, 1:00 AM");
  assert.match(msg, /SOS/);
  assert.match(msg, /by Monday, 1:00 AM/);
  assert.match(S.touchstoneText("ok"), /OK now/);
  const href = S.smsHref("(555) 123-4567", "hi there");
  assert.equal(href, "sms:5551234567?&body=hi%20there");
  assert.equal(S.cameBackFromSos(0, 0, 13 * 3600e3), false, "not in SOS: no prompt");
  assert.equal(S.cameBackFromSos(1, 0, 11 * 3600e3), false, "back within 12 h: no prompt");
  assert.equal(S.cameBackFromSos(1, 0, 12 * 3600e3), true, "away 12 h in SOS: ask how they are");
});

console.log(`${n} tests passed`);
