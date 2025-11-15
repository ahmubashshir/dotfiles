// doc https://brainfucksec.github.io/firefox-hardening-guide

// enable user*.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
/* key: browser.uiCustomization.state | use `jq 'tostring'` to encode
ui@json
{
  "placements": {
    "nav-bar": [
      "sidebar-button",
      "firefox-view-button",
      "back-button",
      "stop-reload-button",
      "forward-button",
      "customizableui-special-spring1",
      "urlbar-container",
      "new-tab-button",
      "customizableui-special-spring2",
      "downloads-button",
      "unified-extensions-button",
      "fxa-toolbar-menu-button"
    ],
    "toolbar-menubar": [
      "menubar-items"
    ],
    "TabsToolbar": [
      "alltabs-button",
      "tabbrowser-tabs"
    ]
  },
  "seen": [
    "_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action",
    "ublock0_raymondhill_net-browser-action",
    "sponsorblocker_ajay_app-browser-action",
    "private-bookmarks_rharel-browser-action",
    "dearrow_ajay_app-browser-action"
  ],
  "dirtyAreaCache": [
    "unified-extensions-area",
    "nav-bar",
    "PersonalToolbar",
    "toolbar-menubar",
    "TabsToolbar"
  ],
  "currentVersion": 99999999,
  "newElementCount": 0
}
json@ui
 */
user_pref("browser.uiCustomization.state", "{\"placements\":{\"nav-bar\":[\"sidebar-button\",\"firefox-view-button\",\"back-button\",\"stop-reload-button\",\"forward-button\",\"customizableui-special-spring1\",\"urlbar-container\",\"new-tab-button\",\"customizableui-special-spring2\",\"downloads-button\",\"unified-extensions-button\",\"fxa-toolbar-menu-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"alltabs-button\",\"tabbrowser-tabs\"]},\"seen\":[\"_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"private-bookmarks_rharel-browser-action\",\"dearrow_ajay_app-browser-action\"],\"dirtyAreaCache\":[\"unified-extensions-area\",\"nav-bar\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\"],\"currentVersion\":99999999,\"newElementCount\":0}");
// hide bookmark bar
user_pref("browser.toolbars.bookmarks.visibility", "never");
// enable legacy compact mode
user_pref("browser.compactmode.show", true);
// disable revamped sidebar
user_pref("sidebar.revamp", false);
// enable profile store and profile chooser ui
user_pref("browser.profiles.enabled", true);
// enabled tools in revamped sidebar
user_pref("sidebar.main.tools", "syncedtabs,history,bookmarks");
// disable native vertical tabs
user_pref("sidebar.verticalTabs", false);
/*
 * ui density:
 *    0 -> Normal
 *    1 -> Compact
 *    2 -> Touch
 */
user_pref("browser.uidensity", 1);
// Use colors from system theme
user_pref("browser.display.use_system_colors", true);
// Enable system dark theme support
user_pref("ui.systemUsesDarkTheme", true);
// Use system titlebar
user_pref("browser.tabs.inTitlebar", 0);
// disable c-q quit
user_pref("browser.quitShortcut.disabled", true);
// end UI Customizations

// enable X25519Kyber768 hybrid post-quantum kex
user_pref("security.tls.enable_kyber", true);
// Enable css color-mix()
user_pref("layout.css.color-mix.enabled", true);
// Allow mixing multiple color spaces (hsl, rgb, cmyk)
user_pref("layout.css.color-mix.color-spaces.enabled", true);
// Enable css backdrop filter
user_pref("layout.css.backdrop-filter.enabled", true);

// smooth scrolling
user_pref("general.smoothScroll.msdPhysics.enabled", true);
user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 250);
user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant", 400);
user_pref("general.smoothScroll.msdPhysics.regularSpringConstant", 400);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS", 120);
user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant", 5000);
user_pref("mousewheel.min_line_scroll_amount", 22);
user_pref("toolkit.scrollbox.horizontalScrollDistance", 4);
user_pref("toolkit.scrollbox.verticalScrollDistance", 5);
user_pref("apz.frame_delay.enabled", false);

//Full screen fade faster:
user_pref("full-screen-api.transition-duration.enter", 50);
user_pref("full-screen-api.transition-duration.leave", 50);

//always show firefox logo in default newtab page:
user_pref("browser.newtabpage.activity-stream.logowordmark.alwaysVisible", true);
user_pref("layers.acceleration.force-enabled", true);
user_pref("gfx.webrender.all", true);
user_pref("svg.context-properties.content.enabled", true);

// Disable tab DnD detach
user_pref("browser.tabs.allowTabDetach", false);

// reduce session history stack
user_pref("browser.sessionhistory.max_entries", 20);
// reduce cached page stack
user_pref("browser.sessionhistory.max_total_viewers", 5);
// reduce max tab close undo
user_pref("browser.sessionstore.max_tabs_undo", 10);
// trim on minimize
user_pref("config.trim_on_minimize", true);
// set in-memory cache to 300M
user_pref("browser.cache.memory.capacity", 307200);
// download to temp dir unless explicitly saved
user_pref("browser.download.start_downloads_in_tmp_dir", true);
// enable jpeg-xl
//user_pref("image.jxl.enabled", true);

// Ctrl-Tab MRU order
user_pref("browser.ctrlTab.sortByRecentlyUsed", true);

