local Utils = require "Utils"
local TextBox = {}
TextBox.__index = TextBox

-- extension of Drawable
-- displays text on a background
function TextBox:TextBox(text, font, text_color, background_color)
    self.type = "TextBox"
    self.isClickable = false
    self.text = text or "No text"
    self.font = font or love.graphics.getFont()
    self.text_color = text_color or {0, 0, 0}
    self.background_color = background_color or {255, 255, 255}

    self.drawFunc = function ()
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

    return self
end

return TextBox
