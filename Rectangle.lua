local Utils = require "Utils"

---@class Rectangle : Drawable
local Rectangle = {}

---extension of Drawable: a colored rectangle
---@param background_color? table
---@return Rectangle
function Rectangle:Rectangle(background_color)
    self.type = "Rectangle"
    self.isClickable = false
    self.background_color = background_color or {255, 255, 255}

    self.drawFunc = function ()
        Utils.setColorRGB(self.background_color)
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

        Utils.resetColor()
    end

    self.isClickedFunc = function (mx, my)
        local isClicked =
            self.x <= mx and mx <= self.x + self.width and
            self.y <= my and my <= self.y + self.height

        return isClicked
    end

    return self
end

return Rectangle
