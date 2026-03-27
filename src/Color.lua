local Color = {
    black = {0, 0, 0},
    white = {1, 1, 1},

    sky_blue = {0.376, 0.659, 0.820},
    light_orange = {1, 0.8, 0.4},
    dark_orange = {0.8, 0.4, 0},
    light_grey = {0.627, 0.639, 0.639},
    dark_grey = {0.361, 0.369, 0.369},
    light_blue = {0.68, 0.85, 0.9},
    blue = {0.196, 0.392, 0.784},

    red = {1, 0.1961, 0.1961},
    cornflower = {0.3922, 0.5882, 1},
    amber = {1, 0.5882, 0.1961},

    -- navy/slate scale
    navy_1 = {0.0157, 0.4000, 0.7843},
    navy_2 = {0.0118, 0.3255, 0.6431},
    navy_3 = {0.0078, 0.2431, 0.4902},
    navy_4 = {0.0000, 0.1569, 0.3333},
    navy_5 = {0.0000, 0.0941, 0.2706},
    navy_6 = {0.0000, 0.0706, 0.2000},
    slate_1 = {0.2000, 0.2549, 0.3608},
    slate_2 = {0.3608, 0.4039, 0.4902},
    slate_3 = {0.4902, 0.5216, 0.5922},
    slate_4 = {0.5922, 0.6157, 0.6745},
}

---sets the color with an RGBA table
---@param RGBA RGBA
function Color:setColor(RGBA)
    love.graphics.setColor(RGBA[1], RGBA[2], RGBA[3], RGBA[4] or 1)
end

---resets the color so images and such dont inherit color from previous calls
function Color:resetColor()
    love.graphics.setColor(self.white[1], self.white[2], self.white[3], 1)
end

---make the input color as transparent as the input alpha value
function Color:tintColor(RGBA, A)
    local A = A or 1
    return {RGBA[1], RGBA[2], RGBA[3], A}
end


return Color