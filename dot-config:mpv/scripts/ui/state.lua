local user_opts = require('opts')

-- internal states, do not touch
return {
    showtime, -- time of last invocation (last mouse move)
    osc_visible = false,
    anistart, -- time when the animation started
    anitype, -- current type of animation
    animation, -- current animation alpha
    mouse_down_counter = 0, -- used for softrepeat
    active_element = nil, -- nil = none, 0 = background, 1+ = see elements[]
    active_event_source = nil, -- the 'button' that issued the current event
    rightTC_trem = not user_opts.timetotal, -- if the right timecode should display total or remaining time
    mp_screen_sizeX,
    mp_screen_sizeY, -- last screen-resolution, to detect resolution changes to issue reINITs
    initREQ = false, -- is a re-init request pending?
    last_mouseX,
    last_mouseY, -- last mouse position, to detect significant mouse movement
    mouse_in_window = false,
    message_text,
    message_hide_timer,
    fullscreen = false,
    tick_timer = nil,
    tick_last_time = 0, -- when the last tick() was run
    hide_timer = nil,
    cache_state = nil,
    idle = false,
    enabled = true,
    input_enabled = true,
    showhide_enabled = false,
    dmx_cache = 0,
    border = true,
    maximized = false,
    mute = false,
    volume = 0,
    osd = mp.create_osd_overlay('ass-events'),
    lastvisibility = user_opts.visibility -- save last visibility on pause if showtitle
}
