local Utils = require "Utils"
local GameState = require "GameState"

---@class TextBox : Drawable
local TextBox = {}
TextBox.__index = TextBox

---extension of Drawable: displays text on an optional background rectangle
---@param text? table|string
---@param font? love.Font
---@param text_color? table
---@param background_color? table
---@return TextBox
function TextBox:TextBox(text, font, text_color, background_color)
    self.type = "TextBox"
    self.isClickable = false

    if (type(text) == "table") then
        self.text = text or {"", ""}
    else 
        self.text = text or ""
    end

    self.font = font or love.graphics.getFont()
    self.text_color = text_color or {0, 0, 0}
    self.background_color = background_color

    self.drawFunc = function ()
        -- background if needed
        if background_color then
            Utils.setColorRGB(self.background_color)
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        end

        -- text
        local text
        local text_type = type(self.text)
        if (text_type == "table") then
            text = self.text[GameState.current_lang]
        elseif text_type == "string" then
            text = self.text
        else 
            text = ""
        end

        local text_width = self.font:getWidth(text)
        local text_height = self.font:getHeight()
        local text_x = Utils.getCenterAnchorX(self.x, self.width, text_width)
        local text_y = Utils.getCenterAnchorY(self.y, self.height, text_height)

        love.graphics.setFont(self.font)
        Utils.setColorRGB(self.text_color)
        love.graphics.print(text, text_x, text_y)

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

return TextBox
