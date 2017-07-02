return function()

local runNode, runTree

local global = {}

local call = function(n, callOn)
  local varName = n[2]
  local arguments = {}
  for i,argument in ipairs(n[3]) do
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
end



local var = function(n)
  local callOn = global
  local varName = n[#n]
  if n[1]=='var' then
    for i=2, #n-1 do
      if(n[i][1]=='call') then
        callOn = call(n[i], callOn)
      else
        callOn = runNode(n[i])
      end
    end
    return callOn, varName
  end
end

local nodeRunners
nodeRunners = {

  assign = function(n)
    local callOn, varName = var(n[2])
    print ('assign', varName)
    callOn[varName] = runNode(n[3])
    print ('assign', varName, callOn[varName])
  end,

  update = function(n) nodeRunners.assign(n) end,

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
    res['size'] = function() return #res end
    if #res==2 then
      res['x'] = function() return res[1] end
      res['y'] = function() return res[2] end
    end
    print('list', '#: ', #res)
    return res
  end,

  bitmap = function(n)
    local res = n[2]
    res['h']=#res
    res['w']=0
    for i=1, #res do if #res[i]>res['w'] then res['w']=#res[i] end end
    return res
  end,

  get = function(n)
    local lastVal = global
    for i=2, #n do -- FIXME clean, duplicated code
      if(n[i][1]=='call') then
        lastVal = call(n[i], lastVal)
      else
        lastVal = runNode(n[i])
      end
    end
    return lastVal
  end,

  block = function(n) -- TODO function with params
    return function()
      local lastVal = nil
      for i=2, #n do
        lastVal = runNode(n[i])
      end
      return lastVal
    end
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
    global[varName] = value
  end,

  get = function(varName)
    return global[varName]
  end,
}
end
