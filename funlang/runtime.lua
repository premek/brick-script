return function()

local runNode, runTree

local vars = {}



local slice = function(tbl, first, last)
  local sliced = {}
  for i = first or 1, last or #tbl do
    sliced[#sliced+1] = tbl[i]
  end
  return sliced
end



local name = function(n)
  if n[1]=='name' then return n[2] end
  -- TODO nested names
end

local nodeRunners = {

  num = function(n)
    print('num', n[2])
    return tonumber(n[2])
  end,

  assign = function(n)
    local varName = name(n[2])
    print ('assign', varName)
    vars[varName] = runNode(n[3])
    print ('assign', varName, vars[varName])
  end,

  call = function(n)
    local varName = name(n[2])
    local arguments = {}
    for i,argument in ipairs(n[3]) do
      arguments[i] = runNode(argument)
    end


    local called = vars[varName]
    local calledType = type(called)
    print('call', varName, calledType, called)
    if calledType == 'number' then return called end
    if calledType == 'function' then
      return called(unpack(arguments))
    end --TODO params
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

return {
  run = function(tree)
    return runTree(tree, 1)
  end,
  assign = function(varName, value)
    vars[varName] = value
  end
}
end
