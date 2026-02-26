local Scenes = require "Scenes"
local Drawable = require "Drawable"
local CONSTANTS = require "CONSTANTS"
local card_list = require "card_list"
local Utils     = require "Utils"

local GameState = {
    current_lang = "sl",
    timer = 0,

    level = 1,
    score_requirement = 600,

    score = 0,
    chips = 0,
    mult = 0,
    selected_hand = "Pair";
    hands_remaining = 5,
    discards_remaining = 5,
    hand_size = 8
}

function GameState:startNewRound()
    self:makeNewHand()
end

function GameState:makeNewHand()
    Scenes:clearCards()

    for i=1, self.hand_size do
        local id = "card-" .. i
        local z_index = 10 + i

        local spacing = ((i-1) * (CONSTANTS.HAND_WIDTH - CONSTANTS.CARD_WIDTH) / (self.hand_size - 1))
        local x = CONSTANTS.HAND_X + spacing
        local y = CONSTANTS.HAND_Y
        local width = CONSTANTS.CARD_WIDTH
        local height = CONSTANTS.CARD_HEIGHT
        local onClickFunc = (
            function (self)
                if self.selected then
                    self.selected = false
                    self.y = CONSTANTS.HAND_Y
                else
                    self.selected = true
                    self.y = CONSTANTS.HAND_Y - 200
                end
            end
        )

        local card_base = GameState:getRandomCard()
        local card = Drawable:new(x, y, width, height):Card(card_base, onClickFunc)
        Scenes:addDrawable(Scenes:getScene("game-main"), id, z_index, card)
    end
end

---returns a random card base
---@return CardBase
function GameState:getRandomCard()
    local cards = {}

    for _, image in pairs(card_list.cards) do
        table.insert(cards, image)
    end

    local rndIndex = math.random(#cards)

    return cards[rndIndex]
end

return GameState