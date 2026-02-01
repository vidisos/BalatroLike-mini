local setColorRGB = require "Utils".setColorRGB
local Rectangle = {}
Rectangle.__index = Rectangle

function Rectangle:new(x, y, width, height, background_color)
    local self = setmetatable({}, Rectangle) -- {} is basically a created object that you add stuff to wowza (setmetatable() returns a table)

    self.type = "Rectangle"
    self.isClickable = false
    self.x = x or 0
    self.y = y or 0
    self.width = width or 100
    self.height = height or 100
    self.background_color = background_color or {255, 255, 255}

    return self
end

function Rectangle:draw()
    setColorRGB(self.background_color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Rectangle
