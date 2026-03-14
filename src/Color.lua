local Color = {
    black = {0, 0, 0},
    black = {1, 1, 1},
    mult_text = {1, 50/255, 50/255},
    chips_text = {100/255, 150/255, 1},
    hand_text = {1, 150/255, 50/255},
    light_orange = {1, 220/255, 50/255}
}

---sets the color with an rgb table
---@param RGB RGB
function Color:setColor(RGB)
    love.graphics.setColor(RGB[1], RGB[2], RGB[3], RGB[4] or 1)
end

---resets the color so images and such dont inherit color from previous calls
function Color:resetColor()
    love.graphics.setColor(self.black[1], self.black[2], self.black[3], 1)
end


return Color