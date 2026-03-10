local Utils = require "src.Utils"
local Color = require "src.Color"
local GameState = require "src.GameState"

---@class TextBox : Drawable
local TextBox = {}

---extension of Drawable: displays text on an optional background rectangle, text can be aligned
---
---Supported `text` formats:
---  * **string** – plain text
---  * **language table** – indexed by `GameState.current_lang`
---  * **colored table** – alternating color tables and strings like `{ {255,0,0}, "Red", {0,255,0}, "Green" }`
---@param text? table|LanguageEntry|string
---@param font? love.Font
---@param text_color? RGB
---@param background_color? RGB
---@param alignment? string
---@return TextBox
function TextBox:TextBox(text, font, text_color, background_color, alignment)
    self.type = "TextBox"
    self.text = text or ""
    self.baseFont = font or love.graphics.getFont()
    self.font = font or self.baseFont
    self.text_color = text_color or {0, 0, 0}
    self.background_color = background_color
    self.alignment = alignment

    -- we dont need the onclick for this drawable, this is just here so it doesnt break
    self.onClickFunc = function () end

    self.drawFunc = function ()
        --background rectangle
        if background_color then
            Color:setColorRGB(self.background_color)
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        end

        -- TEXT 
        -- we detect if its a colored table, otherwise language table or plain string
        local display
        local isColoredTable = type(self.text) == "table" and type(self.text[1]) == "table" and type(self.text[2]) == "string"

        if isColoredTable then
            -- colored text table
            display = self.text
        elseif type(self.text) == "table" then
            -- language table
            display = self.text[GameState.current_lang] or ""
            if self.text.font then
                self.font = self.text.font
            else
                self.font = self.baseFont
            end
        else
            -- plain string
            display = self.text or ""
        end

        local plain_text = Utils.plainTextFrom(display)
        local text_width = self.font:getWidth(plain_text)
        local text_height = self.font:getHeight() * Utils.countLines(plain_text)
        local text_x = Utils.getCenterAnchorX(self.x, self.width, text_width)
        local text_y = Utils.getCenterAnchorY(self.y, self.height, text_height)

        love.graphics.setFont(self.font)

        -- only color whole text when not using a colored sequence
        if not isColoredTable then
            Color:setColorRGB(self.text_color)
        end

        if self.alignment then
            love.graphics.printf(display, self.x + 5, text_y, self.width - 10, self.alignment)
        else
            love.graphics.print(display, text_x, text_y)
        end

        Color:resetColor()
    end

    return self
end

return TextBox
