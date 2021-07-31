local opt = mp.options.read_options
local o = {repl = true, quack = true}

opt(o)

if o.repl then require("repl") end
if o.quack then require("quack") end
