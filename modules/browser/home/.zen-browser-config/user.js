// Zen Browser — S1BGr0uP canonical user.js (dotfiles-s1b)
// Apply into the LIVE profile: ~/.zen/<profile>/user.js
// Never commit prefs.js (session/account PII).

// --- hardening ---
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("browser.ping-centre.telemetry", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.ml.enable", false);
user_pref("browser.ml.chat.enabled", false);
user_pref("browser.ml.linkPreview.enabled", false);
user_pref("browser.tabs.groups.smart.enabled", false);
user_pref("extensions.ml.enabled", false);
user_pref("network.trr.mode", 2); // DoH + system DNS fallback
user_pref("network.trr.uri", "https://cloudflare-dns.com/dns-query");

// --- chrome / userChrome ---
user_pref("devtools.chrome.enabled", true);
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// --- cold-start (2026-10-26) ---
user_pref("browser.sessionstore.restore_on_demand", true);
user_pref("browser.sessionstore.max_concurrent_tabs", 3);
user_pref("zen.workspaces.continue-where-left-off", false);

// --- compact style (2026-10-26) ---
user_pref("zen.view.compact.hide-tabbar", true);
user_pref("zen.view.compact.hide-toolbar", true);
user_pref("zen.view.use-single-toolbar", false);
user_pref("uc.pins.legacy-layout", false); // SuperPins modern layout

// --- VAAPI / AMD RX 6700 XT (2026-10-26) ---
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.hardware-video-decoding.enabled", true);
user_pref("media.hardware-video-decoding.force-enabled", true);
user_pref("media.rdd-ffmpeg.enabled", true);
