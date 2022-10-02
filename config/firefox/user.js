user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("browser.urlbar.update1", false);
user_pref("ui.systemUsesDarkTheme", true);
user_pref("layout.css.color-mix.enabled", true);
user_pref("layout.css.color-mix.color-spaces.enabled", true);

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
//user_pref("gfx.webrender.enabled", true);
user_pref("layout.css.backdrop-filter.enabled", true);
user_pref("svg.context-properties.content.enabled", true);

user_pref("browser.tabs.allowTabDetach", false);
user_pref("network.captive-portal-service.enabled", false);
user_pref("browser.selfsupport.url", "");
user_pref("pocket.enabled", false);

// reduce session history stack
user_pref("browser.sessionhistory.max_entries", 20);
// reduce cached page stack
user_pref("browser.sessionhistory.max_total_viewers", 5);
// trim on minimize
user_pref("config.trim_on_minimize", true);
// set in-memory cache to 200M
user_pref("browser.cache.memory.capacity", 204800);


/*
 * layers.acceleration.force-enabled
 * gfx.webrender.all
 * gfx.webrender.enabled
 * layout.css.backdrop-filter.enabled
 * svg.context-properties.content.enabled
 */
user_pref("browser.display.use_document_fonts", 0);
user_pref("gfx.font_rendering.opentype_svg.enabled", false);

user_pref("media.navigator.enabled", false);
user_pref("webgl.enable-debug-renderer-info", false);

/* 1=only base system fonts, 2=also fonts from optional language packs, 3=also user-installed fonts */
user_pref("layout.css.font-visibility.private", 1);
user_pref("layout.css.font-visibility.private", 1);
user_pref("layout.css.font-visibility.trackingprotection", 1);

/* 2022: disable all DRM content (EME: Encryption Media Extension) */
user_pref("media.eme.enabled", false);
user_pref("browser.eme.ui.enabled", false);

/* 2031: disable autoplay of HTML5 media if you interacted with the site [FF78+]
 * 0=sticky (default), 1=transient, 2=user
 */
user_pref("media.autoplay.blocking_policy", 2);

/* 4512: enforce links targeting new windows to open in a new tab instead
 * 1=most recent window or tab, 2=new window, 3=new tab
 * Stops malicious window sizes and some screen resolution leaks.
 * You can still right-click a link and open in a new window
 * [SETTING] General>Tabs>Open links in tabs instead of new windows
 * [TEST] https://arkenfox.github.io/TZP/tzp.html#screen
 * [1] https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/9881 ***/
user_pref("browser.link.open_newwindow", 3); // [DEFAULT: 3]
/* 4513: set all open window methods to abide by "browser.link.open_newwindow" (4512)
 * [1] https://searchfox.org/mozilla-central/source/dom/tests/browser/browser_test_new_window_from_content.js ***/
user_pref("browser.link.open_newwindow.restriction", 0);

/* 4520: disable WebGL (Web Graphics Library)
 * [SETUP-WEB] If you need it then override it. RFP still randomizes canvas for naive scripts ***/

user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.user_id", "");
user_pref("browser.compactmode.show", true);
user_pref("browser.contentblocking.category", "strict");
user_pref("browser.display.use_system_colors", true);
user_pref("browser.newtabpage.pinned", "[{\"url\":\"https://stackoverflow.com/\",\"label\":\"stackoverflow\"},{\"url\":\"https://github.com/notifications\",\"label\":\"github\"},{\"url\":\"https://twitter.com/\",\"label\":\"twitter\"},{\"url\":\"https://www.reddit.com/\",\"label\":\"reddit\"},{\"url\":\"https://kitsu.io/\",\"label\":\"kitsu\"},{\"url\":\"https://myanimelist.net/\"},{\"url\":\"https://mangadex.org/\"},{\"url\":\"https://web.archive.org/\",\"label\":\"web.archive\"}]");
user_pref("browser.pagethumbnails.capturing_disabled", false);
user_pref("browser.tabs.unloadOnLowMemory", true);
user_pref("devtools.chrome.enabled", true);
user_pref("devtools.theme", "dark");
user_pref("extensions.pocket.enabled", false);

// Tor related configs
user_pref("network.proxy.socks_remote_dns", true);
user_pref("network.trr.mode", 0);
user_pref("network.dns.blockDotOnion", false);
