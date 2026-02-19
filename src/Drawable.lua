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
    if self.isClickable then
        return self.isClickedFunc(mx, my)
    end

    return false
end

---@class Drawable
---@field x number
---@field y number
---@field width number
---@field height number
---@field updateFunc fun(self: Drawable, dt: number)
---@field drawFunc fun(self: Drawable)
---@field isClickable boolean
---@field isClickedFunc fun(mx: number, my: number): boolean
---@field Button fun(self: Drawable, text?: table | string, font?: love.Font, text_color?: table, button_color?: table, onClickFunc?: fun(), border_width?: number, border_color?: table): Button
---@field ImageBox fun(self: Drawable, image?: love.Image, onClickFunc?: fun()): ImageBox
---@field Rectangle fun(self: Drawable, background_color?: table): Rectangle
---@field TextBox fun(self: Drawable, text?: table | string, font?: love.Font, text_color?: table, background_color?: table): TextBox
---@field Card fun(self: Drawable, card_base?: CardBase, onClickFunc?: fun()): Card
return Drawable
