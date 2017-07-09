return {[[
#
2
a
a.x
a.pos.x()
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
repeat(3)  { something }

###
###
.shift(1,2)
getTable.getValue()
game.over()

2.plus(3)
5.times{i ->
  print(i)
}

getFile().withWriter{writer -> writer.write(1)}

list.sort{a,b -> a.awesomeness.minus(b.awesomeness)}

[1,3,4].sum()


]],

{
    {"get", {"bitmap", {{1}}}},
    {"get", {"num", "2"}},
    {"get", {"call", "a", {}}},
    {"get", {"call", "a", {}}, {"call", "x", {}}},
    {"get", {"call", "a", {}}, {"call", "pos", {}}, {"call", "x", {}}},
    {"get", {"num", "2"}, {"call", "next", {}}},
    {"get", {"num", "2"}, {"call", "next", {}}},
    {
        "get",
        {"block", {},  {{"get", {"call", "a", {}}, {"call", "inc", {}}}}},
        {"call", "while", {{"block", {}, {{"get", {"call", "isSmall", {}}}}}}}
    },
    {"get", {"call", "println", {}}},
    {"get", {"call", "println", {}}},
    {"get", {"call", "println", {{"get", {"num", "1"}}, {"get", {"num", "5"}}}}},
    {
        "get",
        {
            "call",
            "print",
            {
                {"get", {"call", "line", {}}},
                {"get", {"call", "line", {}}},
                {"get", {"call", "line", {}}}
            }
        }
    },
    {"get", {"call", "do", {{"block", {}, {{"get", {"call", "something", {}}}}}}}},
    {
        "get",
        {
            "call",
            "repeat",
            {{"get", {"num", "3"}}, {"block", {}, {{"get", {"call", "something", {}}}}}}
        }
    },
    {
        "get",
        {
            "call",
            "repeat",
            {{"get", {"num", "3"}}, {"block", {}, {{"get", {"call", "something", {}}}}}}
        }
    },
    {
        "get",
        {"bitmap", {{1, 1, 1}, {1, 1, 1}}},
        {"call", "shift", {{"get", {"num", "1"}}, {"get", {"num", "2"}}}}
    },
    {"get", {"call", "getTable", {}}, {"call", "getValue", {}}},
    {"get", {"call", "game", {}}, {"call", "over", {}}},
    {"get", {"num", "2"}, {"call", "plus", {{"get", {"num", "3"}}}}},
    {
        "get",
        {"num", "5"},
        {
            "call",
            "times",
            {
                {
                    "block",
                    {"i"},
                    {{"get", {"call", "print", {{"get", {"call", "i", {}}}}}}}
                }
            }
        }
    },
    {
        "get",
        {"call", "getFile", {}},
        {
            "call",
            "withWriter",
            {
                {
                    "block",
                    {"writer"},
                    {{"get", {"call", "writer", {}}, {"call", "write", {{"get", {"num", "1"}}}}}}
                }
            }
        }
    },
    {
        "get",
        {"call", "list", {}},
        {
            "call",
            "sort",
            {
                {
                    "block",
                    {"a", "b"},
                    {{
                        "get",
                        {"call", "a", {}},
                        {"call", "awesomeness", {}},
                        {"call", "minus", {{"get", {"call", "b", {}}, {"call", "awesomeness", {}}}}}
                    }}
                }
            }
        }
    },
    {
        "get",
        {"list", {{"get", {"num", "1"}}, {"get", {"num", "3"}}, {"get", {"num", "4"}}}},
        {"call", "sum", {}}
    }
}


}
