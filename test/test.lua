local luaunit = require('test.luaunit')
local parser = require('funlang.parser')

--- parser ---
function testTetris() doTest('simple-tetris') end


-- TODO test runtime, test public API

function doTest(name)
  local test = require ('test.parser.'..name)
  local parsed = parser:match(test[1])
  luaunit.assertEquals(parsed, test[2])
end

os.exit( luaunit.LuaUnit.run() )
