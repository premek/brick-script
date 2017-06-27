return {

{
configure=function(runtime)
  runtime.assign('amount', 999)
end,
[[
  amount
]]
,
999
},

{
configure=function(runtime)
  runtime.assign('amount', 10)
end,
[[
  fromOutside: amount
  fromOutside
]]
,
10
},

{
configure=function(runtime)
  runtime.assign('getTheBestNumber', function() return 25 end)
end,
[[
  getTheBestNumber
]]
,
25
},

{
configure=function(runtime)
  runtime.assign('getTheBestNumber', function() return 25 end)
end,
[[
  getTheBestNumber()
]]
,
25
},

{
configure=function(runtime)
  runtime.assign('getTheBestNumber', function() return 25 end)
end,
[[
  getTheBestNumber: 17
  getTheBestNumber()
]]
,
17
},


}
