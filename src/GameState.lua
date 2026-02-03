local GameState = {
    points = 0
}

function GameState.setPoints(num)
    GameState.points = num or 0
end

return GameState