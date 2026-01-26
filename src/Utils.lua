local Utils = {}

function Utils.setColorRGB(rgb)
    love.graphics.setColor(love.math.colorFromBytes(rgb[1], rgb[2], rgb[3]))
end

return Utils
