local utils = require "mp.utils"
local msg = require "mp.msg"
local options = require "mp.options"
local shaders = require "shaders"

local shader_path = mp.find_config_file("shaders")

local pathsep = package.config:sub(1, 1)
local listsep = not pathsep == '/' and ';' or ':'
-- no-osd change-list glsl-shaders set

local function load_shaders(...)
    local list = {}

    for _, shader in ipairs(...) do
        if shader == nil then goto continue end
        table.insert(list, table.concat({
            shader_path, 'anime4k', "Anime4K_" .. shader .. ".glsl"
        }, pathsep))
        msg.info('Loaded Shaders: ' .. shader)
        ::continue::
    end
    mp.commandv("change-list", "glsl-shaders", "set",
                table.concat(list, listsep))
end

local function load_shader()
    height = mp.get_property_native("height")
    msg.info("Res: " .. height .. "p")
    if height > 720 then
        load_shaders(shaders["hd_faithful"])
    elseif height <= 720 and height >= 480 then
        load_shaders(shaders["default_faithful"])
    else
        load_shaders(shaders["none"])
    end
end

mp.register_event("file-loaded", load_shader)

