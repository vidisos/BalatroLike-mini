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
---  * **colored table** – alternating color tables and strings like `{ {255,0,0}, "Red", {0,255,0}, "Green" }`
---@param text? LanguageEntry|string
---@param font? love.Font
---@param text_color? RGB
---@param button_color? RGB
---@param onClickFunc? fun(self)
---@param border_width? number
---@param border_color? RGB
---@return Button
function Button:Button(text, font, text_color, button_color, onClickFunc, border_width, border_color)
    self.type = "Button"
    self.text = text or ""
    self.baseFont = font or love.graphics.getFont()
    self.font = font or self.baseFont
    self.text_color = text_color or {0, 0, 0}
    self.button_color = button_color or {255, 255, 255}
    self.onClickFunc = onClickFunc or function () end
    self.border_width = border_width or 0
    self.border_color = border_color or {0, 0, 0}

    self.drawFunc = function ()
        if border_width then
            borderedButtonDraw(self)
        else
            normalButtonDraw(self)
        end

        Color:resetColor()

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

        love.graphics.print(display, text_x, text_y)

        Color:resetColor()
    end

    return self
end

---drawing a button normally
---@param self Button|Drawable
normalButtonDraw = function(self)
    -- button
    Color:setColorRGB(self.button_color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

---drawing a button that basically makes the border part of it in terms of width and such
---@param self Button|Drawable
borderedButtonDraw = function(self)
    -- border
    Color:setColorRGB(self.border_color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- button
    Color:setColorRGB(self.button_color)
    local button_x = self.x + self.border_width
    local button_y = self.y + self.border_width
    local button_width = self.width - 2*self.border_width
    local button_height = self.height - 2*self.border_width
    love.graphics.rectangle("fill", button_x, button_y, button_width, button_height)
end

return Button
