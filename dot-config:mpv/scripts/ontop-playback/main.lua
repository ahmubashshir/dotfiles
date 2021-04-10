-- makes mpv disable ontop when pausing and re-enable it again when resuming playback
if mp.get_property_native("ontop") then
    mp.observe_property("pause", "bool", function(name, value)

        mp.set_property_native("ontop", mp.get_property_native("fullscreen") or
                                   not value)
    end)
end
