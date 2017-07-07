return {[[
[2,9]
[2]

[#,
##
--, 3]

[{block}, fn, fn(something){withparams}]

[
1,
2
,
3
,4
]

[,1,]
[2]
[]

]],
{
    {"get", {"list", {{"get", {"num", "2"}}, {"get", {"num", "9"}}}}},
    {"get", {"list", {{"get", {"num", "2"}}}}},
    {
        "get",
        {
            "list",
            {
                {"get", {"bitmap", {{1}}}},
                {"get", {"bitmap", {{1, 1}, {0, 0}}}},
                {"get", {"num", "3"}}
            }
        }
    },
    {
        "get",
        {
            "list",
            {
                {"get", {"block", {}, {{"get", {"call", "block", {}}}}}},
                {"get", {"call", "fn", {}}},
                {
                    "get",
                    {
                        "call",
                        "fn",
                        {
                            {"get", {"call", "something", {}}},
                            {"block", {}, {{"get", {"call", "withparams", {}}}}}
                        }
                    }
                }
            }
        }
    },
    {
        "get",
        {
            "list",
            {
                {"get", {"num", "1"}},
                {"get", {"num", "2"}},
                {"get", {"num", "3"}},
                {"get", {"num", "4"}}
            }
        }
    },
    {"get", {"list", {{"get", {"num", "1"}}}}},
    {"get", {"list", {{"get", {"num", "2"}}}}},
    {"get", {"list", {}}}
}

}
