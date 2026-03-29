local CONSTANTS = require "src.constants"
local Scenes = require "src.Scenes"
local Drawable  = require "src.Drawable"
local Utils = require "src.Utils"
local Audio = require "src.Audio"
local image_list = require "src.image_list"
local GameState = require "src.GameState"
local Options   = require "src.Options"
local Color     = require "src.Color"
local hand_rankings_list = require "src.hand_rankings_list"
local Rectangle     = require "src.Rectangle"

local LANG = require "src.LANG"
local Font = require "src.Font"

local ww = CONSTANTS.BASE_WIDTH
local wh = CONSTANTS.BASE_HEIGHT

local background_width = 800
local background_height = 800
local background_x = Utils.getCenterAnchorX(0, ww, background_width)
local background_y = Utils.getCenterAnchorY(0, wh, background_height)
local ranking_width = 700
local ranking_height = 60

local rankings_width = ranking_width
local rankings_height = 600
local rankings_x = Utils.getCenterAnchorX(background_x, background_width, rankings_width)
local rankings_y = background_y + 50

local ranking_margin = 10

---@type HandRankings
local HandRankings = {}

HandRankings.id = "hand-rankings"
HandRankings.shouldDraw = false
HandRankings.z_index = 3
HandRankings.drawables = {
    -- background
    Drawable:new(
        "rect-background", 0,
        background_x, background_y, background_width, background_height
    ):Rectangle(
        Color.dark_grey,
        6, Color.light_grey
    ),

    -- back
    Drawable:new(
        "btn-back", 1,
        Utils.getCenterAnchorX(Utils.getCenterAnchorX(0, ww, 800), 800, 700), Utils.getCenterAnchorY(0, wh, 800) + 800 - 60 - 30, 700, 60,
        nil,
        nil,
        function (self) self.color = Color:tintColor(self.base_color, 0.8) end,
        function (self) self.color = self.base_color end
    ):Button(
        LANG.back, Font:resizeFont(Font.font_paths.pixel_font, 30),
        Color.white,
        Color.orange,
        function (self)
            Audio:playSound(Audio.sfx.button_click_back)

            Scenes:enableAllSceneInteractions()
            Scenes:disableScene("hand-rankings")
        end
    ),
}

---draws the rankings on the hand rackings scene in order from highets display index to lowest
function HandRankings:drawRankings()
    -- as they are in the original list but reversed
    local rankings_arrays = Utils.getArray(hand_rankings_list)
    local ranking_count = 0
    table.sort(rankings_arrays, function(a, b) return a.display_index < b.display_index end)

    for _, ranking in ipairs(rankings_arrays) do
        if ranking.key ~= "royal_flush" then
            local background = Drawable:new(
                "rect-"..ranking.key, 1,
                rankings_x, rankings_y + ranking_count*(ranking_height + ranking_margin), ranking_width, ranking_height,
                nil, nil,
                function(self)
                    self.color = Color:tintColor(self.base_color, 0.8)
                    HandRankings.showRankingInfo(self)
                end,
                function(self)
                    self.color = self.base_color 
                    HandRankings.closeRankingInfo(self)
                end
            ):Rectangle(
                Color.light_grey
            )

            local hand_text = Drawable:new(
                "text-"..ranking.key, 2,
                background.x, background.y, 400, background.height
            ):TextBox(
                ranking.title, nil,
                Color.white, nil,
                "left", 10
            )
            -- we need to reapply the font since it would normally take the font size of the lanugae entry
            hand_text.font = Font:resizeFont(Font.font_paths.pixel_font, 30)

            local scoring_background = Drawable:new(
                "rect"..ranking.key, 2,
                background.x + ranking_width - 210,
                Utils.getCenterAnchorY(background.y, background.height, background.height-13),
                200,
                background.height - 13
            ):Rectangle(
                Color.dark_grey
            )

            local chips_mult_height = scoring_background.height - 8
            local chips_mult_y = Utils.getCenterAnchorY(scoring_background.y, scoring_background.height, chips_mult_height)

            local chips_text = Drawable:new(
                "text-chips-"..ranking.key, 3,
                scoring_background.x + 5, chips_mult_y, 80, chips_mult_height
            ):TextBox(
                tostring(ranking.chips), Font:resizeFont(Font.font_paths.pixel_font, 30),
                Color.white, Color.blue,
                "right", -5
            )

            local multiply_sign = Drawable:new(
                "text-multiply-sign"..ranking.key, 3,
                chips_text.x+chips_text.width, chips_mult_y, 30, chips_mult_height
            ):TextBox(
                "X", Font:resizeFont(Font.font_paths.pixel_font, 30),
                Color.white
            )

            local mult_text = Drawable:new(
                "text-mult-"..ranking.key, 3,
                multiply_sign.x+multiply_sign.width, chips_mult_y, 80, chips_mult_height
            ):TextBox(
                tostring(ranking.mult), Font:resizeFont(Font.font_paths.pixel_font, 30),
                Color.white, Color.red,
                "left", 5
            )

            background.ranking = ranking -- so we can access the ranking id later on hover

            hand_text.forceDisableHover = true
            scoring_background.forceDisableHover = true
            chips_text.forceDisableHover = true
            multiply_sign.forceDisableHover = true
            mult_text.forceDisableHover = true
            Scenes:addDrawable("hand-rankings", background)
            Scenes:addDrawable("hand-rankings", hand_text)
            Scenes:addDrawable("hand-rankings", scoring_background)
            Scenes:addDrawable("hand-rankings", chips_text)
            Scenes:addDrawable("hand-rankings", multiply_sign)
            Scenes:addDrawable("hand-rankings", mult_text)

            HandRankings.makeRankingInfo(background, ranking)

            ranking_count = ranking_count + 1
        end
    end

    Scenes:sortDrawables("hand-rankings")
