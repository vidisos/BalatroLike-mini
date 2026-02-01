local image_list = require "images"
local ImageBox = {}
ImageBox.__index = ImageBox

-- makes a new ImageBox (that can be clicked)
function ImageBox:new(image, x, y, width, height, func)
    local self = setmetatable({}, ImageBox) -- {} is basically a created object that you add stuff to wowza (setmetatable() returns a table)

    self.type = "ImageBox"
    self.isClickable = true
    self.image = image or image_list.settings_icon
    self.x = x or 0
    self.y = y or 0
    self.width = width or 100
    self.height = height or 100
    self.func = func or function () end

    return self
end

function ImageBox:draw()
    local scaleX = self.width / self.image:getWidth()
    local scaleY = self.height / self.image:getHeight()
    love.graphics.draw(self.image, self.x, self.y, 0, scaleX, scaleY)
end

function ImageBox:onClick(mx, my)
    local isClicked =
        self.x <= mx and mx <= self.x + self.width and
        self.y <= my and my <= self.y + self.height

    if isClicked then
        self.func()
    end
end

return ImageBox
