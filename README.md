[![status](https://travis-ci.org/premek/funlang.svg)](https://travis-ci.org/premek/funlang)

# funlang

## Install
```
$ luarocks install lpeg
```

## Test
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
print("result: ", result)
print("i after execution: ", runtime.get('i'))
```

```
$ lua examples/usage.lua
i before execution: 	nil
i after execution: 	4
result: 	101
```
