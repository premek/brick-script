return function()

local runNode, runTree

local global = {}

local call = function(n, callOn, scope)
  local varName = n[2]
  local arguments = {}
  for i,argument in ipairs(n[3]) do
    arguments[i] = runNode(argument, scope)
  end
  local called
  -- TODO clean up
  if type(callOn) == 'number' and varName =='plus' then called = function (num) print ("PLUS");return num+callOn end
else
  print('call', varName, 'on', scope)
  called = callOn[varName]
  print('call res', called)
  while(not called and callOn['_parent']) do
    callOn = callOn['_parent']
    called = callOn[varName]
    print('called on parent', callOn, called)
  end
end
  local calledType = type(called)
  print('call', varName, #arguments, calledType, called, 'on', callOn)
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



local var = function(n, scope, tryParents)
  print('var')
  local callOn = scope
  local varName = n[#n]
  for i=2, #n-1 do
    if(n[i][1]=='call') then
      callOn = call(n[i], callOn, scope)
    else
      callOn = runNode(n[i], callOn)
    end
  end
  while tryParents and not callOn[varName] and callOn['_parent'] do
    callOn = callOn['_parent']
    print('parent', callOn)
  end
  return callOn, varName
end

local nodeRunners
nodeRunners = {

  assign = function(n, scope)
    local callOn, varName = var(n[2], scope, false)
    print ('assign', varName)
    callOn[varName] = runNode(n[3], scope)
    print ('assign', varName, callOn[varName])
    return callOn[varName]
  end,

  update = function(n, scope)
    local callOn, varName = var(n[2], scope, true)
    print ('update', varName, callOn)
    callOn[varName] = runNode(n[3], scope)
    print ('update', varName, callOn[varName])
    return callOn[varName]
  end,

  num = function(n, scope)
    print('num', n[2])
    return tonumber(n[2])
  end,

  list = function(n, scope)
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
    print('list', '#: ', #res, res)
    return res
  end,

  bitmap = function(n, scope)
    local res = n[2]
    res['h']=#res
    res['w']=0
    for i=1, #res do if #res[i]>res['w'] then res['w']=#res[i] end end
    return res
  end,

  block = function(n, scope)
    local localScope = {_parent = scope} -- TODO parent scope / prototype
    local paramNamesByOrder = n[2]
    local blockBody = n[3]
    return function(...)
      print('run block', #arg, 'scope', localScope, 'params', arg[1], arg[2])
      for paramOrder, paramValue in ipairs(arg) do
        localScope[paramNamesByOrder[paramOrder]] = paramValue
      end
     return runTree(blockBody, 1, localScope)
    end
  end,

  get = function(n, scope)
    print('get')
    local callOn = scope
    local lastVal
    for i=2, #n do -- FIXME clean, duplicated code
      if(n[i][1]=='call') then
        lastVal = call(n[i], callOn, scope)
      else
        lastVal = runNode(n[i], callOn)
      end
      print('call res', lastVal)
      callOn = lastVal
    end
    print('get got', lastVal)
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

runNode = function(n, scope)
  local type = n[1]
  print('node', type, 'scope', scope)

  return nodeRunners[type](n, scope)
end

runTree = function(tree, from, scope)
  print('runTree', 'scope', scope)
  local n = tree[from]
  local firstResult = runNode(n, scope)
  if #tree == from then return firstResult
  else
    print('-----')
    return runTree(tree, from+1, scope)
  end
end


-- public API

return {
  -- FIXME API to run string script directly without the need to call parser from client code
  run = function(tree)
    return runTree(tree, 1, global)
  end,

  assign = function(varName, value)
    global[varName] = value
  end,

  get = function(varName)
    return global[varName]
  end,
}
end
