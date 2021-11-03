local utils = require "mp.utils"
local msg = require "mp.msg"
local options = require "mp.options"
local shaders = require "shaders"
local csv = require "csv"

local o = {
    enable = true,
    autoload = false,
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
local valid_modes = {'a', 'b', 'c', 'aa', 'bb', 'ca', 'none'}
options.read_options(o, 'anime4k')

local shader_path = mp.find_config_file("shaders")

local pathsep = package.config:sub(1, 1)
local listsep = not pathsep == '/' and ';' or ':'

-- no-osd change-list glsl-shaders set
local function async_cb(...) return nil end
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
    end
end

local function load_shaders(mode)
    if not validate_mode(mode) then return nil end
    msg.info("Mode: " .. mode)
    mp.osd_message("[" .. mp.get_script_name() .. "] Mode: " .. mode)
    mp.command_native_async({"change-list", "glsl-shaders", "set", ""}, async_cb)

    if not (mode == 'none') then
        local list = {}
        append_list(list, shaders["common"])
        append_list(list, shaders[o.quality][mode])
        mp.command_native_async({
            "change-list", "glsl-shaders", "set", table.concat(list, listsep)
        }, async_cb)
    end
end

local function match_prop(name, match)
    local val = mp.get_property(name)
    if val == nil then return false end
    if string.match(val, match) == nil then return false end
    return true
end

local function get_mode_from_props()
    local regexdb = table.concat({shader_path, 'anime4k.csv'}, pathsep)
    local f = csv.open(regexdb, {
        separator = "\t",
        columns = {
            mode = {name = "MODE", transform = string.lower},
            prop = {name = "PROP", transform = string.lower},
            regex = {name = "REGEX"}
        }
    })
    if f == nil then return nil end

    for rule in f:lines() do
        if not (rule.mode == nil or rule.prop == nil or rule.regex == nil) then
            if match_prop(rule.prop, rule.regex) then
                if validate_mode(rule.mode) then return rule.mode end
            end
        end
    end
    return nil
end

local function load_shader()
    local height = mp.get_property_native("height")
    local width = mp.get_property_native("width")
    if not height then return false end
    if not width then return false end
    local mode = get_mode_from_props()

    msg.info("Res: " .. height .. "p")
    if o.autoload and ((height > 1080 or width > 1920) and o.uhd or
        (height <= 1080 and height >= 720 or width <= 1920 and width >= 1280) and
        o.hd or height < 720 and width < 1280) or not (mode == nil) then
        load_shaders(mode == nil and o.mode or mode)
    else
        load_shaders('none')
    end
    return true
end

if not validate_mode(o.mode) then
    msg.warn('Invalid mode: ' .. o.mode)
    o.mode = 'c'
    msg.info('Fallback mode: ' .. o.mode)
end

if o.enable then mp.register_event("file-loaded", load_shader) end

mp.add_key_binding("CTRL+0", "anime4k-clear",
                   function() load_shaders('none') end)
mp.add_key_binding("CTRL+1", "anime4k-load-a", function() load_shaders('a') end)
mp.add_key_binding("CTRL+2", "anime4k-load-b", function() load_shaders('b') end)
mp.add_key_binding("CTRL+3", "anime4k-load-c", function() load_shaders('c') end)
mp.add_key_binding("CTRL+4", "anime4k-load-aa",
                   function() load_shaders('aa') end)
mp.add_key_binding("CTRL+5", "anime4k-load-bb",
                   function() load_shaders('bb') end)
mp.add_key_binding("CTRL+6", "anime4k-load-ca",
                   function() load_shaders('ca') end)
