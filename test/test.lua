local luaunit = require('test.luaunit')
local parser = require('funlang.parser')
local runtime = require('funlang.runtime')

--- parser ---
function test1() doTest('test1') end
function testTetris() doTest('simple-tetris') end
function testCars() doTest('simple-cars') end

--- runtime ---
function testRT1() doRTTest('assign') end



---
function doRTTest(name)
  local tests = require ('test.runtime.'..name)
  print('\nRT Test:', name)
  for subtest,test in pairs(tests) do
    print('\nSubtest: ', subtest)
    local tree = parser:match(test[1])
    print(luaunit.prettystr(tree))
    local result = runtime.run(tree)
    luaunit.assertEquals(result, test[2])
  end
end

function doTest(name)
  local test = require ('test.parser.'..name)
  local parsed = parser:match(test[1])
  luaunit.assertEquals(parsed, test[2])
end

os.exit( luaunit.LuaUnit.run() )
