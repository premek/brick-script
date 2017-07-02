return {[[
score:0
score:
  9
//game.speed : 19
fun : {}
pos: [2,9]
bitmap:
###
#-#
###

//hiscore : game.score

]],
{
    {"assign", {"name", "score"}, {"num", "0"}},
    {"assign", {"name", "score"}, {"num", "9"}},
  --  {"assign", {"name", "game", "speed"}, {"num", "19"}},
    {"assign", {"name", "fun"}, {"block"}},
    {"assign", {"name", "pos"}, {"list", {{"num", "2"}, {"num", "9"}}}},
    {"assign", {"name", "bitmap"}, {"bitmap", {{1, 1, 1}, {1, 0, 1}, {1, 1, 1}}}},
  --  {"assign", {"name", "hiscore"}, {"call", {"name", "game", "score"}, {}}}

}

}
