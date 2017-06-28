return {[[
game.over
println
println()
println(1, 5)
do{ something }
repeat(3){ something }

]],
{
    {"call", {"name", "game", "over"}, {}},
    {"call", {"name", "println"}, {}},
    {"call", {"name", "println"}, {}},
    {"call", {"name", "println"}, {{"num", "1"}, {"num", "5"}}},
    {"call", {"name", "do"}, {{"block", {"call", {"name", "something"}, {}}}}},
    {"call", {"name", "repeat"}, {{"num", "3"}, {"block", {"call", {"name", "something"}, {}}}}}
}

}
