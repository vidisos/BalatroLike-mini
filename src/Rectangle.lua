local Color = require "src.Color"

---@class Rectangle : Drawable
local Rectangle = {}

local normalRectDraw, borderedRectDraw

---extension of Drawable: a colored rectangle
---@param color? RGBA
---@param border_width? number
---@param border_color? RGBA
---@return Rectangle
function Rectangle:Rectangle(color, border_width, border_color)
    self.type = "Rectangle"
    self.base_color = color or Color.black
    self.color = self.base_color
    self.border_width = border_width or nil
    self.border_color = border_color or Color.black

    self.drawFunc = function ()
        if border_width then
            borderedRectDraw(self)
        else
            normalRectDraw(self)
        end

        Color:resetColor()
    end

    -- we dont need the onclick for this drawable, this is just here so it doesnt break
    self.onClickFunc = function () end

    return self
end

---drawing rectangle normally without border
---@param self Rectangle|Drawable
normalRectDraw = function (self)
    Color:setColor(self.color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

---drawing the rectangle with a border
---@param self Rectangle|Drawable
borderedRectDraw = function (self)
    -- border
    Color:setColor(self.border_color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- rect
    Color:setColor(self.color)
    local button_x = self.x + self.border_width
    local button_y = self.y + self.border_width
    local button_width = self.width - 2*self.border_width
    local button_height = self.height - 2*self.border_width
    love.graphics.rectangle("fill", button_x, button_y, button_width, button_height)
end

return Rectangle
