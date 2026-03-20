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
---  * **colored table** – alternating color tables and strings like `{ {1,0,0}, "Red", {0,1,0}, "Green" }`
---@param text? table|LanguageEntry|string
---@param font? love.Font
---@param text_color? RGB
---@param background_color? RGB
---@param text_alignment? "left"|"center"|"right"
---@param text_margin? number
---@return TextBox
function TextBox:TextBox(text, font, text_color, background_color, text_alignment, text_margin)
    self.type = "TextBox"
    self.text = text or ""
    self.baseFont = font or love.graphics.getFont()
    self.font = font or self.baseFont
    self.text_color = text_color or Color.black
    self.background_color = background_color
    self.text_alignment = text_alignment or "center"
    self.text_margin = text_margin or 0

    -- we dont need the onclick for this drawable, this is just here so it doesnt break
    self.onClickFunc = function () end

    self.drawFunc = function ()
        --background rectangle
        if background_color then
            Color:setColor(self.background_color)
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        end

        Utils.drawText(self.text, self.font, self.text_color, GameState.current_lang, self.x, self.y, self.width, self.height, self.text_alignment, self.text_margin)
    end

    return self
end

return TextBox
