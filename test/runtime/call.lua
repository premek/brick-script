return {

{
configure=function(runtime)
  runtime.assign('add', function(a, b) return a+b end)
end,
[[
  one:1
  four: add(one, 3)
  four
]]
,
4
},





}
