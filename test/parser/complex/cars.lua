return {[[

car:
-#-
###
-#-
#-#
pos: [3, 16]

 // FIXME block args:   time|
  displayMain.draw(car, pos, -) // FIXME display.main.draw()
  <{pos << pos.<}
  >{pos << pos.>}
  col: collision(displayMain, car, pos)
  col.onTrue{ gameover }
  time.every(2){ displayMain.v }
  score.inc
  displayMain.draw(car, pos, #)


]],
{
    {
        "assign",
        {"name", "car"},
        {"bitmap", {{0, 1, 0}, {1, 1, 1}, {0, 1, 0}, {1, 0, 1}}}
    },
    {"assign", {"name", "pos"}, {"list", {{"num", "3"}, {"num", "16"}}}},
    {
        "call",
        {"name", "displayMain"},
        "draw",
        {{"call", {}, "car", {}}, {"call", {}, "pos", {}}, {"bitmap", {{0}}}}
    },
    {
        "call",
        {},
        "<",
        {{"block", {"update", {"name", "pos"}, {"call", {"name", "pos"}, "<", {}}}}}
    },
    {
        "call",
        {},
        ">",
        {{"block", {"update", {"name", "pos"}, {"call", {"name", "pos"}, ">", {}}}}}
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
                {"call", {}, "car", {}},
                {"call", {}, "pos", {}}
            }
        }
    },
    {"call", {"name", "col"}, "onTrue", {{"block", {"call", {}, "gameover", {}}}}},
    {
        "call",
        {"name", "time"},
        "every",
        {{"num", "2"}, {"block", {"call", {"name", "displayMain"}, "v", {}}}}
    },
    {"call", {"name", "score"}, "inc", {}},
    {
        "call",
        {"name", "displayMain"},
        "draw",
        {{"call", {}, "car", {}}, {"call", {}, "pos", {}}, {"bitmap", {{1}}}}
    }
}



}
