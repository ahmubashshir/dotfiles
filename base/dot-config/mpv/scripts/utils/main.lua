local opt = require("mp.options").read_options
local msg = require "mp.msg"

local o = {repl = true, quack = false, props = true}
opt(o)

for _mod, _load in pairs(o) do
    if _load then
        msg.info("Loading util." .. _mod)
        require(_mod)
    end
end
