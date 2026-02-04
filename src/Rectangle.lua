local Utils = require "Utils"
local Rectangle = {}
Rectangle.__index = Rectangle

-- extension of Drawable
-- a colored rectangle
function Rectangle:Rectangle(background_color)
    self.type = "Rectangle"
    self.isClickable = false
    self.background_color = background_color or {255, 255, 255}

    self.drawFunc = function ()
        Utils.setColorRGB(self.background_color)
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

        Utils.resetColor()
    end

    return self
end

return Rectangle
