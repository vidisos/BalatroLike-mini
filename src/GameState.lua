local Scenes = require "src.Scenes"
local Drawable = require "src.Drawable"
local CONSTANTS = require "src.constants"
local card_list = require "src.card_list"
local spark_list = require "src.spark_list"
local Utils = require "src.Utils"
local hand_rankings = require "src.hand_rankings"
local LANG = require "src.LANG"
local Font = require "src.Font"
local Color= require "src.Color"

---@class GameState
local GameState = {
    --should be CONSTANTS but uh ehe
    hand_size = 8,
    deck_size = 52,
    spark_active_max = 5,
    base_hands_remaining_max = 4,
    base_discards_remaining_max = 3,

    --level info
    level = 1,
    score_requirement = 50,

    --dynamic stuff
    current_lang = "en",
    timer = 0,
    time_elapsed = 0,
    player_on_win_screen = false;

    deck_bases = {},

    score = 0,

    selected_hand = nil,
    selected_hand_contains = {},
    active_cards = {},

    active_sparks_count = 0,
    spark_select_max = 5,
    spark_type_counts = {}, --counts the number of a specific type of spark, so we can have duplicates

    chips = 0,
    mult = 0,

    active_hands_remaining_max = 0,
    hands_remaining = 0,
    active_discards_remaining_max = 0,
    discards_remaining = 0,
    selected_cards_count = 0,
    selected_max = 5,

    deck_count = 0
}

function GameState:startNewGame()
    self:resetGameState()
    self:startNewRound()
end

---resets everything about the score, current cards and stuff, clears all the elements and makes new ones
function GameState:startNewRound()
    self:resetRoundState()
    self:clearSelectionSparks()
    self:clearSparks()
    self:makeNewDeck()
    self:makeNewHand()
    self:refreshHand()
end

---plays the selected cards
function GameState:playHand()
    if self.hands_remaining <= 0 then
        return
    end

    GameState:checkHandRanking()
    local sparks = self:getActiveSparks()

    for _, card in ipairs(self.active_cards) do
        self.chips = self.chips + card.chips

        --per card spark activations
        for _, spark in ipairs(sparks) do
            if spark.activation_type == "per-card" then
                spark:effect(GameState, card)
            end
        end
    end

    -- per hand hand spark activations
    for _, spark in ipairs(sparks) do
        if spark.activation_type == "end-of-hand" then
            spark:effect(GameState)
        end
    end

    self.score = self.score + (self.chips * self.mult)

    self:discardCards()

    self.hands_remaining = self.hands_remaining - 1

    if self.score >= self.score_requirement then
        self:roundWon()
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

    self.selected_hand = nil
    self.selected_hand_contains = {}
    self:refreshChipsAndMult()

    if #discarded_drawables > 0 then
        self.discards_remaining = self.discards_remaining - 1
    end
end

---goes to the game over screen and stuff
function GameState:gameOver()
    Scenes:enableScene("game-over")
    Scenes:disableSceneClicks("game-main")
end

