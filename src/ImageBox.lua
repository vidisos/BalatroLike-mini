local Utils = require "src.Utils"
local Color = require "src.Color"
local image_list = require "src.image_list"

---@class ImageBox : Drawable
local ImageBox = {}

---extension of Drawable: an imagebox that can be clicked
---@param image? love.Image
---@param onClickFunc? fun(self)
---@param color? RGBA
---@return ImageBox
function ImageBox:ImageBox(image, onClickFunc, color)
    self.type = "ImageBox"
    self.image = image or image_list.settings_icon
    self.onClickFunc = onClickFunc or function () end
    self.base_color = color or Color.white
    self.color = self.base_color

    self.drawFunc = function (self)
        Color:setColor(self.color)

        local scaleX = self.width / self.image:getWidth()
        local scaleY = self.height / self.image:getHeight()
        love.graphics.draw(self.image, self.x, self.y, 0, scaleX, scaleY)

        Color:resetColor()
    end

    return self
end

return ImageBox
