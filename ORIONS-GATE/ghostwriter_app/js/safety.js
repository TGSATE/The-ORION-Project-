// SOS cool-off ladder and "where am I in time" for Ghost Writer in the Mirror.
// Added at OR20.3 (11 October 2026) from Beth's design. Pure logic, no screen code,
// so it can be tested with `node test/safety.test.mjs`.
//
// Ground rules that never change, whatever rung someone is on:
//  * The crisis line stays on screen the whole time. Nobody is ever locked out of help.
//  * Writing never stops. A cool-off only pauses moving FORWARD (the Ready / ⏭️ button);
//    the spiral box stays open so the player can keep settling down in their own words.
//  * Tapping 🆘 yourself is never punished. Asking for help does not climb the ladder.
//  * Everything stays on the player's own device. Nothing is sent anywhere.

// ---------------------------------------------------------------- time awareness

/**
 * "Where the player is in time": the device's own date, clock and time zone.
 * The app stamps this on every session and hands it to the AI, so no helper ever
 * has to guess (or think it is still the same morning two days later).
 */
export function timeContext(now = new Date(), timeZone) {
  const opts = { timeZone, weekday: "long", day: "numeric", month: "long", year: "numeric" };
  const date = new Intl.DateTimeFormat("en-GB", opts).format(now);
  const clock = new Intl.DateTimeFormat("en-US", { timeZone, hour: "numeric", minute: "2-digit" }).format(now);
  const zone = timeZone || Intl.DateTimeFormat().resolvedOptions().timeZone || "device time";
  return { date, clock, zone, iso: now.toISOString(), line: `${date}, ${clock} (${zone})` };
}

// ---------------------------------------------------------------- the ladder

/** Cool-off lengths in minutes, from Beth's design: 5m, 10m, 30m, 1h, 3h, 6h, 12h, 1 day. */
export const LADDER_MINUTES = [5, 10, 30, 60, 180, 360, 720, 1440];

/** After this many days with no trigger, the ladder goes back to the first rung. */
export const CALM_RESET_DAYS = 7;

/** Fresh safety state for a new player. */
export const newSafety = () => ({ rung: 0, until: 0, last: 0, spiralOnly: false, seen: [], log: [] });

// Clear first-person or explicit harm talk. Kept deliberately narrow so everyday
// venting ("this bug is killing me", "I'm so done") does NOT set it off: venting is
// not a crisis (Beth's rule E1).
const HARM_PATTERNS = [
  /\b(kill|hurt|harm|cut|shoot|hang|end)\s+(myself|my\s*self)\b/i,
  /\bend\s+my\s+(own\s+)?life\b/i,
  /\bend\s+it\s+all\b/i,
  /\b(want|wanna|going|gonna|plan(ning)?)\s+(to\s+)?die\b/i,
  /\bsuicid(e|al)\b/i,
  /\bself[\s-]?harm(ing)?\b/i,
  /\b(want|wanna|going|gonna|plan(ning)?)\s+(to\s+)?(kill|hurt|shoot|stab)\s+(him|her|them|someone|somebody|people|everyone|you)\b/i,
];

/** The first line of `text` that reads as harm talk, or null. */
export function findHarmTalk(text) {
  for (const line of String(text ?? "").split(/\r?\n/)) {
    if (HARM_PATTERNS.some((re) => re.test(line))) return line.trim();
  }
  return null;
}

/** Forget an old run of triggers after a calm week. */
export function settleWithTime(s, now) {
  if (s.last && !s.spiralOnly && now - s.last >= CALM_RESET_DAYS * 864e5 && now >= s.until) {
    return { ...s, rung: 0 };
  }
  return s;
}

/**
 * Harm talk was written. Start the next cool-off on the ladder. Once a full day's
 * cool-off has already been served, a further trigger puts the player in
 * spiral-only mode: they can keep writing and keep the crisis line, but cannot move
 * forward until someone they trust checks in with them (see `checkIn`).
 * The same line never counts twice.
 */
export function trigger(s, now, line = "") {
  s = settleWithTime(s, now);
  if (line && s.seen.includes(line)) return s;
  const seen = line ? [...s.seen, line] : s.seen;
  const log = [...s.log, { at: now, rung: s.rung }];
  if (s.rung >= LADDER_MINUTES.length) {
    return { ...s, seen, log, last: now, spiralOnly: true, until: Math.max(s.until, now) };
  }
  const until = now + LADDER_MINUTES[s.rung] * 60e3;
  return { ...s, seen, log, last: now, rung: s.rung + 1, until };
}

/** The player chose to pause themselves. A short cool-off, and the ladder does not climb. */
export function selfPause(s, now) {
  return { ...s, until: Math.max(s.until, now + LADDER_MINUTES[0] * 60e3) };
}

/** Where the player stands right now. */
export function status(s, now) {
  if (s.spiralOnly) return { mode: "spiral-only", msLeft: 0 };
  if (now < s.until) return { mode: "cool-off", msLeft: s.until - now };
  return { mode: "open", msLeft: 0 };
}

