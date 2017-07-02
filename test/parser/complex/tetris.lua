return {[[

bricks: [
##
##,
####
,
-#
##
#-
]

brickPos: [3,0]
brick: bricks(1)
lastBrickMoved: -

{
  displayNext.clear
  displayNext.draw(next, [0,0])
  displayMain.draw(brick, brickPos, -)

  brickPos << brickPos.v

  // input
  <{brickPos << brickPos.<}
  >{brickPos << brickPos.>}
  v{}
  o{brick << brick.rotate}

  col: collision(displayMain, brick, brickPos)
  col.onTrue{ tr }
  col.onFalse{fa}
  displayMain.draw(brick, brickPos, #)
  gameover
  newBrick
  lastBrickMoved << -

  // TODO fun().moreFun()
}

]],
{
    {
        "assign",
        {"name", "bricks"},
        {
            "list",
            {
                {"bitmap", {{1, 1}, {1, 1}}},
                {"bitmap", {{1, 1, 1, 1}}},
                {"bitmap", {{0, 1}, {1, 1}, {1, 0}}}
            }
        }
    },
    {"assign", {"name", "brickPos"}, {"list", {{"num", "3"}, {"num", "0"}}}},
    {"assign", {"name", "brick"}, {"call", {}, "bricks", {{"num", "1"}}}},
    {"assign", {"name", "lastBrickMoved"}, {"bitmap", {{0}}}},
    {
        "block",
        {"call", {"name", "displayNext"}, "clear", {}},
        {
            "call",
            {"name", "displayNext"},
            "draw",
            {{"call", {}, "next", {}}, {"list", {{"num", "0"}, {"num", "0"}}}}
        },
        {
            "call",
            {"name", "displayMain"},
            "draw",
            {{"call", {}, "brick", {}}, {"call", {}, "brickPos", {}}, {"bitmap", {{0}}}}
        },
        {"update", {"name", "brickPos"}, {"call", {"name", "brickPos"}, "v", {}}},
        {
            "call",
            {},
            "<",
            {
                {
                    "block",
                    {"update", {"name", "brickPos"}, {"call", {"name", "brickPos"}, "<", {}}}
                }
            }
        },
        {
            "call",
            {},
            ">",
            {
                {
                    "block",
                    {"update", {"name", "brickPos"}, {"call", {"name", "brickPos"}, ">", {}}}
                }
            }
        },
        {"call", {}, "v", {{"block"}}},
        {
            "call",
            {},
            "o",
            {
                {
                    "block",
                    {"update", {"name", "brick"}, {"call", {"name", "brick"}, "rotate", {}}}
                }
            }
        },
        {
            "assign",
            {"name", "col"},
            {
                "call",
                {},
                "collision",
                {
                    {"call", {}, "displayMain", {}},
                    {"call", {}, "brick", {}},
                    {"call", {}, "brickPos", {}}
                }
            }
        },
        {"call", {"name", "col"}, "onTrue", {{"block", {"call", {}, "tr", {}}}}},
        {"call", {"name", "col"}, "onFalse", {{"block", {"call", {}, "fa", {}}}}},
        {
            "call",
            {"name", "displayMain"},
            "draw",
            {{"call", {}, "brick", {}}, {"call", {}, "brickPos", {}}, {"bitmap", {{1}}}}
        },
        {"call", {}, "gameover", {}},
        {"call", {}, "newBrick", {}},
        {"update", {"name", "lastBrickMoved"}, {"bitmap", {{0}}}}
    }
}



}
