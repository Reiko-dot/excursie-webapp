// Verhoog dit versienummer bij elke deploy om de cache te verversen.
const CACHE_VERSION = 'v1';
const SHELL_CACHE = 'excursie-shell-' + CACHE_VERSION;
const DATA_CACHE = 'excursie-data-' + CACHE_VERSION;

// De "app shell": alles wat nodig is om de interface te tonen, ook offline.
const SHELL_FILES = [
    './',
    './index.html',
    './style.css',
    './app.js',
    './manifest.json',
    './icons/icon-192.png',
    './icons/icon-512.png',
    './icons/icon-maskable-512.png',
];

self.addEventListener('install', (event) => {
    event.waitUntil(
        caches.open(SHELL_CACHE)
            .then((cache) => cache.addAll(SHELL_FILES))
            .then(() => self.skipWaiting())
    );
});

self.addEventListener('activate', (event) => {
    event.waitUntil(
        caches.keys().then((keys) => Promise.all(
            keys
                .filter((key) => key !== SHELL_CACHE && key !== DATA_CACHE)
                .map((key) => caches.delete(key))
        )).then(() => self.clients.claim())
    );
});

self.addEventListener('fetch', (event) => {
    const { request } = event;
    const url = new URL(request.url);

    // API-data: eerst het netwerk proberen (verse data uit de database),
    // val terug op de laatst opgeslagen versie als er geen verbinding is.
    if (url.pathname.endsWith('/api.php')) {
        event.respondWith(
            fetch(request)
                .then((response) => {
                    const clone = response.clone();
                    caches.open(DATA_CACHE).then((cache) => cache.put(request, clone));
                    return response;
                })
                .catch(() => caches.match(request))
        );
        return;
    }

    // App-shell bestanden: eerst cache, dan pas netwerk (snel + offline-proof).
    if (request.method === 'GET' && url.origin === self.location.origin) {
        event.respondWith(
            caches.match(request).then((cached) => cached || fetch(request))
        );
    }
});
