local utils = require "mp.utils"
local msg = require "mp.msg"
local options = require "mp.options"
local shaders = require "shaders"
local o = {
    enable = false,
    mode = 'faithful',
    uhd = false,
    force = false
    -- Modes:
    -- faithful: Upscale video while being faithful to the original video
    -- deblur: Improve perceptual quality and deblur
    -- perceptual: Improve perceptual quality.
}

options.read_options(o, 'anime4k')

local shader_path = mp.find_config_file("shaders")

local pathsep = package.config:sub(1, 1)
local listsep = not pathsep == '/' and ';' or ':'
-- no-osd change-list glsl-shaders set

local function load_shaders(...)
    local list = {}
    msg.info("Mode: " .. o.mode)
    for _, shader in ipairs(...) do
        if shader == nil then goto continue end
        table.insert(list, table.concat({
            shader_path, 'anime4k', "Anime4K_" .. shader .. ".glsl"
        }, pathsep))
        msg.info('Loaded Shaders: ' .. shader)
        ::continue::
    end
    mp.command_native {
        "change-list", "glsl-shaders", "set", table.concat(list, listsep)
    }
end

local function load_shader()
    height = mp.get_property_native("height")
    msg.info("Res: " .. height .. "p")
    if height > 720 and o.uhd then
        load_shaders(shaders["hd_" .. o.mode])
    elseif height <= 720 and (height >= 480 or o.force) then
        load_shaders(shaders["default_" .. o.mode])
    else
        load_shaders(shaders["none"])
    end
end
if (function(tab, val)

    for index, value in ipairs(tab) do if value == val then return false end end
    return true
end)({'faithful', 'perceptual', 'deblur'}, o.mode) then

    msg.warn('Invalid mode: ' .. o.mode)
    o.mode = 'faithful'
    msg.info('Fallback mode: ' .. o.mode)
end

if o.enable then mp.register_event("file-loaded", load_shader) end
