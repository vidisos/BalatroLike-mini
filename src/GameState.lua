local Scenes = require "src.Scenes"
local Drawable = require "src.Drawable"
local CONSTANTS = require "src.CONSTANTS"
local card_list = require "src.card_list"
local Utils     = require "src.Utils"
local hand_rankings = require "src.hand_rankings"

local GameState = {
    --should be constants but uh ehe
    hand_size = 8,
    deck_size = 52,

    --level info
    level = 1,
    score_requirement = 100,

    --dynamic stuff
    current_lang = "en",
    timer = 0,

    deck_bases = {},

    score = 0,

    selected_hand = nil;
    active_card_items = {};
    chips = 0,
    mult = 0,

    hands_remaining = 4,
    discards_remaining = 3,
    selected_cards_count = 0,
    selected_max = 5,

    deck_count = 0
}

---resets everything about the score, current cards and stuff
function GameState:startNewRound()
    self.score = 0
    self.hands_remaining = 4
    self.discards_remaining = 999
    self.selected_hand = nil
    self.selected_cards_count = 0
    self:refreshChipsAndMult()

    self:makeNewDeck()
    self:makeNewHand()
    self:refreshHand()

    --Scenes:enableScene("game-won")
end

---creates the amount of cards that should be in the whole deck (usually 52) and places them there
function GameState:makeNewDeck()
    self:clearCards()
    self.deck_count = 0
    self.deck_bases = GameState:getNewDeckBases()

    for i=1, self.deck_size do
        local id = "card-" .. i
        local z_index = 10 + i

        local x = CONSTANTS.DECK_X + i*0.15
        local y = CONSTANTS.DECK_Y - CONSTANTS.CARD_HEIGHT - i*0.60
        local width = CONSTANTS.CARD_WIDTH
        local height = CONSTANTS.CARD_HEIGHT
        local onClickFunc = self.cardOnClickFunc
        local updateFunc = self.updateCardInHandFunc

        local card_base = self:getRandomCardBase()

        local card = Drawable:new(id, z_index, x, y, width, height, updateFunc):Card(card_base, onClickFunc)
        card.inDeck = true
        card.inHand = false
        card.flipped = true

        Scenes:addDrawable(Scenes:getScene("game-main"), card)

        self.deck_count = self.deck_count + 1
    end
end

---moves cards from the deck to the hand
function GameState:makeNewHand()
    for i=1, self.hand_size do
        local id = "card-" .. (self.deck_size - (i-1))
        ---@type Card|Drawable
        local card = Scenes:getDrawable("game-main", id)

        local spacing = ((i-1) * (CONSTANTS.HAND_WIDTH - CONSTANTS.CARD_WIDTH) / (self.hand_size - 1))
        card.x = CONSTANTS.HAND_X + spacing
        card.y = CONSTANTS.HAND_Y
        card.flipped = false
        card.inDeck = false
        card.inHand = true
        card.displayIndex = i

        card.z_index = card.displayIndex

        self.deck_count = self.deck_count - 1
    end
end

---plays the selected cards
function GameState:playHand()
    if self.hands_remaining <= 0 then
        return
    end

    for _, card in ipairs(self.active_card_items) do
        self.chips = self.chips + card.chips
    end

    self.score = self.score + (self.chips * self.mult)

    self:discardCards()

    self.hands_remaining = self.hands_remaining - 1

    if self.score >= self.score_requirement then
        self:gameWon()
    elseif self.hands_remaining == 0 then
        self:gameOver()
    end
end

---discards and changes the discard count accordingly
function GameState:discard()
    if self.discards_remaining <= 0 then
        return
    end

    local discarded_drawables = self:discardCards()

    if #discarded_drawables > 0 then
        self.discards_remaining = self.discards_remaining - 1
    end
end

