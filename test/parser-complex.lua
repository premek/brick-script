local luaunit = require('test.luaunit')
local parser = require('brickscript.parser')


function testTetris() doTest('tetris') end
function testCars() doTest('cars') end


function doTest(name)
  local test = require ('test.parser.complex.'..name)
  local parsed = parser:match(test[1])
  luaunit.assertEquals(parsed, test[2])
end

os.exit( luaunit.LuaUnit.run() )
