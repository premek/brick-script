return {

{
[[
  l:[1,2,3]
  l(1)
]]
,
 2
},


{
[[
  list:[1,2,3]
  list(4)
]]
,
 nil -- TODO?
},


{
[[
  [].size
]]
,
 0
},


{
[[
  list: [1,2,[11,22,33, [44], 55], ]
  nested: list(2)
  nn: nested(3) //TODO nested(3)(0)
  nn(0)
]]
,
 44
},


{
[[
  list: [1,2]
  list.x
]]
,
 1
},

{
[[
  list: [1,2,8]
  list.size
]]
,
 3
},


{
[[
  a: 3
  b: 5
  list: [1,a, b]
  list(2)
]]
,
 5
},


{
[[
  tail: [2, [] ]
  list: [1, tail]
  t: list(1)
  t(1).isEmpty
]]
,
 true
},


{
configure = function (runtime) math.randomseed(7) end,
[[
  list: [1, 2, 3]
  [list.random, list.random, list.random, list.random, list.random]
]]
,
{2, 3, 2, 1, 1}
},

}
