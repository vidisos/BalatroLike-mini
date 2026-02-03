local Drawable = {}
Drawable.__index = Drawable

-- class for all drawables
function Drawable:new(x, y, width, height, updateFunc)
    local self = setmetatable({}, Drawable) -- {} is basically a created object that you add stuff to wowza (setmetatable() returns a table)

    self.x = x or 0
    self.y = y or 0
    self.width = width or 300
    self.height = height or 300
    self.updateFunc = updateFunc or function () end

    return self
end

-- defined in Drawable, empty by default
function Drawable:update(dt)
    self.updateFunc(self, dt)
end

-- from the specific drawable
function Drawable:draw()
    self.drawFunc(self)
end

-- from the specific drawable, empty by default
function Drawable:onClick(mx, my)
    if self.isClickable then
        self.onClickFunc(mx, my)
    end
end

return Drawable
