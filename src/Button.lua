local Utils = require "Utils"
local Button = {}
Button.__index = Button

-- extension of Drawable
-- a colored rectangle with optional text that can be clicked, border at the end so it can be skipped
function Button:Button(text, font, text_color, button_color, func, border_width, border_color)
    self.type = "Button"
    self.isClickable = true
    self.text = text or ""
    self.font = font or love.graphics.getFont()
    self.text_color = text_color or {0, 0, 0}
    self.button_color = button_color or {255, 255, 255}
    self.func = func or function () end
    self.border_width = border_width or 0
    self.border_color = border_color or {0, 0, 0}

    self.drawFunc = function ()
        -- border (conditional prevents small imprecise non borders)
        Utils.setColorRGB(self.border_color)
        love.graphics.rectangle("fill", self.x - self.border_width, self.y - self.border_width, self.width + 2*self.border_width, self.height + 2*self.border_width)

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

    self.onClickFunc = function (mx, my)
        local isClicked =
            (self.x-self.border_width) <= mx and mx <= (self.x + self.width + self.border_width) and
            (self.y-self.border_width) <= my and my <= (self.y + self.height + self.border_width)

        if isClicked then
            self.func()
        end
    end

    return self
end

return Button
