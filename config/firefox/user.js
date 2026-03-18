// ==============================
// UI & APPEARANCE
// ==============================

// enable userChrome.css / userContent.css
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
    "dearrow_ajay_app-browser-action",
    "jid1-mnnxcxisbpnsxq_jetpack-browser-action"
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

user_pref("browser.uiCustomization.state", "{\"placements\":{\"nav-bar\":[\"sidebar-button\",\"firefox-view-button\",\"back-button\",\"stop-reload-button\",\"forward-button\",\"customizableui-special-spring1\",\"urlbar-container\",\"new-tab-button\",\"customizableui-special-spring2\",\"downloads-button\",\"unified-extensions-button\",\"fxa-toolbar-menu-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"alltabs-button\",\"tabbrowser-tabs\"]},\"seen\":[\"_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"private-bookmarks_rharel-browser-action\",\"dearrow_ajay_app-browser-action\",\"jid1-mnnxcxisbpnsxq_jetpack-browser-action\"],\"dirtyAreaCache\":[\"unified-extensions-area\",\"nav-bar\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\"],\"currentVersion\":99999999,\"newElementCount\":0}");

// toolbar / layout
user_pref("browser.toolbars.bookmarks.visibility", "never"); // "always" | "never" | "newtab"
user_pref("browser.compactmode.show", true);
user_pref("browser.uidensity", 1); // 0=normal, 1=compact, 2=touch

// sidebar & profiles
user_pref("sidebar.revamp", false);
user_pref("sidebar.main.tools", "syncedtabs,history,bookmarks"); // comma-separated modules
user_pref("sidebar.verticalTabs", false);
user_pref("browser.profiles.enabled", true);

// system integration
user_pref("browser.display.use_system_colors", true);
user_pref("ui.systemUsesDarkTheme", true);
user_pref("browser.tabs.inTitlebar", 0); // 0=separate titlebar, 1=integrated
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.download.start_downloads_in_tmp_dir", true);
user_pref("browser.theme.content-theme", 2); // 0=light, 1=dark, 2=system
user_pref("browser.theme.toolbar-theme", 2); // 0=light, 1=dark, 2=system

// misc UI tweaks
user_pref("browser.quitShortcut.disabled", true);
user_pref("browser.download.manager.showWhenStarting", false);
user_pref("browser.newtabpage.activity-stream.logowordmark.alwaysVisible", true);
user_pref("devtools.chrome.enabled", true);
user_pref("devtools.theme", "auto"); // "dark" | "light" | "auto"


// ==============================
// PERFORMANCE & RENDERING
// ==============================

user_pref("layers.acceleration.force-enabled", true);
user_pref("gfx.webrender.all", true);
user_pref("svg.context-properties.content.enabled", true);

// smooth scrolling tuning (MSD physics model)
user_pref("general.smoothScroll.msdPhysics.enabled", true);
user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 250);
user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant", 400);
user_pref("general.smoothScroll.msdPhysics.regularSpringConstant", 400);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS", 120);
user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant", 5000);

// scroll sensitivity
user_pref("mousewheel.min_line_scroll_amount", 22);
user_pref("toolkit.scrollbox.horizontalScrollDistance", 4);
user_pref("toolkit.scrollbox.verticalScrollDistance", 5);

// input/render latency
user_pref("apz.frame_delay.enabled", false);

// fullscreen animation (ms)
user_pref("full-screen-api.transition-duration.enter", 50);
user_pref("full-screen-api.transition-duration.leave", 50);


// ==============================
// TAB & SESSION MANAGEMENT
// ==============================

user_pref("browser.tabs.allowTabDetach", false);
user_pref("browser.ctrlTab.sortByRecentlyUsed", true);

// session history limits
user_pref("browser.sessionhistory.max_entries", 20);
user_pref("browser.sessionhistory.max_total_viewers", 5);

// undo / memory behavior
user_pref("browser.sessionstore.max_tabs_undo", 10);
user_pref("browser.tabs.unloadOnLowMemory", true);

// recover from crash
user_pref("browser.sessionstore.resume_from_crash", true);

// restore session
user_pref("browser.startup.page", 3);

// ==============================
// MEMORY & CACHE
// ==============================

user_pref("config.trim_on_minimize", true);
user_pref("browser.cache.memory.capacity", 307200); // KB (~300MB)


// ==============================
// ZOOM & FONT RENDERING
// ==============================

// zoom behavior
user_pref("browser.zoom.siteSpecific", false);

// allowed zoom levels (comma-separated float scale values)
user_pref("toolkit.zoomManager.zoomValues"
	, "0.30,0.35,0.40,0.45,0.50,0.55,0.60,0.65,0.70,0.75,0.80,0.85,0.90,0.95,1.00,1.05,1.10,1.15,1.20,1.25,1.30,1.35,1.40,1.45,1.50,1.55,1.60,1.65,1.70,1.75,1.80,1.85,1.90,1.95,2.00,2.05,2.10,2.15,2.20,2.25,2.30,2.35,2.40,2.45,2.50,2.55,2.60,2.65,2.70,2.75,2.80,2.85,2.90,2.95,3.00,3.05,3.10,3.15,3.20,3.25,3.30,3.35,3.40,3.45,3.50");

// font behavior
user_pref("browser.display.use_document_fonts", 1); // 0=disable site fonts, 1=allow
user_pref("gfx.font_rendering.opentype_svg.enabled", false);
user_pref("gfx.font_rendering.fontconfig.max_generic_substitutions", 127);
user_pref("font.name-list.emoji", "emoji"); // preferred emoji font family


// ==============================
// CSS & WEB FEATURES
// ==============================

