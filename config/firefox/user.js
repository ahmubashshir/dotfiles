user_pref( "toolkit.legacyUserProfileCustomizations.stylesheets", true );
user_pref( "browser.urlbar.update1", false );
user_pref( "ui.systemUsesDarkTheme", 1 );

user_pref( "general.smoothScroll.msdPhysics.enabled", true );
user_pref( "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 250 );
user_pref( "general.smoothScroll.msdPhysics.motionBeginSpringConstant", 400 );
user_pref( "general.smoothScroll.msdPhysics.regularSpringConstant", 400 );
user_pref( "general.smoothScroll.msdPhysics.slowdownMinDeltaMS", 120 );
user_pref( "general.smoothScroll.msdPhysics.slowdownSpringConstant", 5000 );
user_pref( "mousewheel.min_line_scroll_amount", 22 );
user_pref( "toolkit.scrollbox.horizontalScrollDistance", 4 );
user_pref( "toolkit.scrollbox.verticalScrollDistance", 5 );
user_pref( "apz.frame_delay.enabled", false );

//Full screen fade faster:
user_pref( "full-screen-api.transition-duration.enter", 50 );
user_pref( "full-screen-api.transition-duration.leave", 50 );

//always show firefox logo in default newtab page:
user_pref( "browser.newtabpage.activity-stream.logowordmark.alwaysVisible", true );
user_pref( "layers.acceleration.force-enabled", true );
user_pref( "gfx.webrender.all", true );
//user_pref("gfx.webrender.enabled", true);
user_pref( "layout.css.backdrop-filter.enabled", true );
user_pref( "svg.context-properties.content.enabled", true );

user_pref( "browser.tabs.allowTabDetach", false );
user_pref( "network.captive-portal-service.enabled", false );
user_pref( "browser.selfsupport.url", "" );
user_pref( "pocket.enabled", false );

// reduce session history stack
user_pref( "browser.sessionhistory.max_entries", 20 );
// reduce cached page stack
user_pref( "browser.sessionhistory.max_total_viewers", 5 );
// trim on minimize
user_pref( "config.trim_on_minimize", true );
// set in-memory cache to 200M
user_pref( "browser.cache.memory.capacity", 204800 );


/*
 * layers.acceleration.force-enabled
 * gfx.webrender.all
 * gfx.webrender.enabled
 * layout.css.backdrop-filter.enabled
 * svg.context-properties.content.enabled
 */
