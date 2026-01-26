local setColorRGB = require "Utils".setColorRGB
local Button = {}
Button.__index = Button

function Button:new(text, font, x, y, width, height, text_color, button_color, func)
    local self = setmetatable({}, Button) -- {} is basically a created object that you add stuff to wowza (setmetatable() returns a table)

    self.text = text or ""
    self.font = font or love.graphics.getFont()
    self.x = x or 0
    self.y = y or 0
    self.width = width or 100
    self.height = height or 100
    self.text_color = text_color or {0, 0, 0}
    self.button_color = button_color or {255, 255, 255}
    self.func = func or nil

    return self
end

function Button:draw()
    local rgb;

    -- button
    rgb = self.button_color
    setColorRGB(rgb)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- text
    local text_width = self.font:getWidth(self.text)
    local text_height = self.font:getHeight()
    local text_x = self.x + self.width/2 - text_width + text_width/2
    local text_y = self.y + self.height/2 - text_height + text_height/2

    rgb = self.text_color
    love.graphics.setFont(self.font)
    setColorRGB(rgb)
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