---discard currently selected cards and moves in new ones from the deck
---@return Drawable|Card[]
function GameState:discardCards()
    -- we need to iterate backwards otherwise it doesnt remove properly(the index moves and stuff)
    local scene = Scenes:getScene("game-main")
    local selected_cards = self:getSelectedHandCards()
    local discarded_drawables = {}

    for i = #scene.drawables, 1, -1 do
        local drawable = scene.drawables[i]
        for _, card in ipairs(selected_cards) do
            if drawable.id == card.id then
                table.insert(discarded_drawables, drawable)
                table.remove(scene.drawables, i)
            end
        end
    end

    -- replacing old cards with the new
    for i=1, #discarded_drawables do
        if self.deck_count <= 0 then
            break
        end

        ---@type Card|Drawable
        local card = self:getTopCardInDeck()

        local spacing = ((i-1) * (CONSTANTS.HAND_WIDTH - CONSTANTS.CARD_WIDTH) / (self.hand_size - 1))
        card.x = CONSTANTS.HAND_X + spacing
        card.y = CONSTANTS.HAND_Y
        card.inHand = true
        card.inDeck = false
        card.flipped = false

        self.deck_count = self.deck_count - 1
    end

    self:refreshHand()
    self.selected_cards_count = 0
    self.selected_hand = nil
    self:refreshChipsAndMult()

    return discarded_drawables
end

---goes to the game over screen and stuff
function GameState:gameOver()
    Scenes:enableScene("game-over")
    Scenes:disableSceneClicks("game-main")
end

---resets the cards and shows the spark select
function GameState:gameWon()
    GameState:clearCards()
    GameState:makeNewDeck()

    Scenes:enableScene("game-won")
    Scenes:disableSceneClicks("game-main")
end

