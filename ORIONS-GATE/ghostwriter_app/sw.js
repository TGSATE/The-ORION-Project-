// Offline support: the app keeps working with no signal once it has been opened once.
const CACHE = "ghostwriter-v4";
const FILES = ["./", "index.html", "style.css", "privacy.html", "icon.svg", "manifest.webmanifest",
  "js/app.js", "js/core.js", "js/config.js", "js/safety.js"];
self.addEventListener("install", (e) => e.waitUntil(caches.open(CACHE).then((c) => c.addAll(FILES))));
self.addEventListener("activate", (e) =>
  e.waitUntil(caches.keys().then((ks) => Promise.all(ks.filter((k) => k !== CACHE).map((k) => caches.delete(k))))));
self.addEventListener("fetch", (e) => {
  if (e.request.method !== "GET") return;
  e.respondWith(fetch(e.request).then((r) => {
    const copy = r.clone();
    caches.open(CACHE).then((c) => c.put(e.request, copy));
    return r;
  }).catch(() => caches.match(e.request)));
});
