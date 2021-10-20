local utils = require "mp.utils"
local msg = require "mp.msg"
local options = require "mp.options"
local shaders = require "shaders"

local o = {
    enable = false,
    uhd = false,
    hd = false,
    quality = 'fast', -- Quality: If upscaling to resolutions smaller than 4K, lower end GPUs can be used.
    --    fast:  GTX 980, GTX 1060, RX 570...
    --      hq: GTX 1080, RTX 2070, RTX 3060, RX 590, Vega 56, 5700XT, 6600XT...

    mode = 'a' -- Mode:
    --  A: Restore -> Upscale -> Upscale
    --  B: Restore_Soft -> Upscale -> Upscale
    --  C: Upscale_Denoise -> Upscale
    -- AA: Restore -> Upscale -> Restore -> Upscale
    -- BB: Restore_Soft -> Upscale -> Restore_Soft -> Upscale
    -- CA: Upscale_Denoise -> Restore -> Upscale
}
local valid_modes = {'a', 'b', 'c', 'aa', 'bb', 'ca'}
options.read_options(o, 'anime4k')

local shader_path = mp.find_config_file("shaders")

local pathsep = package.config:sub(1, 1)
local listsep = not pathsep == '/' and ';' or ':'

-- no-osd change-list glsl-shaders set
local function async_cb(...) msg.info(...) end
local function validate_mode(val)
    for index, value in ipairs(valid_modes) do
        if value == val then return true end
    end
    return false
end

local function append_list(list, src)
    for _, shader in ipairs(src) do
        if shader then
            table.insert(list, table.concat(
                             {
                    shader_path, 'Anime4K', 'glsl', shaders.resolve(shader)
                }, pathsep))
            msg.info('Loaded Shaders: ' .. shaders.resolve(shader))
        end
        ::continue::
    end
end

local function load_shaders(mode)
    local list = {}
    msg.info("Mode: " .. o.mode)
    mp.osd_message("[" .. mp.get_script_name() .. "] Mode: " .. o.mode)
    append_list(list, shaders["common"])
    append_list(list, shaders[o.quality][o.mode])
    mp.command_native_async({
        "change-list", "glsl-shaders", "set", table.concat(list, listsep)
    }, async_cb)
end

local function unload_shaders()
    msg.info("Mode: none")
    mp.osd_message("[" .. mp.get_script_name() .. "] Mode: none")
    mp.command_native_async({"change-list", "glsl-shaders", "set", ""}, async_cb)
    -- pass
end

local function load_shader()
    local height = mp.get_property_native("height")
    local width = mp.get_property_native("width")
    if not height then return false end
    if not width then return false end
    msg.info("Res: " .. height .. "p")
    if (height > 1080 or width > 1920) and o.uhd or
        (height <= 1080 and height >= 720 or width <= 1920 and width >= 1280) and
        o.hd or height < 720 and width < 1280 then
        load_shaders(o.mode)
    else
        unload_shaders()
    end
    return true
end

local function set_mode(mode)
    unload_shaders()
    if validate_mode(mode) then
        o.mode = mode
        load_shader()
    end
end

if not validate_mode(o.mode) then
    msg.warn('Invalid mode: ' .. o.mode)
    o.mode = 'c'
    msg.info('Fallback mode: ' .. o.mode)
end

if o.enable then mp.register_event("file-loaded", load_shader) end

mp.add_key_binding("CTRL+0", "anime4k-clear", unload_shaders)
mp.add_key_binding("CTRL+1", "anime4k-load-a", function() set_mode('a') end)
mp.add_key_binding("CTRL+2", "anime4k-load-b", function() set_mode('b') end)
mp.add_key_binding("CTRL+3", "anime4k-load-c", function() set_mode('c') end)
mp.add_key_binding("CTRL+4", "anime4k-load-aa", function() set_mode('aa') end)
mp.add_key_binding("CTRL+5", "anime4k-load-bb", function() set_mode('bb') end)
mp.add_key_binding("CTRL+6", "anime4k-load-ca", function() set_mode('ca') end)
