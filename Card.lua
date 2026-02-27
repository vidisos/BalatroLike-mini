local Utils = require "Utils"
local image_list = require "image_list"

---@class Card : Drawable
---@field type string
---@field isClickable boolean
---@field image love.Image
---@field baseImage love.Image
---@field backImage love.Image
---@field suit string
---@field rank number
---@field selected boolean
---@field flipped boolean
---@field inDeck boolean
---@field onClickFunc fun()
---@field drawFunc fun(self: Card)
---@field isClickedFunc fun(mx: number, my: number): boolean
---@field x number
---@field y number
---@field width number
---@field height number
local Card = {}

---extension of Drawable: an imagebox that can be clicked
---@param card_base CardBase
---@param onClickFunc? function
---@return Card
function Card:Card(card_base, onClickFunc)
    self.type = "Card"
    self.isClickable = true
    self.image = card_base.image or image_list.settings_icon
    self.baseImage = self.image --so we can switch from the back of the card to the front without forgetting which it is
    self.backImage = image_list.cards.cardBack3
    self.suit = card_base.suit or ""
    self.rank = card_base.rank or 0

    self.selected = false
    self.flipped = false
    self.inDeck = false
    self.onClickFunc = onClickFunc or function () end

    self.drawFunc = function (self)
        local scaleX = self.width / self.image:getWidth()
        local scaleY = self.height / self.image:getHeight()

        if not self.flipped then
            self.image = self.baseImage
        else
            if self.suit=="spade" or self.suit=="club" then
                self.backImage = image_list.cards.cardBack3
            elseif self.suit=="heart" or self.suit=="diamond" then
                self.backImage = image_list.cards.cardBack1
            end

            self.image = self.backImage
        end

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
