return {[[
[2,9]
[2]
[#, #, 3]
[{block}, call, call(something){withparams}]
[
1,
2
,
3
,4
]
[1,]
[2]
[]

]],

{
    {"list", {{"num", "2"}, {"num", "9"}}},
    {"list", {{"num", "2"}}},
    {"list", {{"bitmap", {{1}}}, {"bitmap", {{1}}}, {"num", "3"}}},
    {
        "list",
        {
            {"block", {"call", {"name", "block"}, {}}},
            {"call", {"name", "call"}, {}},
            {
                "call",
                {"name", "call"},
                {
                    {"call", {"name", "something"}, {}},
                    {"block", {"call", {"name", "withparams"}, {}}}
                }
            }
        }
    },
    {"list", {{"num", "1"}, {"num", "2"}, {"num", "3"}, {"num", "4"}}},
    {"list", {{"num", "1"}}},
    {"list", {{"num", "2"}}},
    {"list", {}}
}

}
