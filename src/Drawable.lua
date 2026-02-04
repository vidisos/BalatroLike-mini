local Drawable = {}
Drawable.__index = Drawable

---class for all drawables
---@param x? number
---@param y? number
---@param width? number
---@param height? number
---@param updateFunc? function
---@return table
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
    if self.isClickable then
        return self.isClickedFunc(mx, my)
    end

    return false
end

return Drawable
