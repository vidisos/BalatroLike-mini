local Color = {
    black = {0, 0, 0},
    white = {1, 1, 1},

    green = {0.0627, 0.7608, 0.0627},
    sky_blue = {0.376, 0.659, 0.820},
    light_orange = {1, 0.8, 0.4},
    orange = {0.9294, 0.6824, 0.102},
    dark_orange = {0.8, 0.4, 0},
    light_grey = {0.627, 0.639, 0.639},
    grey = {0.3137, 0.3176, 0.3412},
    dark_grey = {0.1569, 0.1608, 0.1686},
    light_blue = {0.2196, 0.5529, 0.9608},
    dark_blue = {0.0275, 0.2314, 0.9098},
    blue = {0.2745, 0.5412, 0.9412},

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
    love.graphics.setColor(self.white)
end

---make the input color as transparent as the input alpha value
function Color:tintColor(RGBA, A)
    local A = A or 1
    return {RGBA[1], RGBA[2], RGBA[3], A}
end


return Color