local Color = {
    black = {0, 0, 0},
    white = {1, 1, 1},

    background_blue = {0.376, 0.659, 0.820},
    light_orange = {1, 0.8, 0.4},
    dark_orange = {0.8, 0.4, 0},
    light_grey = {0.8, 0.8, 0.8},
    dark_grey = {0.55, 0.55, 0.55},
    crimson = {0.86, 0.08, 0.24},
    light_blue = {0.68, 0.85, 0.9},
    blue = {0.196, 0.392, 0.784},

    mult_text = {1, 50/255, 50/255},
    chips_text = {100/255, 150/255, 1},
    hand_text = {1, 150/255, 50/255}
}

---sets the color with an rgb table
---@param RGB RGB
function Color:setColor(RGB)
    love.graphics.setColor(RGB[1], RGB[2], RGB[3], RGB[4] or 1)
end

---resets the color so images and such dont inherit color from previous calls
function Color:resetColor()
    love.graphics.setColor(self.white[1], self.white[2], self.white[3], 1)
end


return Color