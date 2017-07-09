local add = function(a, b) return a+b end
local rept = function(n, fn) print('repeat n times: ', n, fn); local last;for i=1, n do last=fn(i) end return last end
local prnt = function(...) print("---PRINT from script", unpack(arg)) end

local conf = function(runtime)
  runtime.assign('add', add)
  runtime.assign('repeat', rept)
  runtime.assign('print', prnt)
end

return {

{
configure=conf,
[[
  one:1
  four: add(one, 3)
  four
]]
,
4
},


{
configure=conf,
[[
  vector: [2,3]
  vector.x
]]
,
2
},


{
configure=conf,
[[
  count : {l -> l.size}
  count([2,3,3])
]]
,
3
},



{
configure=conf,
[[
  count : {l ->
    nothing
    l.size
  }
  count([2,3,3])
]]
,
3
},


{
configure=conf,
[[
  2.plus(3)
]]
,
5
},


{
configure=conf,
[[
  2.plus(3).plus(1)
]]
,
6
},


{
configure=conf,
[[
  a:1
  a.plus(3)
]]
,
4
},

{
configure=conf,
[[
  a:1
  2.plus(a)
]]
,
3
},

{
configure=conf,

[[
  a:0
  repeat(3, {i ->
    a << i
  })
  a
]]
,
3
},

{
configure=conf,

[[
  a:1
  repeat(2, {i ->
    a:5
    a << i
  })
]]
,
2
},


{
configure=conf,

[[
  a:1
  repeat(2, {i ->
    a:5
    a << i
  })
  a
]]
,
1
},


{
configure=conf,

[[
  a:0
  repeat(3, {i ->
    a << a.plus(i)
  })
  a
]]
,
6
},

{
configure=conf,

[[
m:[]
fun: { machine ->
  machine.gameover << 1
}
fun(m)
m.gameover
]]
,
1
},


{
configure=conf,

[[
  a:0
  repeat(3, {i ->
    a << a.plus(i)
  })
  a
]]
,
6
},


{
configure=conf,

[[
  add: {a,b -> a.plus(b)}
  add(3, 2)
]]
,
5
},

{
configure=conf,
[[
  plusTwo: {n -> n.plus(2)}
  plusFour: {n -> plusTwo(n.plus(2)) }
  plusFour(6)
]]
,
10
},

{
configure=conf,
[[
  val : 1
  set10: {val << 10}
  set10
  val
]]
,
10
},

{
configure=conf,
[[
  val : 1
  set: {n -> val << n}
  set(4)
  val
]]
,
4
},

{
configure=conf,
[[
  nop0: {}
  nop1: {i -> }
  nop2: {i,j -> }
  nop0
  nop0()
  nop0(1)
  nop1()
  nop1(1)
  nop1(1,2)
  nop2()
  nop2(1)
  nop2(1,2)
  nop2(1,2,3)
]]
,
nil
},



}