// disable site-wide zoom
user_pref("browser.zoom.siteSpecific", false);
// keyboard zoom steps
user_pref("toolkit.zoomManager.zoomValues", "0.30,0.35,0.40,0.45,0.50,0.55,0.60,0.65,0.70,0.75,0.80,0.85,0.90,0.95,1.00,1.05,1.10,1.15,1.20,1.25,1.30,1.35,1.40,1.45,1.50,1.55,1.60,1.65,1.70,1.75,1.80,1.85,1.90,1.95,2.00,2.05,2.10,2.15,2.20,2.25,2.30,2.35,2.40,2.45,2.50,2.55,2.60,2.65,2.70,2.75,2.80,2.85,2.90,2.95,3.00,3.05,3.10,3.15,3.20,3.25,3.30,3.35,3.40,3.45,3.50");
// Use document fonts
user_pref("browser.display.use_document_fonts", 1);
// Enable svg fonts
user_pref("gfx.font_rendering.opentype_svg.enabled", false);
// allow maximum font substitution rules
user_pref("gfx.font_rendering.fontconfig.max_generic_substitutions", 127);
// use system emoji font
user_pref("font.name-list.emoji", "emoji");
user_pref("media.navigator.enabled", false);
user_pref("webgl.enable-debug-renderer-info", false);

/* 1=only base system fonts, 2=also fonts from optional language packs, 3=also user-installed fonts */
user_pref("layout.css.font-visibility.private", 1);
user_pref("layout.css.has-selector.enabled", true);
user_pref("layout.css.font-visibility.trackingprotection", 1);

/* 2022: disable all DRM content (EME: Encryption Media Extension) */
user_pref("media.eme.enabled", false);
user_pref("browser.eme.ui.enabled", false);

/* 2031: disable autoplay of HTML5 media if you interacted with the site [FF78+]
 * 0=sticky (default), 1=transient, 2=user
 */
user_pref("media.autoplay.blocking_policy", 2);

// use UncensoredDNS.org as TRR
user_pref("network.trr.mode", 5); // disable trr
//user_pref("network.trr.uri", "https://anycast.uncensoreddns.org/dns-query");

/* 4512: enforce links targeting new windows to open in a new tab instead
 * 1=most recent window or tab, 2=new window, 3=new tab
 * Stops malicious window sizes and some screen resolution leaks.
 * You can still right-click a link and open in a new window
 */
user_pref("browser.link.open_newwindow", 3); // [DEFAULT: 3]
/* 4513: set all open window methods to abide by "browser.link.open_newwindow" (4512)
 * [1] https://searchfox.org/mozilla-central/source/dom/tests/browser/browser_test_new_window_from_content.js ***/
user_pref("browser.link.open_newwindow.restriction", 0);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("browser.contentblocking.category", "strict");
// Disable Attribution
user_pref("dom.private-attribution.submission.enabled", false);
user_pref("browser.pagethumbnails.capturing_disabled", false);
user_pref("browser.tabs.unloadOnLowMemory", true);
user_pref("devtools.chrome.enabled", true);
user_pref("devtools.theme", "dark");

// Tor related configs
user_pref("network.proxy.socks_remote_dns", true);
user_pref("network.dns.blockDotOnion", false);

// privacy configs
user_pref("privacy.firstparty.isolate", true);
user_pref("privacy.donottrackheader.enabled", false); // can be used to track
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("dom.battery.enabled", false);
user_pref("network.http.referer.trimmingPolicy", 1);
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);
user_pref("privacy.query_stripping", true);
user_pref("privacy.trackingprotection.cryptomining.enabled", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.fingerprinting.enabled", true);
user_pref("privacy.trackingprotection.pbmode.enabled", true);

// Disable captive portal detection
user_pref("captivedetect.canonicalURL", "");
user_pref("network.captive-portal-service.enabled", false);

user_pref("browser.selfsupport.url", "");
// disable pocket
user_pref("pocket.enabled", false);
user_pref("extensions.pocket.enabled", false);
user_pref("extensions.pocket.onSaveRecs", false);

// disable activity stream feeds
user_pref("browser.newtabpage.activity-stream.feeds.topsites", true); // allow pinned sites
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("privacy.usercontext.about_newtab_segregation.enabled", true);
user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored", false);
user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("services.sync.prefs.sync-seen.browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("services.sync.prefs.sync-seen.browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("services.sync.prefs.sync-seen.browser.newtabpage.activity-stream.section.highlights.includePocket", false);

// Don't download ads for the newtab page
user_pref("browser.newtabpage.directory.source", "");
user_pref("browser.newtabpage.directory.ping", "");
user_pref("browser.newtabpage.introShown", true);

// Disable LLM integration
user_pref("browser.ml.chat.enabled", false);
user_pref("browser.ml.chat.sidebar", false);
user_pref("browser.ml.chat.shortcuts", false);
user_pref("browser.ml.chat.shortcuts.custom", false);

// disable onboarding
user_pref("browser.onboarding.newtour", "performance,private,addons,customize,default");
user_pref("browser.onboarding.updatetour", "performance,library,singlesearch,customize");
user_pref("browser.onboarding.enabled", false);

// ECH replaced ESNI
// https://blog.mozilla.org/security/2021/01/07/encrypted-client-hello-the-future-of-esni-in-firefox/
user_pref("network.dns.echconfig.enabled", true);
user_pref("network.dns.http3_echconfig.enabled", true);
user_pref("network.dns.use_https_rr_as_altsvc", true);

// disable telemetry
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("datareporting.sessions.current.clean", true);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.healthreport.service.enabled", false);

// disable safebrowsing
user_pref("browser.safebrowsing.appRepURL", "");
user_pref("browser.safebrowsing.blockedURIs.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");
user_pref("browser.safebrowsing.enabled", false);
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);