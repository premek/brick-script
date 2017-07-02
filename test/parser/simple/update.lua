return {[[
score:0
score << 2
score << score.plus(1)

game.speed:2
game.speed << maxSpeed

]],
{
    {"assign", {"var", "score"}, {"get", {"num", "0"}}},
    {"update", {"var", "score"}, {"get", {"num", "2"}}},
    {
        "update",
        {"var", "score"},
        {"get", {"call", "score", {}}, {"call", "plus", {{"get", {"num", "1"}}}}}
    },
    {"assign", {"var", {"call", "game", {}}, "speed"}, {"get", {"num", "2"}}},
    {
        "update",
        {"var", {"call", "game", {}}, "speed"},
        {"get", {"call", "maxSpeed", {}}}
    }
}


}
