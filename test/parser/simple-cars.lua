return {[[

car:
-#-
###
-#-
#-#
pos: [3, 16]
(time){
  display.main.draw(car, pos, -)
  <{pos << pos.<}
  >{pos << pos.>}
  col: collision(display.main, car, pos)
  col.#{ gameover }
  time.every(2){ display.main.v }
  score.inc()
  display.main.draw(car, pos, #)
}

]],
{
    {
        "assign",
        {"name", "car"},
        {"bitmap", {{0, 1, 0}, {1, 1, 1}, {0, 1, 0}, {1, 0, 1}}}
    },
    {"assign", {"name", "pos"}, {"list", {"num", "3"}, {"num", "16"}}},
    {
        "fn",
        {"params", "time"},
        {
            "block",
            {
                "call",
                {"name", "display", "main", "draw"},
                {"call", {"name", "car"}},
                {"call", {"name", "pos"}},
                {"bitmap", {{0}}}
            },
            {
                "call",
                {"name", "<"},
                {"block", {"update", {"name", "pos"}, {"call", {"name", "pos", "<"}}}}
            },
            {
                "call",
                {"name", ">"},
                {"block", {"update", {"name", "pos"}, {"call", {"name", "pos", ">"}}}}
            },
            {
                "assign",
                {"name", "col"},
                {
                    "call",
                    {"name", "collision"},
                    {"call", {"name", "display", "main"}},
                    {"call", {"name", "car"}},
                    {"call", {"name", "pos"}}
                }
            },
            {"call", {"name", "col", "#"}, {"block", {"call", {"name", "gameover"}}}},
            {
                "call",
                {"name", "time", "every"},
                {"num", "2"},
                {"block", {"call", {"name", "display", "main", "v"}}}
            },
            {"call", {"name", "score", "inc"}},
            {
                "call",
                {"name", "display", "main", "draw"},
                {"call", {"name", "car"}},
                {"call", {"name", "pos"}},
                {"bitmap", {{1}}}
            }
        }
    }
}

}
