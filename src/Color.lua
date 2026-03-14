local Color = {
    black = {0, 0, 0},
    white = {1, 1, 1},

    background_blue = {0.376, 0.659, 0.820},
    light_orange = {1, 0.8, 0.4},
    dark_orange = {0.8, 0.4, 0},
    light_grey = {0.627, 0.639, 0.639},
    dark_grey = {0.361, 0.369, 0.369},
    light_blue = {0.68, 0.85, 0.9},
    blue = {0.196, 0.392, 0.784},

    red = {1, 0.1961, 0.1961},
    chips_text = {0.3922, 0.5882, 1},
    hand_text = {1, 0.5882, 0.1961}
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