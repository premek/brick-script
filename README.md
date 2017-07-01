# Brick Script

A scripting language for writing [Brick Game Machine](https://github.com/premek/brick) games

[![status](https://travis-ci.org/premek/funlang.svg)](https://travis-ci.org/premek/funlang)

## Install dependencies
```
$ luarocks install lpeg
```

## Run tests
```
$ ./runtests.sh
```
or
```
$ lua test/parser-simple.lua
$ lua test/parser-complex.lua
$ lua test/runtime.lua
```

## Language (WIP)
```
bricks: [
##
##,
####,
-#
##
#-
]
brickPos: [3,0]
brick: bricks(1)
```

## Integration

```lua
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
```

```
$ lua examples/usage.lua
i before execution: 	nil
i after execution: 	4
result: 	101
```
