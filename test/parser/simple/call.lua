return {[[
#
2
a
a.x
//a.pos.x()
2.next()
2.next

{a.inc}.while{isSmall}

println
println()
println(1, 5)
print(
,line,
line
,line,
)
do{ something }
repeat(3){ something }

###
###
.shift(1,2)
getTable.getValue()
game.over()

2.plus(3)
5.times{ // '{' cannot be on next line
  print(i)
} // TODO block param i

[1,3,4].sum()


]],
{
    {"bitmap", {{1}}},
    {"num", "2"},
    {"call", {}, "a", {}},
    {"call", {"name", "a"}, "x", {}},
    {"call", {"num", "2"}, "next", {}},
    {"call", {"num", "2"}, "next", {}},
    {
        "call",
        {"block", {"call", {"name", "a"}, "inc", {}}},
        "while",
        {{"block", {"call", {}, "isSmall", {}}}}
    },

    {"call", {}, "println", {}},
    {"call", {}, "println", {}},
    {"call", {}, "println", {{"num", "1"}, {"num", "5"}}},
    {
        "call",
        {},
        "print",
        {
            {"call", {}, "line", {}},
            {"call", {}, "line", {}},
            {"call", {}, "line", {}}
        }
    },
    {"call", {}, "do", {{"block", {"call", {}, "something", {}}}}},
    {"call", {}, "repeat", {{"num", "3"}, {"block", {"call", {}, "something", {}}}}},

    {
        "call",
        {"bitmap", {{1, 1, 1}, {1, 1, 1}}},
        "shift",
        {{"num", "1"}, {"num", "2"}}
    },
    {"call", {"name", "getTable"}, "getValue", {}},
    {"call", {"name", "game"}, "over", {}},

    {"call", {"num", "2"}, "plus", {{"num", "3"}}},
    {
        "call",
        {"num", "5"},
        "times",
        {{"block", {"call", {}, "print", {{"call", {}, "i", {}}}}}}
    },
    {"call", {"list", {{"num", "1"}, {"num", "3"}, {"num", "4"}}}, "sum", {}}



}

}
