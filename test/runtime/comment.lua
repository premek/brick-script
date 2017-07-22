local output = ''

return {

{configure=function(runtime)
  runtime.assign('task', {
    todo = function(msg) output = output .. "TODO"..msg end,
    fixme = function(msg) output = output .. "FIXME".. msg end,
    xxx = function(msg) output = output .. "XXX".. msg end,
  })
  runtime.assign('getOut', function() return output end)
end,

[[
1
// oneline
// another line
1 /* block */ 1/* multiple
lines
*/1
TODO get life
2 FIXME should be 3
3 XXX do not commit
3.times{
  TODO
}
getOut()
]]
, "TODOget lifeFIXMEshould be 3XXXdo not commitTODOTODOTODO" }, -- but we do not have strings in brickscript :(



}