end

function HandRankings.makeRankingInfo(background_drawable, ranking)
    local background_width = 600
    local background_height = 250
    local background_y = background_drawable.y + background_drawable.height
    local cards_info = {}

    -- switching y coords if the ranking is lower down
    if ranking.key == "three_of_a_kind" or ranking.key == "two_pair" or ranking.key == "pair" or ranking.key == "high_card" then
        background_y = background_drawable.y - background_height
    end

    -- changing description text and cards layout according to current ranking
    local desc_text = {}
    if ranking.key == "high_card" then
        desc_text = LANG.high_card_desc
        cards_info = {
            {image = image_list.cards.heart1, isFocused = true},
            {image = image_list.cards.heart13,  isFocused = false},
            {image = image_list.cards.club8,     isFocused = false},
            {image = image_list.cards.heart5,    isFocused = false},
            {image = image_list.cards.club3,     isFocused = false}
        }
    elseif ranking.key == "pair" then
        desc_text = LANG.pair_desc
        cards_info = {
            {image = image_list.cards.heart13,    isFocused = true},
            {image = image_list.cards.spade13,    isFocused = true},
            {image = image_list.cards.diamond8,  isFocused = false},
            {image = image_list.cards.club5,     isFocused = false},
            {image = image_list.cards.heart4,    isFocused = false}
        }
    elseif ranking.key == "two_pair" then
        desc_text = LANG.two_pair_desc
        cards_info = {
            {image = image_list.cards.heart9,    isFocused = true},
            {image = image_list.cards.spade9,    isFocused = true},
            {image = image_list.cards.diamond4,  isFocused = true},
            {image = image_list.cards.club4,     isFocused = true},
            {image = image_list.cards.heart2,    isFocused = false}
        }
    elseif ranking.key == "three_of_a_kind" then
        desc_text = LANG.three_of_a_kind_desc
        cards_info = {
            {image = image_list.cards.heart8,    isFocused = true},
            {image = image_list.cards.diamond8,  isFocused = true},
            {image = image_list.cards.spade8,    isFocused = true},
            {image = image_list.cards.club4,     isFocused = false},
            {image = image_list.cards.heart2,   isFocused = false}
        }
    elseif ranking.key == "straight" then
        desc_text = LANG.straight_desc
        cards_info = {
            {image = image_list.cards.heart9,    isFocused = true},
            {image = image_list.cards.spade8,  isFocused = true},
            {image = image_list.cards.club7,     isFocused = true},
            {image = image_list.cards.diamond6,    isFocused = true},
            {image = image_list.cards.heart5,    isFocused = true}
        }
    elseif ranking.key == "flush" then
        desc_text = LANG.flush_desc
        cards_info = {
            {image = image_list.cards.heart13,    isFocused = true},
            {image = image_list.cards.heart11,    isFocused = true},
            {image = image_list.cards.heart8,    isFocused = true},
            {image = image_list.cards.heart3,   isFocused = true},
            {image = image_list.cards.heart2,   isFocused = true}
        }
    elseif ranking.key == "full_house" then
        desc_text = LANG.full_house_desc
        cards_info = {
            {image = image_list.cards.spade10,   isFocused = true},
            {image = image_list.cards.heart10,   isFocused = true},
            {image = image_list.cards.diamond10, isFocused = true},
            {image = image_list.cards.club3,     isFocused = true},
            {image = image_list.cards.heart3,    isFocused = true}
        }
    elseif ranking.key == "four_of_a_kind" then
        desc_text = LANG.four_of_a_kind_desc
        cards_info = {
            {image = image_list.cards.heart12,   isFocused = true},
            {image = image_list.cards.diamond12, isFocused = true},
            {image = image_list.cards.club12,    isFocused = true},
            {image = image_list.cards.spade12,   isFocused = true},
            {image = image_list.cards.heart5,    isFocused = false}
        }
    elseif ranking.key == "straight_flush" then
        desc_text = LANG.straight_flush_desc
        cards_info = {
            {image = image_list.cards.spade11,    isFocused = true},
            {image = image_list.cards.spade10,    isFocused = true},
            {image = image_list.cards.spade9,    isFocused = true},
            {image = image_list.cards.spade8,    isFocused = true},
            {image = image_list.cards.spade7,    isFocused = true}
        }
    end


    local background = Drawable:new(
        "rect-info-back-"..ranking.key, 4,
        Utils.getCenterAnchorX(background_drawable.x, background_drawable.width, background_width),
        background_y,
        background_width, background_height
    ):Rectangle(
        Color.white,
        5, Color.dark_blue
    )

    local description = Drawable:new(
        "text-info-desc-"..ranking.key, 5,
        background.x + 10,
        background.y + 10,
        background_width - 20,
        60
    ):TextBox(
        desc_text, Font:resizeFont(Font.font_paths.pixel_font, 30),
        Color.black
    )

    local base_card_width = 40 * 2
    local base_card_height = 66 * 2
    local card_margin = 20 + base_card_width
    local cards_total_width = 5*card_margin
    local all_cards_x = Utils.getCenterAnchorX(background.x, background.width, cards_total_width)
    local all_cards_y = background.y + description.height + 20

    for i, card_info in ipairs(cards_info) do
        local card_width = base_card_width
        local card_height = base_card_height
        local card_x = all_cards_x + (i-1)*card_margin
        local card_y = all_cards_y

        if not card_info.isFocused then
            card_width = card_width*0.7
            card_height = card_height*0.7

            card_x = Utils.getCenterAnchorX(card_x, base_card_width, card_width)
            card_y = Utils.getCenterAnchorY(card_y, base_card_height, card_height)
        end

        local card = Drawable:new(
            "img-card"..i.."-"..ranking.key, 5,
            card_x, card_y,
            card_width, card_height
        ):ImageBox(
            card_info.image
        )

        Scenes:addDrawable("hand-rankings", card)
        card.shouldDraw = false
        card.forceDisableHover = true
    end


    Scenes:addDrawable("hand-rankings", background)
    Scenes:addDrawable("hand-rankings", description)
    background.shouldDraw = false
    description.shouldDraw = false
    background.forceDisableHover = true
    description.forceDisableHover = true

    Scenes:sortDrawables("hand-rankings")
end

function HandRankings.showRankingInfo(drawable)
    Scenes:getDrawable("hand-rankings", "rect-info-back-" .. drawable.ranking.key).shouldDraw = true
    Scenes:getDrawable("hand-rankings", "text-info-desc-" .. drawable.ranking.key).shouldDraw = true

    for i=1, 5 do
        Scenes:getDrawable("hand-rankings", "img-card"..i.."-"..drawable.ranking.key).shouldDraw = true
    end
end

function HandRankings.closeRankingInfo(drawable)
    Scenes:getDrawable("hand-rankings", "rect-info-back-" .. drawable.ranking.key).shouldDraw = false
    Scenes:getDrawable("hand-rankings", "text-info-desc-" .. drawable.ranking.key).shouldDraw = false

    for i=1, 5 do
        Scenes:getDrawable("hand-rankings", "img-card"..i.."-"..drawable.ranking.key).shouldDraw = false
    end
end

return HandRankings