---@class Drawable
local Drawable = {}
Drawable.__index = Drawable

---initializes a drawable
---@param id string
---@param z_index number
---@param x? number
---@param y? number
---@param width? number
---@param height? number
---@param updateFunc? fun(self: Drawable, dt)
---@param onHoverFunc? fun(self: Drawable)
---@return Drawable
function Drawable:new(id, z_index, x, y, width, height, updateFunc, onHoverFunc)
    local self = setmetatable({}, Drawable) -- {} is basically a created object that you add stuff to wowza (setmetatable() returns a table)

    self.id = id
    self.z_index = z_index
    self.isClickable = true
    self.isHoverable = true
    self.shouldDraw = true
    self.isHovered = false

    self.x = x or 0
    self.y = y or 0
    self.width = width or 300
    self.height = height or 300
    self.updateFunc = updateFunc or function () end
    self.onHoverFunc = onHoverFunc or function () end
    self.onEnterHoverFunc = function () end
    self.onExitHoverFunc = function () end

    return self
end

---activates the update function of the drawable and checks if its hovered
---@param dt number
function Drawable:update(dt)
    self.updateFunc(self, dt)
end

---from the specific drawable
function Drawable:draw()
    self.drawFunc(self)
end

---checks if the mouse is over the drawable
---@param mx number
---@param my number
---@return boolean
function Drawable:isHoveredFunc(mx, my)
    local isHovered =
        self.x <= mx and mx <= self.x + self.width and
        self.y <= my and my <= self.y + self.height

    return isHovered
end


-- had to do this instead of requires since circular dependencies
function Drawable:Button(...)
    local Button = require("src.Button")
    return Button.Button(self, ...)
end

function Drawable:ImageBox(...)
    local ImageBox = require("src.ImageBox")
    return ImageBox.ImageBox(self, ...)
end

function Drawable:Rectangle(...)
    local Rectangle = require("src.Rectangle")
    return Rectangle.Rectangle(self, ...)
end

function Drawable:TextBox(...)
    local TextBox = require("src.TextBox")
    return TextBox.TextBox(self, ...)
end

function Drawable:Card(...)
    local Card = require("src.Card")
    return Card.Card(self, ...)
end

function Drawable:Spark(...)
    local Spark = require("src.Spark")
    return Spark.Spark(self, ...)
end

return Drawable
