local luaunit = require('test.luaunit')
local parser = require('funlang.parser')

function testCall() doTest('call') end
function testAssign() doTest('assign') end


function doTest(name)
  local test = require ('test.parser.simple.'..name)
  local parsed = parser:match(test[1])
  luaunit.assertEquals(parsed, test[2])
end

os.exit( luaunit.LuaUnit.run() )
