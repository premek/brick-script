local luaunit = require('test.luaunit')
local parser = require('funlang.parser')
local Runtime = require('funlang.runtime')

function testAssign() doTest('assign') end
function testBind() doTest('bind') end
function testCall() doTest('call') end


function doTest(name)
  local tests = require ('test.runtime.'..name)
  print('\n\n\nRT Test:', name)
  for i, test in pairs(tests) do
    print('\nSubtest: ', i)
    local runtime = Runtime()
    if test.configure then test.configure(runtime) end
    local code = test[1]
    print('code:\n'..code)
    local tree = parser:match(code)
    print('parsed: ', luaunit.prettystr(tree))
    local result = runtime.run(tree)
    print('result: ', result)
    luaunit.assertEquals(result, test[2])
  end
end

os.exit( luaunit.LuaUnit.run() )
