local opt = require 'mp.options'
local user_opts = {
    showwindowed = true, -- show OSC when windowed?
    showfullscreen = true, -- show OSC when fullscreen?
    scalewindowed = 1, -- scaling of the controller when windowed
    scalefullscreen = 1, -- scaling of the controller when fullscreen
    scaleforcedwindow = 2, -- scaling when rendered on a forced window
    vidscale = true, -- scale the controller with the video?
    hidetimeout = 1000, -- duration in ms until the OSC hides if no
    -- mouse movement. enforced non-negative for the
    -- user, but internally negative is 'always-on'.
    fadeduration = 250, -- duration of fade out in ms, 0 = no fade
    minmousemove = 2, -- minimum amount of pixels the mouse has to
    -- move between ticks to make the OSC show up
    iamaprogrammer = false, -- use native mpv values and disable OSC
    -- internal track list management (and some
    -- functions that depend on it)
    font = 'mpv-osd-symbols', -- default osc font
    seekbarhandlesize = 1.0, -- size ratio of the slider handle, range 0 ~ 1
    seekrange = true, -- show seekrange overlay
    seekrangealpha = 64, -- transparency of seekranges
    seekbarkeyframes = true, -- use keyframes when dragging the seekbar
    title = '${media-title}', -- string compatible with property-expansion
    -- to be shown as OSC title
    showtitle = true, -- show title and no hide timeout on pause
    timetotal = true, -- display total time instead of remaining time?
    visibility = 'auto', -- only used at init to set visibility_mode(...)
    windowcontrols = 'auto', -- whether to show window controls
    language = 'en' -- en=English, cn=Chinese
}

opt.read_options(user_opts, 'osc')
return user_opts