user_pref("layout.css.color-mix.enabled", true);
user_pref("layout.css.color-mix.color-spaces.enabled", true);
user_pref("layout.css.backdrop-filter.enabled", true);
user_pref("layout.css.has-selector.enabled", true);
user_pref("layout.css.prefers-color-scheme.content-override", 2); // 0=light, 1=dark, 2=system

// ==============================
// PRIVACY HARDENING
// ==============================

// isolation & URL sanitization
user_pref("privacy.firstparty.isolate", true);
user_pref("privacy.query_stripping", true);

// tracking protection
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.pbmode.enabled", true);
user_pref("privacy.trackingprotection.fingerprinting.enabled", true);
user_pref("privacy.trackingprotection.cryptomining.enabled", true);
// -> fix severly broken sites
user_pref("privacy.trackingprotection.allow_list.baseline.enabled", true);
user_pref("privacy.trackingprotection.allow_list.convenience.enabled", false);
// network leaks
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("dom.battery.enabled", false);

// referer trimming policies
user_pref("network.http.referer.trimmingPolicy", 1); // 0=full, 1=scheme+host+path, 2=scheme+host
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

// font fingerprinting resistance
user_pref("layout.css.font-visibility.private", 1);
user_pref("layout.css.font-visibility.trackingprotection", 1);

// strict blocking mode
user_pref("browser.contentblocking.category", "strict"); // "standard" | "strict" | "custom"

// attribution API
user_pref("dom.private-attribution.submission.enabled", false);

// DNT disabled (fingerprinting risk)
user_pref("privacy.donottrackheader.enabled", false);

// container isolation
user_pref("privacy.usercontext.about_newtab_segregation.enabled", true);


// ==============================
// SECURITY
// ==============================

// TLS / crypto
user_pref("security.tls.enable_kyber", true);

// Encrypted Client Hello (ECH)
user_pref("network.dns.echconfig.enabled", true);
user_pref("network.dns.http3_echconfig.enabled", true);
user_pref("network.dns.use_https_rr_as_altsvc", true);

// DRM
user_pref("media.eme.enabled", false);
user_pref("browser.eme.ui.enabled", false);

// WebGL fingerprinting
user_pref("webgl.enable-debug-renderer-info", false);


// ==============================
// NETWORKING
// ==============================

// DNS mode
user_pref("network.trr.mode", 5); // 0=off, 2=TRR first, 3=TRR only, 5=off by choice

// captive portal detection
user_pref("captivedetect.canonicalURL", "");
user_pref("network.captive-portal-service.enabled", false);

// window/tab behavior
user_pref("browser.link.open_newwindow", 3); // 1=replace-current, 2=new-window, 3=new-tab
user_pref("browser.link.open_newwindow.restriction", 0); // 0=force, 1=ignore, 2=allow-override


// ==============================
// MEDIA
// ==============================

user_pref("media.autoplay.blocking_policy", 2); // 0=allow, 1=block audible, 2=block all
user_pref("media.navigator.enabled", false);
user_pref("image.jxl.enabled", true);


// ==============================
// FIREFOX SERVICES / BLOAT DISABLE
// ==============================

// pocket
user_pref("pocket.enabled", false);
user_pref("extensions.pocket.enabled", false);
user_pref("extensions.pocket.onSaveRecs", false);

// onboarding
user_pref("browser.onboarding.enabled", false);
user_pref("browser.onboarding.newtour", "performance,private,addons,customize,default");
user_pref("browser.onboarding.updatetour", "performance,library,singlesearch,customize");

// experiments / studies
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);

// thumbnails
user_pref("browser.pagethumbnails.capturing_disabled", true);

// remote config
user_pref("browser.selfsupport.url", "");


// ==============================
// NEW TAB CLEANUP
// ==============================

// sponsored content
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored", false);
user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites", false);

// top sites
user_pref("browser.newtabpage.activity-stream.feeds.topsites", true);

// recommendations
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("services.sync.prefs.sync-seen.browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("services.sync.prefs.sync-seen.browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);

// highlights
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("services.sync.prefs.sync-seen.browser.newtabpage.activity-stream.section.highlights.includePocket", false);

// directory / telemetry endpoints
user_pref("browser.newtabpage.directory.source", "");
user_pref("browser.newtabpage.directory.ping", "");

// intro state
user_pref("browser.newtabpage.introShown", true);


// ==============================
// TELEMETRY & DATA COLLECTION
// ==============================

user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);

user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.healthreport.service.enabled", false);

user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("datareporting.sessions.current.clean", true);
user_pref("datareporting.policy.firstRunURL", "");


// ==============================
// SAFE BROWSING
// ==============================
user_pref("browser.safebrowsing.enabled", true);
user_pref("browser.safebrowsing.malware.enabled", true);
user_pref("browser.safebrowsing.phishing.enabled", true);

user_pref("browser.safebrowsing.downloads.enabled", true);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);

user_pref("browser.safebrowsing.appRepURL", "");
user_pref("browser.safebrowsing.downloads.remote.url", "");
user_pref("browser.safebrowsing.blockedURIs.enabled", true);

// ==============================
// AI Features
// ==============================
user_pref("browser.ai.control.default", "blocked");
user_pref("browser.ai.control.pdfjsAltText", "enabled");
user_pref("browser.ai.control.smartTabGroups", "enabled");
user_pref("browser.ai.control.translations", "available");

// LLM features
user_pref("browser.ml.chat.enabled", false);
user_pref("browser.ml.chat.sidebar", false);
user_pref("browser.ml.chat.shortcuts", false);
user_pref("browser.ml.chat.shortcuts.custom", false);
user_pref("browser.ml.chat.linkPreview.enabled", false);
user_pref("browser.ml.chat.pageAssist.enabled", false);
user_pref("browser.ml.chat.smartAssist.enabled", false);