/** Moving forward (Ready / ⏭️) is allowed only when open. Writing is always allowed. */
export const canMoveForward = (s, now) => status(s, now).mode === "open";

/**
 * Spiral-only ends with a check-in: the player names the professional, group or
 * trusted person who has seen them settle. The app cannot verify this (there are
 * no biometrics in a free browser app); it records it on the device and goes back
 * to the first rung.
 */
export function checkIn(s, now, who) {
  who = String(who ?? "").trim();
  if (!who) return s;
  return { ...s, spiralOnly: false, rung: 0, until: now, log: [...s.log, { at: now, checkIn: who }] };
}

/** "4 min", "2 h 30 min", "1 day". */
export function formatLeft(ms) {
  const m = Math.ceil(ms / 60e3);
  if (m >= 1440 && m % 1440 === 0) return `${m / 1440} day`;
  const h = Math.floor(m / 60), r = m % 60;
  return h ? `${h} h${r ? ` ${r} min` : ""}` : `${r} min`;
}

// ---------------------------------------------------------------- time trail (OR20.4)
// Beth, OR20.3: "we don't want the time stamped message to become the now time. It
// needs to be a comparative: a message needs to be stamped with the last time it was
// interacted with, and when the user comes back to it, it needs to stamp it again as
// it's ported in time." So a session carries a TRAIL of stamps, not one "now".

/** Away this long (minutes) and coming back counts as being "ported back in". */
export const RETURN_GAP_MIN = 30;

/** A fresh trail: started now, last worked on now, no returns yet. */
export const newTrail = (now) => ({ started: now, last: now, returns: [] });

/** The player touched the session at `now`. After a long gap, stamp a return. */
export function touch(trail, now) {
  if (!trail || typeof trail.last !== "number") return newTrail(now);
  if (now < trail.last) return trail; // a clock that went backwards changes nothing
  const away = now - trail.last;
  const returns = away >= RETURN_GAP_MIN * 60e3 ? [...trail.returns, { left: trail.last, back: now }] : trail.returns;
  return { ...trail, last: now, returns };
}

/** "12 min", "3 h 5 min", "2 days 4 h". */
export function formatGap(ms) {
  const m = Math.max(0, Math.round(ms / 60e3));
  const d = Math.floor(m / 1440), h = Math.floor((m % 1440) / 60), r = m % 60;
  if (d) return `${d} day${d > 1 ? "s" : ""}${h ? ` ${h} h` : ""}`;
  return h ? `${h} h${r ? ` ${r} min` : ""}` : `${r} min`;
}

/**
 * The stamps, as lines for the exported session. `handedAt` is when the player
 * copied it out; it is a stamp too, not a clock that keeps running.
 */
export function trailLines(trail, handedAt, fmt = (ms) => timeContext(new Date(ms)).line) {
  if (!trail) return [`Handed over: ${fmt(handedAt)}`];
  const out = [`Started: ${fmt(trail.started)}`];
  for (const r of trail.returns) {
    out.push(`Ported back in: ${fmt(r.back)} (away ${formatGap(r.back - r.left)}; last worked on ${fmt(r.left)})`);
  }
  out.push(`Last worked on: ${fmt(trail.last)}`);
  out.push(`Handed over: ${fmt(handedAt)} (${formatGap(handedAt - trail.last)} after the last edit, ${formatGap(handedAt - trail.started)} after the start)`);
  return out;
}

// ---------------------------------------------------------------- touchstone (OR20.4)
// Beth, OR20.3: if somebody leaves a session still in SOS and doesn't come back
// within 12 hours, somebody needs to check in and be their touchstone.
// A free app with no server cannot send anything once it is closed. So the timer
// goes to a PERSON the player chose: one tap texts them, with the time by which
// they should check in if they haven't heard back. Nothing is sent without the tap.

/** Hours after which a touchstone should check in if they haven't heard back. */
export const CHECK_HOURS = 12;

/** The text a player sends their touchstone. kind: "sos" or "ok". */
export function touchstoneText(kind, deadlineLine = "") {
  if (kind === "ok") return "Update: I'm OK now. Thank you for being my touchstone. 💛";
  return "I'm having a hard time and I've hit my SOS button. Can you check in with me?" +
    (deadlineLine ? ` If you haven't heard from me by ${deadlineLine}, please call me or come check on me.` : "");
}

/** A tap-to-text link. The phone opens its own messages app; nothing sends by itself. */
export function smsHref(phone, body) {
  const p = String(phone ?? "").replace(/[^\d+]/g, "");
  return `sms:${p}?&body=${encodeURIComponent(body)}`;
}

/** Did the player leave in SOS and stay away at least CHECK_HOURS? */
export function cameBackFromSos(sosSince, lastSeen, now) {
  return Boolean(sosSince) && typeof lastSeen === "number" && now - lastSeen >= CHECK_HOURS * 3600e3;
}
