local GameState = require "src.GameState"
local Color     = require "src.Color"
--[[
Copyright (c) 2016 George Prosser

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
]]

---@class Slider : Drawable
local Slider = {}

---extension of Drawable: a slider for selecting values within a range
---@param color RGBA 
---@param value number
---@param min number
---@param max number
---@param setter? fun(value: number)
---@param orientation? "horizontal"|"vertical"
---@param track? "rectangle"|"line"|"roundrect"
---@param knob? "rectangle"|"circle"
---@return Slider
function Slider:Slider(color, value, min, max, setter, orientation, track, knob)
    self.base_color = color or Color.white
    self.color = self.base_color
    self.type = "Slider"
    self.value = (value - min) / (max - min)
    self.min = min
    self.max = max
    self.setter = setter or function() end
    self.orientation = orientation or 'horizontal'
    self.track = track or 'rectangle'
    self.knob = knob or 'rectangle'
    self.onClickFunc = function () end

    self.grabbed = false
    self.wasDown = true
    self.ox = 0
    self.oy = 0

    self.updateFunc = function(self, dt)
        local x = GameState.mx
        local y = GameState.my
        local down = love.mouse.isDown(1)

        local cx = self.x + self.width/2
        local cy = self.y + self.height/2

        local knobX = cx
        local knobY = cy
        if self.orientation == 'horizontal' then
            knobX = cx - self.width/2 + self.width * self.value
        elseif self.orientation == 'vertical' then
            knobY = cy + self.width/2 - self.width * self.value
        end

        local ox = x - knobX
        local oy = y - knobY

        local dx = ox - self.ox
        local dy = oy - self.oy

        if down then
            if self.grabbed then
                if self.orientation == 'horizontal' then
                    self.value = self.value + dx / self.width
                elseif self.orientation == 'vertical' then
                    self.value = self.value - dy / self.width
                end
            elseif (x > knobX - self.height/2 and x < knobX + self.height/2 and y > knobY - self.height/2 and y < knobY + self.height/2) and not self.wasDown then
                self.ox = ox
                self.oy = oy
                self.grabbed = true
            end
        else
            self.grabbed = false
        end

        self.value = math.max(0, math.min(1, self.value))

        if self.setter then
            self.setter(self.min + self.value * (self.max - self.min))
        end

        self.wasDown = down
    end

    self.drawFunc = function()
        Color:setColor(self.color)
        local cx = self.x + self.width/2
        local cy = self.y + self.height/2

        if self.track == 'rectangle' then
            if self.orientation == 'horizontal' then
                love.graphics.rectangle('line', cx - self.width/2 - self.height/2, cy - self.height/2, self.width + self.height, self.height)
            elseif self.orientation == 'vertical' then
                love.graphics.rectangle('line', cx - self.height/2, cy - self.width/2 - self.height/2, self.height, self.width + self.height)
            end
        elseif self.track == 'line' then
            if self.orientation == 'horizontal' then
                love.graphics.line(cx - self.width/2, cy, cx + self.width/2, cy)
            elseif self.orientation == 'vertical' then
                love.graphics.line(cx, cy - self.width/2, cx, cy + self.width/2)
            end
        elseif self.track == 'roundrect' then
            if self.orientation == 'horizontal' then
                love.graphics.rectangle('line', cx - self.width/2 - self.height/2, cy - self.height/2, self.width + self.height, self.height, self.height/2, self.height)
            elseif self.orientation == 'vertical' then
                love.graphics.rectangle('line', cx - self.height/2, cy - self.width/2 - self.height/2, self.height, self.width + self.height, self.height, self.height/2)
            end
        end

        local knobX = cx
        local knobY = cy
        if self.orientation == 'horizontal' then
            knobX = cx - self.width/2 + self.width * self.value
        elseif self.orientation == 'vertical' then
            knobY = cy + self.width/2 - self.width * self.value
        end

        if self.knob == 'rectangle' then
            love.graphics.rectangle('fill', knobX - self.height/2, knobY - self.height/2, self.height, self.height)
        elseif self.knob == 'circle' then
            love.graphics.circle('fill', knobX, knobY, self.height/2)
        end
    end

    self.isHoveredFunc = function(self, mx, my)
        local cx = self.x + self.width/2
        local cy = self.y + self.height/2

        if self.orientation == 'horizontal' then
            local left   = cx - self.width/2 - self.height/2
            local right  = cx + self.width/2 + self.height/2
            local top    = cy - self.height/2
            local bottom = cy + self.height/2
            return mx >= left and mx <= right and my >= top and my <= bottom

        elseif self.orientation == 'vertical' then
            local left   = cx - self.height/2
            local right  = cx + self.height/2
            local top    = cy - self.width/2 - self.height/2
            local bottom = cy + self.width/2 + self.height/2
            return mx >= left and mx <= right and my >= top and my <= bottom
        end
    end

    return self
end

function Slider:getValue()
    return self.min + self.value * (self.max - self.min)
end

return Slider