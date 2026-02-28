local Utils = require "Utils"
local GameState = require "GameState"

---@class TextBox : Drawable
local TextBox = {}

---extension of Drawable: displays text on an optional background rectangle
---@param text? LanguageEntry|string
---@param font? love.Font
---@param text_color? table
---@param background_color? table
---@param alignment? string
---@return TextBox
function TextBox:TextBox(text, font, text_color, background_color, alignment)
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
    self.align = alignment or nil

    self.drawFunc = function ()
        -- background if needed
        if background_color then
            Utils.setColorRGB(self.background_color)
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        end

        -- text
        local text = ""
        local text_type = type(self.text)
        if (text_type == "table") then
            text = self.text[GameState.current_lang]
        elseif text_type == "string" then
            text = self.text
        end

        local text_width = self.font:getWidth(text)
        local text_height = self.font:getHeight() * Utils.countLines(text)
        local text_x = Utils.getCenterAnchorX(self.x, self.width, text_width)
        local text_y = Utils.getCenterAnchorY(self.y, self.height, text_height)

        love.graphics.setFont(self.font)
        Utils.setColorRGB(self.text_color)

        if alignment then
            love.graphics.printf(text, self.x+5, text_y, self.width-5*2, alignment)
        else
            love.graphics.print(text, text_x, text_y)
        end

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
