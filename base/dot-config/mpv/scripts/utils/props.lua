local msg = require "mp.msg"
local csv = require "lib.csv"

local oo = {db = nil}

local pathsep = package.config:sub(1, 1)
local listsep = not pathsep == '/' and ';' or ':'

local function async_cb(...) return nil end

local function match_prop(name, match)
    local val = mp.get_property(name)
    if val == nil then return false end
    if string.match(val, match) == nil then return false end
    return true
end

local function get_rules()
    if oo.db == nil then
        local regexdb = table.concat({
            mp.find_config_file("script-opts"), 'props.tsv'
        }, pathsep)
        oo.db = csv.open(regexdb, {
            separator = "\t",
            columns = {
                prop = {name = "PROP", transform = string.lower},
                val = {name = "VALUE"},
                match = {name = "MATCH", transform = string.lower},
                regex = {name = "REGEX"}
            }
        })
    end
    return oo.db:lines()
end

local function set_props(event)
    for rule in get_rules() do
        if not (rule.prop == nil or rule.val == nil or rule.match == nil or
            rule.regex == nil) then
            if match_prop(rule.match, rule.regex) then
                local ret, err = mp.set_property(rule.prop, rule.val)
                if ret then
                    msg.info("set " .. rule.prop .. " = " .. rule.val)
                    mp.osd_message("[" .. mp.get_script_name() .. "] " ..
                                       rule.prop .. " => " .. rule.val)
                else
                    msg.error("set " .. rule.prop .. " = " .. rule.val)
                    msg.error(err)
                end
            end
        end
    end
end

mp.register_event("file-loaded", set_props)
