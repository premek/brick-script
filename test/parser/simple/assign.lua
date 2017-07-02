return {[[
score:0
score:
  9
game.speed : 19
a.b.c: 2
fun : {}
pos: [2,9]
bitmap:
###
#-#
###

bricks: [
###
###,
#
]

bricks: [
-#
##
#-
,
---
]


hiscore : game.score

]],
{
    {"assign", {"var", "score"}, {"get", {"num", "0"}}},
    {"assign", {"var", "score"}, {"get", {"num", "9"}}},
    {"assign", {"var", {"call", "game", {}}, "speed"}, {"get", {"num", "19"}}},
    {
        "assign",
        {"var", {"call", "a", {}}, {"call", "b", {}}, "c"},
        {"get", {"num", "2"}}
    },
    {"assign", {"var", "fun"}, {"get", {"block"}}},
    {
        "assign",
        {"var", "pos"},
        {"get", {"list", {{"get", {"num", "2"}}, {"get", {"num", "9"}}}}}
    },
    {
        "assign",
        {"var", "bitmap"},
        {"get", {"bitmap", {{1, 1, 1}, {1, 0, 1}, {1, 1, 1}}}}
    },
    {
        "assign",
        {"var", "bricks"},
        {
            "get",
            {
                "list",
                {{"get", {"bitmap", {{1, 1, 1}, {1, 1, 1}}}}, {"get", {"bitmap", {{1}}}}}
            }
        }
    },
    {
        "assign",
        {"var", "bricks"},
        {
            "get",
            {
                "list",
                {
                    {"get", {"bitmap", {{0, 1}, {1, 1}, {1, 0}}}},
                    {"get", {"bitmap", {{0, 0, 0}}}}
                }
            }
        }
    },
    {
        "assign",
        {"var", "hiscore"},
        {"get", {"call", "game", {}}, {"call", "score", {}}}
    }
}


}
