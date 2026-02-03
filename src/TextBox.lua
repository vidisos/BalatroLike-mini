local Utils = require "Utils"
local TextBox = {}
TextBox.__index = TextBox

function TextBox:new(text, font, x, y, width, height, text_color, background_color, updateFunc)
    local self = setmetatable({}, TextBox) -- {} is basically a created object that you add stuff to wowza (setmetatable() returns a table)

    self.type = "TextBox"
    self.isClickable = false
    self.isUpdatable = true
    self.text = text or "No text"
    self.font = font or love.graphics.getFont()
    self.x = x or 0
    self.y = y or 0
    self.width = width or 100
    self.height = height or 100
    self.text_color = text_color or {0, 0, 0}
    self.background_color = background_color or {255, 255, 255}
    self.updateFunc = updateFunc or function () end
    return self
end

function TextBox:draw()
    -- button
    Utils.setColorRGB(self.background_color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- text
    local text_width = self.font:getWidth(self.text)
    local text_height = self.font:getHeight()
    local text_x = Utils.getCenterAnchorX(self.x, self.width, text_width)
    local text_y = Utils.getCenterAnchorY(self.y, self.height, text_height)

    love.graphics.setFont(self.font)
    Utils.setColorRGB(self.text_color)
    love.graphics.print(self.text, text_x, text_y)
end

function TextBox:update(dt)
    self.updateFunc(self, dt)
end

return TextBox
