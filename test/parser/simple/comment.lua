return {[[
1
// oneline
// another line
1 /* block */ 1/* multiple
lines
*/1
TODO get life
2 FIXME should be 3
3 XXX do not commit
1
TODO
1 FIXME
//
/**/
/*
*/
]],
{
    {"get", {"num", "1"}},
    {"get", {"num", "1"}},
    {"get", {"num", "1"}},
    {"get", {"num", "1"}},
    {"task", "todo", "get life"},
    {"get", {"num", "2"}},
    {"task", "fixme", "should be 3"},
    {"get", {"num", "3"}},
    {"task", "xxx", "do not commit"},
    {"get", {"num", "1"}},
    {"task", "todo", ""},
    {"get", {"num", "1"}},
    {"task", "fixme", ""}

}

}
