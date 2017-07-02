return function()

local runNode, runTree

local vars = {}



local name = function(n)
  if n[1]=='name' then return n[2] end
  -- TODO nested names
end

local nodeRunners = {

  assign = function(n)
    local varName = name(n[2])
    print ('assign', varName)
    vars[varName] = runNode(n[3])
    print ('assign', varName, vars[varName])
  end,

  num = function(n)
    print('num', n[2])
    return tonumber(n[2])
  end,

  list = function(n)
    local res = {}
    for i,argument in ipairs(n[2]) do
      res[i] = runNode(argument)
    end
    -- TODO list metatable???
    if #res==2 then
      res['x'] = function() return res[1] end
      res['y'] = function() return res[2] end
    end
    print('list', '#: ', #res)
    return res
  end,

  call = function(n)
    -- TODO call on something. metatables?
    local callOn;
    if #n[2]==0 then callOn = vars
    elseif n[2][1] == 'name' then callOn = vars[n[2][2]]
    else callOn = n[2]
    end

    local varName = n[3]
    local arguments = {}
    for i,argument in ipairs(n[4]) do
      arguments[i] = runNode(argument)
    end
    local called = callOn[varName]
    local calledType = type(called)
    print('call', varName, calledType, called)
    if calledType == 'function' then
        -- fn call
        return called(unpack(arguments)) end
    if calledType == 'table' and #arguments == 1 and type(arguments[1]=='number') then
        -- list access
        -- TODO 0 or 1 based indexing
        -- TODO out of bounds
        return called[arguments[1]+1] end
    return called -- get variable value
  end,
}

runNode = function(n)
  local type = n[1]
  print('node', type)
  return nodeRunners[type](n)
end

runTree = function(tree, from)
  local n = tree[from]
  local firstResult = runNode(n)
  if #tree == from then return firstResult
  else return runTree(tree, from+1)
  end
end


-- public API

return {
  -- FIXME API to run string script directly without the need to call parser from client code
  run = function(tree)
    return runTree(tree, 1)
  end,

  assign = function(varName, value)
    vars[varName] = value
  end,

  get = function(varName)
    return vars[varName]
  end,
}
end
