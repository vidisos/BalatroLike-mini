local GameState = {
    points = 0
}

---sets the points lel
---@param num number
function GameState:setPoints(num)
    self.points = num or 0
end

return GameState