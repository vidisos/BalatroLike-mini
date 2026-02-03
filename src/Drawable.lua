local Utils = require "Utils"
local Drawable = {}
Drawable.__index = Drawable

-- makes a new button
function Drawable:new(x, y, width, height, updateFunc)
    local self = setmetatable({}, Drawable) -- {} is basically a created object that you add stuff to wowza (setmetatable() returns a table)
    
    self.isClickable = true
    self.isUpdatable = true
    self.text = text or ""
    self.font = font or love.graphics.getFont()
    self.x = x or 0
    self.y = y or 0
    self.width = width or 100
    self.height = height or 100
    self.text_color = text_color or {0, 0, 0}
    self.button_color = button_color or {255, 255, 255}
    self.func = func or function () end
    self.updateFunc = updateFunc or function () end

    return self
end

function Drawable:update(dt)
    self.updateFunc(self, dt)
end


return Drawable
