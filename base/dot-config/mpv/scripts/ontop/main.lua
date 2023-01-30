-- makes mpv disable ontop when pausing and re-enable it again when resuming playback
local options = require "mp.options"
local o = {enable = false}

options.read_options(o, 'ontop')

mp.observe_property("pause", "bool", function(name, value)
    mp.set_property_native("ontop", mp.get_property_native("fullscreen") or
                               (not value and o.enable))
end)