---resets the cards and shows the spark select
function GameState:roundWon()
    self.level = self.level + 1
    self.player_on_win_screen = true

    -- we dont want the max counts to show only after selecting a spark, so they can more easily see if they need certain sparks and stuff
    self.hands_remaining = self.active_hands_remaining_max
    self.discards_remaining = self.active_discards_remaining_max

    self:clearCards()
    self:makeNewDeck()

    -- we dont want two duplicates to show up in the selection, we dont care about duplicates in the active play tho
    local temp_sparks = self:getNewSparkBases()

    local game_win_background = Scenes:getDrawable("game-won", "rect-background")
    for i=1, self.spark_select_max do
        local z_index = i

        local x_margin = 100
        local spacing = x_margin + ((i-1) * (game_win_background.width - CONSTANTS.CARD_WIDTH - 2*x_margin) / (self.spark_select_max - 1))
        local x = game_win_background.x + spacing
        local y = game_win_background.y + 100
        local width = CONSTANTS.CARD_WIDTH
        local height = CONSTANTS.CARD_HEIGHT

        local rnd = math.random(1, #temp_sparks)
        local spark_base = temp_sparks[rnd]
        table.remove(temp_sparks, rnd)

        local id = self:nextSparkID(spark_base)

        local spark = Drawable:new(id, z_index, x, y, width, height, self.updateActiveSparkFunc):Spark(spark_base, self.sparkOnClickFunc)
        spark.onEnterHoverFunc = self.showSparkInfo
        spark.onExitHoverFunc = self.disableSparkInfo

        Scenes:addDrawable("game-won", spark)
    end

    Scenes:enableScene("game-won")
end

--deletes all sparks on win screen and gets rid of win screen overlay
function GameState:moveToNextRound()
    self:clearSelectionSparks()
    self:resetRoundState()

    Scenes:disableScene("game-won")
    self:makeNewHand()
    self:refreshHand()
end

---resets the hand and discard counts to base values for a new game
function GameState:resetGameState()
    self.player_on_win_screen = false

    self.active_hands_remaining_max = self.base_hands_remaining_max
    self.active_discards_remaining_max = self.base_discards_remaining_max

    self.hands_remaining = self.active_hands_remaining_max
    self.discards_remaining = self.active_discards_remaining_max

    self:resetRoundState()
end

---resets the score, hand and discard counts and stuff for a new round
function GameState:resetRoundState()
    self.player_on_win_screen = false
    self.score = 0
    self:resetHandDiscardCount()
    self.selected_hand = nil
    self.selected_hand_contains = {}
    self.selected_cards_count = 0
    self:refreshChipsAndMult()
end

---resets the hand and discard counts
function GameState:resetHandDiscardCount()
    self.hands_remaining = self.active_hands_remaining_max
    self.discards_remaining = self.active_discards_remaining_max
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

    Scenes:sortDrawables("game-main")
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
        card.onEnterHoverFunc = self.showCardInfo
        card.onExitHoverFunc = self.disableCardInfo

        Scenes:addDrawable("game-main", card)

        self.deck_count = self.deck_count + 1
    end
end

---moves cards from the deck to the hand
function GameState:makeNewHand()
    for i=1, self.hand_size do
        local card = self:getTopCardInDeck()

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

---discard currently selected cards and moves in new ones from the deck, returns the discarded cards
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

    return discarded_drawables
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

    self.active_cards = {}

    if #cards==5 and is_same_suit and is_consecutive and cards[1].rank == 14 then
        self.selected_hand = "royal_flush"
        self.active_cards = cards

        table.insert(self.selected_hand_contains, "flush")
        table.insert(self.selected_hand_contains, "straight")
    elseif #cards==5 and is_same_suit and is_consecutive then
        self.selected_hand = "straight_flush"
        self.active_cards = cards

        table.insert(self.selected_hand_contains, "flush")
        table.insert(self.selected_hand_contains, "straight")
    elseif #first_pair_items == 4 then
        self.selected_hand = "four_of_a_kind"
        Utils.insertFromUnpackedTable(self.active_cards, first_pair_items)

        table.insert(self.selected_hand_contains, "four_of_a_kind")
        table.insert(self.selected_hand_contains, "three_of_a_kind")
        table.insert(self.selected_hand_contains, "pair")
    elseif (#first_pair_items == 3 and #second_pair_items == 2) or (#first_pair_items == 2 and #second_pair_items == 3) then
        self.selected_hand = "full_house"
        Utils.insertFromUnpackedTable(self.active_cards, first_pair_items)
        Utils.insertFromUnpackedTable(self.active_cards, second_pair_items)

        table.insert(self.selected_hand_contains, "full_house")
        table.insert(self.selected_hand_contains, "three_of_a_kind")
        table.insert(self.selected_hand_contains, "pair")
    elseif #cards==5 and is_same_suit then
        self.selected_hand = "flush"
        self.active_cards = cards

        table.insert(self.selected_hand_contains, "flush")
    elseif #cards==5 and is_consecutive then
        self.selected_hand = "straight"
        self.active_cards = cards

        table.insert(self.selected_hand_contains, "straight")
    elseif #first_pair_items==3 and #second_pair_items==0 then
        self.selected_hand = "three_of_a_kind"
        Utils.insertFromUnpackedTable(self.active_cards, first_pair_items)

        table.insert(self.selected_hand_contains, "three_of_a_kind")
        table.insert(self.selected_hand_contains, "pair")
    elseif #first_pair_items == 2 and #second_pair_items == 2 then
        self.selected_hand = "two_pair"
        Utils.insertFromUnpackedTable(self.active_cards, first_pair_items)
        Utils.insertFromUnpackedTable(self.active_cards, second_pair_items)

        table.insert(self.selected_hand_contains, "two_pair")
        table.insert(self.selected_hand_contains, "pair")
    elseif #first_pair_items == 2 and #second_pair_items == 0 then
        self.selected_hand = "pair"
        Utils.insertFromUnpackedTable(self.active_cards, first_pair_items)

        table.insert(self.selected_hand_contains, "pair")
    elseif #cards > 0 then
        self.selected_hand = "high_card"
        table.insert(self.active_cards, highest_rank_card)

        table.insert(self.selected_hand_contains, "high_card")
    else
        self.selected_hand = nil
        self.selected_hand_contains = {}
    end

    self:refreshChipsAndMult()
end

---checks if teh curretn selected hand contains an input hand
---@param hand_input string
---@return boolean
function GameState:handContains(hand_input)
    for _, hand in ipairs(self.selected_hand_contains) do
        if hand == hand_input then
            return true
        end
    end

    return false
end

---inserts the chosen spark into the active sparks
---@param spark Spark|Drawable
function GameState:selectSpark(spark)
    spark.isActive = true
    spark.y = CONSTANTS.SPARKS_Y
    spark.z_index = 3 + #GameState:getActiveSparks()
    spark.displayIndex = #GameState:getActiveSparks() + 1

    Scenes:addDrawable("game-main", spark)

    if spark.activation_type == "passive" then
        spark:effect(GameState)
    end
end

---deletes all sparks on the main scene (and their delete buttons if needed)
function GameState:clearSparks()
    local scene = Scenes:getScene("game-main")

    -- we need to iterate backwards otherwise it doesnt remove properly(the index moves and stuff)
    for i = #scene.drawables, 1, -1 do

        local drawable = scene.drawables[i]
        if drawable.type == "Spark" then
            self:removeSpark(drawable)
        elseif string.sub(drawable.id, -3) == "btn" then
            table.remove(scene.drawables, i)
        end
    end
end

---deletes all sparks on the win screen
function GameState:clearSelectionSparks()
    local scene = Scenes:getScene("game-won")

    -- we need to iterate backwards otherwise it doesnt remove properly(the index moves and stuff)
    for i = #scene.drawables, 1, -1 do

        local drawable = scene.drawables[i]
        if drawable.type == "Spark" then
            table.remove(scene.drawables, i)
        end
    end
end

---return all sparks on game-main
---@return Spark|Drawable[]
function GameState:getActiveSparks()
    local sparks = {}

    for _, drawable in ipairs(Scenes:getScene("game-main").drawables) do
        if drawable.type == "Spark" then
            table.insert(sparks, drawable)
        end
    end

    return sparks
end

---refreshes the display and z indexes of the active sparks (in case of deletion)
function GameState:refreshActiveSparks()
    local active_sparks = self:getActiveSparks()
    for i, spark in ipairs(active_sparks) do
        spark.displayIndex = i
        spark.z_index = 3 + i
    end
end

---removes a spark and reverts any passive effects
function GameState:removeSpark(spark)
    if spark.isActive and spark.deactivate then
        spark:deactivate(GameState)
        self:resetHandDiscardCount()
    end

    Scenes:removeDrawable("game-main", spark.id)
    GameState:refreshActiveSparks()
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

---gets all the selected cards in the hand
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

---gets the top card in the deck (z-index), not a copy
---@return Card|Drawable
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

---returns a random card base from the current deck and removes it
---@return CardBase
function GameState:getRandomCardBase()
    local rndIndex = math.random(#self.deck_bases)

    local card_base = self.deck_bases[rndIndex]

    table.remove(self.deck_bases, rndIndex)

    return card_base
end

---returns a full deck of card bases
---@return CardBase[]
function GameState:getNewDeckBases()
    local card_bases = {}

    for _, card_base in pairs(Utils.copyTable(card_list)) do
        table.insert(card_bases, card_base)
    end

    return card_bases
end

---returns all spark bases
---@return SparkBase[]
function GameState:getNewSparkBases()
    local spark_bases = {}

    for _, spark_base in pairs(Utils.copyTable(spark_list)) do
        table.insert(spark_bases, spark_base)
    end

    return spark_bases
end

---alternates between slovenian and english
function GameState:changeLang()
    if (self.current_lang == "en") then
        self.current_lang = "sl"
    else
        self.current_lang = "en"
    end
end

---returns the number of items that use the spark base
---@param spark_base SparkBase
---@return number
function GameState:getSparkTypeCount(spark_base)
    local base_id = spark_base.id
    local count = 0

    for _, scene in ipairs(Scenes.scene_list) do
        for _, drawable in ipairs(scene.drawables) do
            if base_id == string.sub(drawable.id, 0, #base_id) then
                count = count + 1
            end
        end
    end

    return count
end

-- card functions
function GameState.updateCardInHandFunc(self, dt)
    if self.inHand then
        local spacing = ((self.displayIndex-1) * ((CONSTANTS.HAND_WIDTH - CONSTANTS.CARD_WIDTH) / (#GameState:getHandCards() - 1)))
        self.x = CONSTANTS.HAND_X + spacing
    end
end

---creates new drawables that represent the hovered card
---@param self Card|Drawable
function GameState.showCardInfo(self)
    if self.inHand then
        local card_id = self.id
        local info_x = self.x
        local info_y = self.y - 120
        local info_width = self.width
        local info_height = 100

        ---@type Drawable
        local background = Drawable:new(
            self.id.."infoBoxBack", self.z_index + GameState.hand_size,
            info_x, info_y, info_width, info_height,
            function (self)
                local card = Scenes:getDrawable("game-main", card_id)
                self.x = card.x
                self.y = card.y - 120
            end
        ):Rectangle(Color.dark_grey, 3, {1, 1, 1})

        ---@type Drawable
        local title = Drawable:new(
            self.id.."infoBoxTitle", self.z_index + GameState.hand_size + 1,
            info_x+7, info_y+7, info_width-14, info_height - 62,
            function (self)
                local infoBox = Scenes:getDrawable("game-main", card_id.."infoBoxBack")
                self.x = infoBox.x+7
                self.y = infoBox.y+7
            end
        ):TextBox(
            self.title, Font:resizeFont(Font.font_paths.pixel_font, 14),
            nil, {1, 1, 1}
        )

        ---@type Drawable
        local desc = Drawable:new(
            self.id.."infoBoxDesc", self.z_index + GameState.hand_size + 1,
            info_x+7, info_y-7 + 60, info_width-14, info_height - 60,
            function (self)
                local infoBox = Scenes:getDrawable("game-main", card_id.."infoBoxBack")
                self.x = infoBox.x +7
                self.y = infoBox.y + 60 -7
            end
        ):TextBox(
            {{0, 0, 1}, "+"..self.chips, Color.black, " "..LANG.chips[GameState.current_lang]}, Font:resizeFont(Font.font_paths.pixel_font, 15),
            nil, {1, 1, 1}
        )

        Scenes:addDrawable("game-main", background)
        Scenes:addDrawable("game-main", title)
        Scenes:addDrawable("game-main", desc)
        Scenes:sortDrawables("game-main")
    end
end

function GameState.disableCardInfo(self)
    Scenes:removeDrawable("game-main", self.id.."infoBoxBack")
    Scenes:removeDrawable("game-main", self.id.."infoBoxTitle")
    Scenes:removeDrawable("game-main", self.id.."infoBoxDesc")
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

---increments the number of a certain type of spark and return the next id
---@param spark_base SparkBase
---@return string
function GameState:nextSparkID(spark_base)
    local base_id = spark_base.id

    self.spark_type_counts[base_id] = (self.spark_type_counts[base_id] or 0) + 1

    return base_id .. self.spark_type_counts[base_id]
end

---creates new drawables that represent the hovered spark
---@param self Spark|Drawable
function GameState.showSparkInfo(self)
    local spark_id = self.id

    local info_x = self.x
    local info_y = self.y + CONSTANTS.CARD_HEIGHT + 10
    local info_width = self.width
    local info_height = 140

    ---@type Drawable
    local background = Drawable:new(
        self.id.."infoBoxBack", self.z_index + GameState.active_sparks_count,
        info_x, info_y, info_width, info_height,
        function (self)
            ---@type Spark|Drawable
            local spark = Scenes:getDrawableGlobal(spark_id)

            self.x = spark.x
            self.y = spark.y + CONSTANTS.CARD_HEIGHT + 10
        end
    ):Rectangle(Color.dark_grey, 3, {1, 1, 1})

    ---@type Drawable
    local title = Drawable:new(
        self.id.."infoBoxTitle", self.z_index + GameState.active_sparks_count + 1,
        info_x+7, info_y+7, info_width-14, 45,
        function (self)
            local infoBox = Scenes:getDrawableGlobal(spark_id.."infoBoxBack")
            self.x = infoBox.x+7
            self.y = infoBox.y+7
        end
    ):TextBox(
        self.title, Font:resizeFont(Font.font_paths.pixel_font, 17),
        nil, {1, 1, 1}
    )

    ---@type Drawable
    local desc = Drawable:new(
        self.id.."infoBoxDesc", self.z_index + GameState.active_sparks_count + 1,
        info_x+7, info_y + 65 -7, info_width-14, info_height - 65,
        function (self)
            local infoBox = Scenes:getDrawableGlobal(spark_id.."infoBoxBack")
            self.x = infoBox.x +7
            self.y = infoBox.y + 65 -7
        end
    ):TextBox(
        self.desc, Font:resizeFont(Font.font_paths.pixel_font, 15),
        nil, {1, 1, 1}
    )

    local current_scene = "game-won"

    if self.isActive then
        current_scene = "game-main"
    end

    Scenes:addDrawable(current_scene, background)
    Scenes:addDrawable(current_scene, title)
    Scenes:addDrawable(current_scene, desc)
    Scenes:sortDrawables(current_scene)
end

function GameState.disableSparkInfo(self)
    Scenes:removeDrawableGlobal(self.id.."infoBoxBack")
    Scenes:removeDrawableGlobal(self.id.."infoBoxTitle")
    Scenes:removeDrawableGlobal(self.id.."infoBoxDesc")
end

function GameState.updateActiveSparkFunc(self, dt)
    if self.isActive then
        local active_sparks = GameState:getActiveSparks()
        local N = #active_sparks
        local SW = CONSTANTS.CARD_WIDTH
        local W = CONSTANTS.SPARKS_WIDTH
        local spark_margin = CONSTANTS.SPARKS_MARGIN

        GameState:refreshActiveSparks()
        local display_index = self.displayIndex

        local total_sparks_width = N * SW + 4 * CONSTANTS.SPARKS_MARGIN

        if N <= 5 then
            if display_index == 1 and N == 5 then
                spark_margin = 0
            end

            local start_x = CONSTANTS.SPARKS_X + (W - total_sparks_width) / 2
            self.x = start_x + (display_index - 1) * (SW + spark_margin)
        else
            local spacing = (W - SW) / (N - 1)
            self.x = CONSTANTS.SPARKS_X + (display_index - 1) * spacing
        end
    end
end

---@param self Spark|Drawable
function GameState.sparkOnClickFunc(self)
    -- if the spark is in selection screen
    if not self.isActive then
        if #GameState:getActiveSparks() == GameState.spark_active_max then
            return
        end

        GameState:selectSpark(self)
        GameState:moveToNextRound()
        return
    end

    if not self.selected and GameState.player_on_win_screen then
        local active_sparks = GameState:getActiveSparks()
        for _, spark in ipairs(active_sparks) do
            spark.selected = false
            Scenes:removeDrawable("game-main", spark.id.."btn")
        end

        -- making a spark delete button
        local spark_id = self.id -- so we can use it in the function for the button
        local id = self.id.."btn"
        local z_index = self.z_index
        local width = 100
        local height = 80
        local x = self.x - width
        local y = self.height/2

        local button = Drawable:new(id, z_index, x, y, width, height,
                function (self, dt)
                    local spark_id = string.sub(self.id, 1, -4)
                    local spark = Scenes:getDrawable("game-main", spark_id)
                    self.z_index = spark.z_index
                    self.x = spark.x - width
                end
            ):Button(
            LANG.delete_spark, Font:resizeFont(Font.font_paths.pixel_font, 20),
            nil, nil,
            function (self)
                local spark = Scenes:getDrawable("game-main", spark_id)
                if spark then
                    GameState:removeSpark(spark)
                end
                Scenes:removeDrawable("game-main", self.id)
            end,
            5, {1, 0, 0}
        )

        Scenes:addDrawable("game-main", button)
    else
        Scenes:removeDrawable("game-main", self.id.."btn")
    end

    if GameState.player_on_win_screen then
        self.selected = not self.selected
    end
    Scenes:sortDrawables("game-main")
end

return GameState