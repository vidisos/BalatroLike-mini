local Utils = require "Utils"
local Button = {}
Button.__index = Button

-- makes a new button
function Button:new(text, font, x, y, width, height, text_color, button_color, func)
    local self = setmetatable({}, Button) -- {} is basically a created object that you add stuff to wowza (setmetatable() returns a table)

    self.type = "Button"
    self.isClickable = true
    self.text = text or ""
    self.font = font or love.graphics.getFont()
    self.x = x or 0
    self.y = y or 0
    self.width = width or 100
    self.height = height or 100
    self.text_color = text_color or {0, 0, 0}
    self.button_color = button_color or {255, 255, 255}
    self.func = func or function () end

    return self
end

function Button:draw()
    -- button
    Utils.setColorRGB(self.button_color)
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

function Button:onClick(mx, my)
    local isClicked =
        self.x <= mx and mx <= self.x + self.width and
        self.y <= my and my <= self.y + self.height

    if isClicked then
        self.func()
    end
end

return Button
