local Scenes = require "Scenes"
local Drawable = require "Drawable"
local CONSTANTS = require "CONSTANTS"
local card_list = require "card_list"
local Card      = require "Card"
local Utils     = require "Utils"

local GameState = {
    --should be constants but uh ehe
    hand_size = 8,
    deck_size = 52,

    --level info
    level = 1,
    score_requirement = 600,

    --dynamic stuff
    current_lang = "sl",
    timer = 0,

    deck_bases = {},

    score = 0,

    selected_hand = "Pair";
    chips = 0,
    mult = 0,

    hands_remaining = 4,
    discards_remaining = 3,

    deck_count = 0
}

---resets everything about the score, curretn cards and stuff
function GameState:startNewRound()
    self.hands_remaining = 4
    self.discards_remaining = 3

    self:makeNewDeck()
    self:makeNewHand()
    self:refreshHand()
end

---creates the amount of cards that should be in the whole deck (usually 52) and places them there
function GameState:makeNewDeck()
    self:clearCards()
    self.deck_count = 0
    self.deck_bases = GameState:makeNewDeckBases()

    for i=1, self.deck_size do
        local id = "card-" .. i
        local z_index = 10 + i

        local spacing = ((i-1) * (CONSTANTS.DECK_HEIGHT - CONSTANTS.CARD_HEIGHT) / (self.deck_size - 1))
        local x = CONSTANTS.DECK_X + i*0.15
        local y = CONSTANTS.DECK_Y - CONSTANTS.CARD_HEIGHT - spacing
        local width = CONSTANTS.CARD_WIDTH
        local height = CONSTANTS.CARD_HEIGHT
        local onClickFunc = self.cardOnClickFunc
        local updateFunc = self.updateCardInHandFunc

        local card_base = self:getRandomCardBase()

        local card = Drawable:new(x, y, width, height, updateFunc):Card(card_base, onClickFunc)
        card.inDeck = true
        card.inHand = false
        card.flipped = true

        Scenes:addDrawable(Scenes:getScene("game-main"), id, z_index, card)

        self.deck_count = self.deck_count + 1
    end
end

---moves cards from the deck to the hand
function GameState:makeNewHand()
    for i=1, self.hand_size do
        local id = "card-" .. (self.deck_size - (i-1))
        local card_item = Scenes:getDrawableItem("game-main", id)

        ---@class Card
        local card = card_item.drawable

        local spacing = ((i-1) * (CONSTANTS.HAND_WIDTH - CONSTANTS.CARD_WIDTH) / (self.hand_size - 1))
        card.x = CONSTANTS.HAND_X + spacing
        card.y = CONSTANTS.HAND_Y
        card.flipped = false
        card.inDeck = false
        card.inHand = true
        card.displayIndex = i

        card_item.z_index = card.displayIndex

        self.deck_count = self.deck_count - 1
    end
end

---returns a random card base from the current deck
---@return CardBase
function GameState:getRandomCardBase()
    local rndIndex = math.random(#self.deck_bases)

    local card_base = self.deck_bases[rndIndex]

    table.remove(self.deck_bases, rndIndex)

    return card_base
end

---returns a random card base from the current deck
---@return CardBase[]
function GameState:makeNewDeckBases()
    local card_bases = {}

    for _, card_base in pairs(Utils.copyTable(card_list.cards)) do
        table.insert(card_bases, card_base)
    end

    return card_bases
end

---deletes all the normal cards
function GameState:clearCards()
    local scene = Scenes:getScene("game-main")

    -- we need to iterate backwards otherwise it doesnt remove properly(the index moves and stuff)
    for i = #scene.drawables, 1, -1 do

        local item = scene.drawables[i]
        if item.drawable.type == "Card" then
            table.remove(scene.drawables, i)
        end
    end
end

---gets all the card drawable items in the hand
---@return DrawableItem
function GameState:getHandCards()
    local card_items = {}

    for _, item in ipairs(Scenes:getScene("game-main").drawables) do
        if item.drawable.type == "Card" and item.drawable.inHand then
            table.insert(card_items, item)
        end
    end

    return card_items
end

---gets all the card drawableitems of the selected cards in the hand
---@return DrawableItem
function GameState:getSelectedHandCards()
    local card_list = {}

    for _, item in ipairs(Scenes:getScene("game-main").drawables) do
        if item.drawable.type == "Card" and item.drawable.selected then
            table.insert(card_list, item)
        end
    end

    return card_list
end

---discard currently selected cards and moves in new ones from the deck
function GameState:discard()
    if self.discards_remaining <= 0 then
        return
    end

    -- we need to iterate backwards otherwise it doesnt remove properly(the index moves and stuff)
    local scene = Scenes:getScene("game-main")
    local selected_cards = self:getSelectedHandCards()
    local discarded_items = {}

    for i = #scene.drawables, 1, -1 do
        local item = scene.drawables[i]
        for _, card in ipairs(selected_cards) do
            if item.id == card.id then
                table.insert(discarded_items, item)
                table.remove(scene.drawables, i)
            end
        end
    end

    -- replacing old cards with the new
    for i=1, #discarded_items do
        local item = self:getTopCardInDeck()
        ---@type Card
        local card = item.drawable

        local spacing = ((i-1) * (CONSTANTS.HAND_WIDTH - CONSTANTS.CARD_WIDTH) / (self.hand_size - 1))
        card.x = CONSTANTS.HAND_X + spacing
        card.y = CONSTANTS.HAND_Y
        card.inHand = true
        card.inDeck = false
        card.flipped = false

        self.deck_count = self.deck_count - 1
    end

    self:refreshHand()

    if #discarded_items > 0 then
        self.discards_remaining = self.discards_remaining - 1
    end
end

---sorts all the cards in the hand by their rank and changes their display index accordingly
function GameState:refreshHand()
    local hand_cards = self:getHandCards()
    table.sort(hand_cards, function (a, b) return a.drawable.rank > b.drawable.rank end)

    for i, item in ipairs(hand_cards) do
        item.drawable.displayIndex = i
        item.z_index = item.drawable.displayIndex + 10
    end

    Scenes:sortDrawables(Scenes:getScene("game-main"))
end

---gets the top card in the deck (highest id / z-index)
---@return DrawableItem
function GameState:getTopCardInDeck()
    local deck_cards = {}

    for _, item in ipairs(Scenes:getScene("game-main").drawables) do
        if item.drawable.type == "Card" and item.drawable.inDeck then
            table.insert(deck_cards, item)
        end
    end

    table.sort(deck_cards, function (a, b) return a.z_index > b.z_index end)

    return Scenes:getDrawableItem("game-main", deck_cards[1].id)
end


function GameState.updateCardInHandFunc(self, dt)
    if self.inHand then
        local spacing = ((self.displayIndex-1) * ((CONSTANTS.HAND_WIDTH - CONSTANTS.CARD_WIDTH) / (#GameState:getHandCards() - 1)))
        self.x = CONSTANTS.HAND_X + spacing
    end
end

function GameState.cardOnClickFunc(self)
    if self.inDeck then
        self.isClickable = false
        return
    else
        self.isClickable = true
    end

    if self.selected then
        self.selected = false
        self.y = CONSTANTS.HAND_Y
    else
        self.selected = true
        self.y = CONSTANTS.HAND_Y - 70
    end
end


return GameState