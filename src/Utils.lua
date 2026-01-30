local Utils = {}

function Utils.setColorRGB(rgb)
    love.graphics.setColor(love.math.colorFromBytes(rgb[1], rgb[2], rgb[3]))
end

-- returns the x to center an inner items inside an outer item
function Utils.getCenterAnchorX(x, outer_width, inner_width)
    local x = x + outer_width / 2 - inner_width / 2
    return x
end
-- returns the y to center an inner items inside an outer item
function Utils.getCenterAnchorY(y, outer_height, inner_height)
    local y = y + outer_height / 2 - inner_height / 2
    return y
end

function Utils.resizeFont(font, size)
    local font = love.graphics.newFont(font, size)
    return font
end

return Utils
