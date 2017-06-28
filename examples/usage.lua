local parser = require('funlang.parser')
local Runtime = require('funlang.runtime')

local runtime = Runtime()
runtime.assign('a', 3)
runtime.assign('increase', function(i) return i+1 end)
print("i before execution: ", runtime.get('i'))
local script = [[
  i: increase(a)
  value: 100
  increase(value)
]]
local result = runtime.run(parser:match(script))
print("i after execution: ", runtime.get('i'))
print("result: ", result)
