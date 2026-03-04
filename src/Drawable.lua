---@class Drawable
local Drawable = {}
Drawable.__index = Drawable

---initializes a drawable
---@param x? number
---@param y? number
---@param width? number
---@param height? number
---@param updateFunc? fun(self: Drawable, dt)
---@return Drawable
function Drawable:new(x, y, width, height, updateFunc)
    local self = setmetatable({}, Drawable) -- {} is basically a created object that you add stuff to wowza (setmetatable() returns a table)

    self.x = x or 0
    self.y = y or 0
    self.width = width or 300
    self.height = height or 300
    self.updateFunc = updateFunc or function () end

    return self
end

---defined in Drawable, empty by default
---@param dt number
function Drawable:update(dt)
    self.updateFunc(self, dt)
end

---from the specific drawable
function Drawable:draw()
    self.drawFunc(self)
end

---from the specific drawable, empty by default
---@param mx number
---@param my number
---@return boolean
function Drawable:isClicked(mx, my)
    return self.isClickedFunc(mx, my)
end

return Drawable