---checks the current ranking of the selected cards and changes all behaviour accordingly
function GameState:checkHandRanking()
    local cards = self:getSelectedHandCards()
    table.sort(cards, function(a, b) return a.rank > b.rank end)

    local highest_rank_card = {}

    local rank_diff = 0
    local is_consecutive = true
    local is_same_suit = false
    local had_same_suit = false

    -- can be three and four of a kind too but uh ye idk
    local first_pair_items = {}
    local first_pair_found = false
    local start_second_pair_search = false
    local second_pair_items = {}

    local previous_card

    for i, card in ipairs(cards) do
        -- high card
        if i == 1 then
            highest_rank_card = card
        else
            if card.rank > highest_rank_card.rank then
                highest_rank_card = card
            end
        end

        -- previous card definition
        if i ~= 1 then
            previous_card = cards[i-1]
        else
            previous_card = card
        end

        -- flush
        if not had_same_suit and previous_card.suit == card.suit then
            is_same_suit = true
            had_same_suit = true
        elseif previous_card.suit ~= card.suit then
            is_same_suit = false
        end

        -- straight
        rank_diff = previous_card.rank - card.rank

        if i ~= 1 then
            if is_consecutive and rank_diff ~= 1 then
                is_consecutive = false
            end
        end

        -- n of a kind checks
        if i ~= 1 then
            -- checking for the first instance of a pair, three of a kind...
            if rank_diff == 0 and not start_second_pair_search then
                if #first_pair_items == 0 then
                    table.insert(first_pair_items, previous_card)
                end
                table.insert(first_pair_items, card)
                first_pair_found = true
            elseif rank_diff ~= 0 and first_pair_found then
                start_second_pair_search = true
            end

            -- if we found the end of the first one we check for pairs again
            if rank_diff == 0 and start_second_pair_search then
                if #second_pair_items == 0 then
                    table.insert(second_pair_items, previous_card)
                end
                table.insert(second_pair_items, card)
            end
        end
    end

    self.active_card_items = {}

    if  #cards==5 and is_same_suit and is_consecutive and cards[1].rank == 14 then
        self.selected_hand = "royal_flush"
        self.active_card_items = cards
    elseif #cards==5 and is_same_suit and is_consecutive then
        self.selected_hand = "straight_flush"
        self.active_card_items = cards
    elseif #first_pair_items == 4 then
        self.selected_hand = "four_of_a_kind"
        Utils.insertFromUnpackedTable(self.active_card_items, first_pair_items)
    elseif (#first_pair_items == 3 and #second_pair_items == 2) or (#first_pair_items == 2 and #second_pair_items == 3) then
        self.selected_hand = "full_house"
        Utils.insertFromUnpackedTable(self.active_card_items, first_pair_items)
        Utils.insertFromUnpackedTable(self.active_card_items, second_pair_items)
    elseif #cards==5 and is_same_suit then
        self.selected_hand = "flush"
        self.active_card_items = cards
    elseif #cards==5 and is_consecutive then
        self.selected_hand = "straight"
        self.active_card_items = cards
    elseif (#first_pair_items==3 and #second_pair_items==0) then
        self.selected_hand = "three_of_a_kind"
        Utils.insertFromUnpackedTable(self.active_card_items, first_pair_items)
    elseif (#first_pair_items == 2 and #second_pair_items == 2) then
        self.selected_hand = "two_pair"
        Utils.insertFromUnpackedTable(self.active_card_items, first_pair_items)
        Utils.insertFromUnpackedTable(self.active_card_items, second_pair_items)
    elseif (#first_pair_items == 2 and #second_pair_items == 0) then
        self.selected_hand = "pair"
        Utils.insertFromUnpackedTable(self.active_card_items, first_pair_items)
    elseif #cards > 0 then
        self.selected_hand = "high_card"
        table.insert(self.active_card_items, highest_rank_card)
    else
        self.selected_hand = nil
    end

    self:refreshChipsAndMult()
end

---refreshes the base chips and mult according to the current hand
function GameState:refreshChipsAndMult()
    if not self.selected_hand then
        self.chips = 0
        self.mult = 0
        return
    end

    local hand_info = hand_rankings[self.selected_hand]
    self.chips = hand_info.chips
    self.mult = hand_info.mult
end

---sorts all the cards in the hand by their rank and changes their display index accordingly
function GameState:refreshHand()
    local hand_cards = self:getHandCards()
    table.sort(hand_cards, function (a, b) return a.rank > b.rank end)

    for i, drawable in ipairs(hand_cards) do
        drawable.displayIndex = i
        drawable.z_index = drawable.displayIndex + 10
    end

    Scenes:sortDrawables(Scenes:getScene("game-main"))
end

---deletes all the normal cards
function GameState:clearCards()
    local scene = Scenes:getScene("game-main")

    -- we need to iterate backwards otherwise it doesnt remove properly(the index moves and stuff)
    for i = #scene.drawables, 1, -1 do

        local drawable = scene.drawables[i]
        if drawable.type == "Card" then
            table.remove(scene.drawables, i)
        end
    end
end

---gets all the card drawable items in the hand
---@return Card[]
function GameState:getHandCards()
    local card_items = {}

    for _, drawable in ipairs(Scenes:getScene("game-main").drawables) do
        if drawable.type == "Card" and drawable.inHand then
            table.insert(card_items, drawable)
        end
    end

    return card_items
end

---gets all the card drawable items of the selected cards in the hand
---@return Card[]
function GameState:getSelectedHandCards()
    local card_list = {}

    for _, drawable in ipairs(Scenes:getScene("game-main").drawables) do
        if drawable.type == "Card" and drawable.selected then
            table.insert(card_list, drawable)
        end
    end

    return card_list
end

---gets the top card in the deck (highest id / z-index), not a copy
---@return Drawable
function GameState:getTopCardInDeck()
    local deck_cards = {}

    for _, drawable in ipairs(Scenes:getScene("game-main").drawables) do
        if drawable.type == "Card" and drawable.inDeck then
            table.insert(deck_cards, drawable)
        end
    end

    table.sort(deck_cards, function (a, b) return a.z_index > b.z_index end)

    return Scenes:getDrawable("game-main", deck_cards[1].id)
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
function GameState:getNewDeckBases()
    local card_bases = {}

    for _, card_base in pairs(Utils.copyTable(card_list.cards)) do
        table.insert(card_bases, card_base)
    end

    return card_bases
end

---alternates between slovenian and english
function GameState:changeLang()
    if (self.current_lang == "en") then
        self.current_lang = "sl"
    else
        self.current_lang = "en"
    end
end

-- card functions
function GameState.updateCardInHandFunc(self, dt)
    if self.inHand then
        local spacing = ((self.displayIndex-1) * ((CONSTANTS.HAND_WIDTH - CONSTANTS.CARD_WIDTH) / (#GameState:getHandCards() - 1)))
        self.x = CONSTANTS.HAND_X + spacing
    end
end

function GameState.cardOnClickFunc(self)
    -- if its in deck it cant be clicked
    if self.inDeck then
        return
    end

    if self.selected then
        self.selected = false
        self.y = CONSTANTS.HAND_Y
        GameState.selected_cards_count = GameState.selected_cards_count - 1
        GameState:checkHandRanking()
    elseif GameState.selected_cards_count < GameState.selected_max then
        self.selected = true
        self.y = CONSTANTS.HAND_Y - 70
        GameState.selected_cards_count = GameState.selected_cards_count + 1
        GameState:checkHandRanking()
    end
end


return GameState