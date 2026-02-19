local Utils = require "Utils"
local GameState = require "GameState"

---@class Button : Drawable
local Button = {}
Button.__index = Button

-- just here so we can reference the functions before theyre declared fully for readability reasons
local normalButtonDraw, borderedButtonDraw

---extension of Drawable: a colored rectangle with optional text that can be clicked, optional border
---@param text? table
---@param font? love.Font
---@param text_color? table
---@param button_color? table
---@param onClickFunc? function
---@param border_width? number
---@param border_color? table
---@return Button
function Button:Button(text, font, text_color, button_color, onClickFunc, border_width, border_color)
    self.type = "Button"
    self.isClickable = true

    if (type(text) == "table") then
        self.text = text or {"", ""}
    else 
        self.text = text or ""
    end

    self.font = font or love.graphics.getFont()
    self.text_color = text_color or {0, 0, 0}
    self.button_color = button_color or {255, 255, 255}
    self.onClickFunc = onClickFunc or function () end
    self.border_width = border_width or 0
    self.border_color = border_color or {0, 0, 0}

    if border_width and border_width > 0 then
        self.width = self.width + 2*self.border_width
        self.height = self.height + 2*self.border_width
    end

    self.drawFunc = function ()
        if border_width then
            borderedButtonDraw(self)
        else
            normalButtonDraw(self)
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

---drawing a button normally
---@param self Button
normalButtonDraw = function(self)
    -- button
    Utils.setColorRGB(self.button_color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

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
end

---drawing a button that basically makes the border part of it in terms of width and such
---@param self Button
borderedButtonDraw = function(self)
    -- border
    Utils.setColorRGB(self.border_color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- button
    Utils.setColorRGB(self.button_color)
    local button_x = self.x + self.border_width
    local button_y = self.y + self.border_width
    local button_width = self.width - 2*self.border_width
    local button_height = self.height - 2*self.border_width
    love.graphics.rectangle("fill", button_x, button_y, button_width, button_height)

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
end

return Button
