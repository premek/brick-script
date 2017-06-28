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
  display.next.clear
  display.next.draw(next, [0,0])
  display.main.draw(brick, brickPos, -)

  brickPos << brickPos.v

  // input
  <{brickPos << brickPos.<}
  >{brickPos << brickPos.>}
  v{}
  o{brick << brick.rotate}

  col: collision(display.main, brick, brickPos)
  col.#{ tr }
  col.-{fa}
  display.main.draw(brick, brickPos, #)
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
            {"bitmap", {{1, 1}, {1, 1}}},
            {"bitmap", {{1, 1, 1, 1}}},
            {"bitmap", {{0, 1}, {1, 1}, {1, 0}}}
        }
    },
    {"assign", {"name", "brickPos"}, {"list", {"num", "3"}, {"num", "0"}}},
    {"assign", {"name", "brick"}, {"call", {"name", "bricks"}, {{"num", "1"}}}},
    {"assign", {"name", "lastBrickMoved"}, {"bitmap", {{0}}}},
    {
        "block",
        {"call", {"name", "display", "next", "clear"}, {}},
        {
            "call",
            {"name", "display", "next", "draw"},
            {{"call", {"name", "next"}, {}}, {"list", {"num", "0"}, {"num", "0"}}}
        },
        {
            "call",
            {"name", "display", "main", "draw"},
            {
                {"call", {"name", "brick"}, {}},
                {"call", {"name", "brickPos"}, {}},
                {"bitmap", {{0}}}
            }
        },
        {"update", {"name", "brickPos"}, {"call", {"name", "brickPos", "v"}, {}}},
        {
            "call",
            {"name", "<"},
            {
                {
                    "block",
                    {"update", {"name", "brickPos"}, {"call", {"name", "brickPos", "<"}, {}}}
                }
            }
        },
        {
            "call",
            {"name", ">"},
            {
                {
                    "block",
                    {"update", {"name", "brickPos"}, {"call", {"name", "brickPos", ">"}, {}}}
                }
            }
        },
        {"call", {"name", "v"}, {{"block"}}},
        {
            "call",
            {"name", "o"},
            {
                {
                    "block",
                    {"update", {"name", "brick"}, {"call", {"name", "brick", "rotate"}, {}}}
                }
            }
        },
        {
            "assign",
            {"name", "col"},
            {
                "call",
                {"name", "collision"},
                {
                    {"call", {"name", "display", "main"}, {}},
                    {"call", {"name", "brick"}, {}},
                    {"call", {"name", "brickPos"}, {}}
                }
            }
        },
        {"call", {"name", "col", "#"}, {{"block", {"call", {"name", "tr"}, {}}}}},
        {"call", {"name", "col", "-"}, {{"block", {"call", {"name", "fa"}, {}}}}},
        {
            "call",
            {"name", "display", "main", "draw"},
            {
                {"call", {"name", "brick"}, {}},
                {"call", {"name", "brickPos"}, {}},
                {"bitmap", {{1}}}
            }
        },
        {"call", {"name", "gameover"}, {}},
        {"call", {"name", "newBrick"}, {}},
        {"update", {"name", "lastBrickMoved"}, {"bitmap", {{0}}}}
    }
}

}
