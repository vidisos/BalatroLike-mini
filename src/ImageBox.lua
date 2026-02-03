local image_list = require "images"
local ImageBox = {}
ImageBox.__index = ImageBox

-- extension of Drawable
-- an imagebox that can be clicked
function ImageBox:ImageBox(image, func)
    self.type = "ImageBox"
    self.isClickable = true
    self.image = image or image_list.settings_icon
    self.func = func or function () end

    self.drawFunc = function (self)
        local scaleX = self.width / self.image:getWidth()
        local scaleY = self.height / self.image:getHeight()
        love.graphics.draw(self.image, self.x, self.y, 0, scaleX, scaleY)
    end

    self.onClickFunc = function (mx, my)
        local isClicked =
            self.x <= mx and mx <= self.x + self.width and
            self.y <= my and my <= self.y + self.height

        if isClicked then
            self.func()
        end
    end

    return self
end

return ImageBox
