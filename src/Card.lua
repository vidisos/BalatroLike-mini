local Utils = require "Utils"
local image_list = require "image_list"
local card_list = require "card_list"

---@class Card : Drawable
local Card = {}
Card.__index = Card

---extension of Drawable: an imagebox that can be clicked
---@param card_base CardBase
---@param onClickFunc? function
---@return Card
function Card:Card(card_base, onClickFunc)
    self.type = "Card"

    self.isClickable = true
    self.image = card_base.image or image_list.settings_icon
    self.suit = card_base.suit or ""
    self.rank = card_base.rank or 0
    self.onClickFunc = onClickFunc or function () end

    self.drawFunc = function (self)
        local scaleX = self.width / self.image:getWidth()
        local scaleY = self.height / self.image:getHeight()
        love.graphics.draw(self.image, self.x, self.y, 0, scaleX, scaleY)

        Utils.resetColor()
    end

    self.isClickedFunc = function (mx, my)
        local isClicked =
            self.x <= mx and mx <= self.x + self.width and
            self.y <= my and my <= self.y + self.height

        return isClicked
    end

    return self
end

return Card
