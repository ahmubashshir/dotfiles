-- Runs write-watch-later-config periodically
local utils = require 'mp.utils'
local options = require 'mp.options'
local msg = require 'mp.msg'

local o = {save_interval = 60}
options.read_options(o)

local function async_cb(...) return true end

local function save(...)
    remaining = mp.get_property_native("playtime-remaining")
    if remaining and remaining > 10 then
        mp.command_native_async({"write-watch-later-config"}, async_cb)
    end
end

local function save_if_pause(_, pause) if pause then save() end end

local function pause_timer_while_paused(_, pause)
    if pause then timer:stop() end

    if not pause and not timer:is_enabled() then timer:resume() end
end

-- This function:
-- 1. Locates the watch_later entry for the current file
-- 2. Registers a callback function for the end-file event
-- And then the callback function:
-- 1. Unregisters itself, so it doesn't run again
-- 2. Deletes the current watch_later entry IF mpv exited as a
--    result of EOF or "stop" (stop is not the same as a normal "quit")
--
-- This function is called on file-loaded instead of end-file because
-- the next file in the playlist would likely be loaded by the time the
-- end-file event runs.
local function delete(_, remaining)
    if remaining and remaining < 10 then
        mp.command_native_async({"delete-watch-later-config"}, async_cb)
    end
end

timer = mp.add_periodic_timer(o.save_interval, save)
mp.observe_property("pause", "bool", pause_timer_while_paused)
mp.observe_property("pause", "bool", save_if_pause)

mp.observe_property("playtime-remaining", "native", delete)
mp.register_event("file-loaded", save)
