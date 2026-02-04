local GameState = {
    points = 0
}

function GameState:setPoints(num)
    self.points = num or 0
end

return GameState