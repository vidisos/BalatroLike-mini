local Utils = require "src.Utils"
local Color = require "src.Color"
local GameState = require "src.GameState"

---@class Button : Drawable
local Button = {}

-- just here so we can reference the functions before theyre declared fully for readability reasons
local normalButtonDraw, borderedButtonDraw

---extension of Drawable: a colored rectangle with optional text that can be clicked, optional border
---
---Supported `text` formats:
---  * **string** – plain text
---  * **language table** – indexed by `GameState.current_lang`
---  * **colored table** – alternating color tables and strings like `{ {1,0,0}, "Red", {0,1,0}, "Green" }`
---@param text? LanguageEntry|string
---@param font? love.Font
---@param text_color? RGB
---@param background_color? RGB
---@param onClickFunc? fun(self)
---@param border_width? number
---@param border_color? RGB
---@param text_alignment? "left"|"center"|"right"
---@param text_margin? number
---@return Button
function Button:Button(text, font, text_color, background_color, onClickFunc, border_width, border_color, text_alignment, text_margin)
    self.type = "Button"
    self.text = text or ""
    self.baseFont = font or love.graphics.getFont()
    self.font = font or self.baseFont
    self.text_color = text_color or Color.black
    self.button_color = background_color or Color.white
    self.onClickFunc = onClickFunc or function () end
    self.border_width = border_width or 0
    self.border_color = border_color or Color.white
    self.text_alignment = text_alignment or "center"
    self.text_margin = text_margin or 0

    self.drawFunc = function ()
        -- BUTTON
        if border_width then
            borderedButtonDraw(self)
        else
            normalButtonDraw(self)
        end

        Color:resetColor()

        Utils.drawText(self.text, self.font, self.text_color, GameState.current_lang, self.x, self.y, self.width, self.height, self.text_alignment, self.text_margin)
    end

    return self
end

---drawing a button normally
---@param self Button|Drawable
normalButtonDraw = function(self)
    -- button
    Color:setColor(self.button_color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

---drawing a button that basically makes the border part of it in terms of width and such
---@param self Button|Drawable
borderedButtonDraw = function(self)
    -- border
    Color:setColor(self.border_color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- button
    Color:setColor(self.button_color)
    local button_x = self.x + self.border_width
    local button_y = self.y + self.border_width
    local button_width = self.width - 2*self.border_width
    local button_height = self.height - 2*self.border_width
    love.graphics.rectangle("fill", button_x, button_y, button_width, button_height)
end

return Button
