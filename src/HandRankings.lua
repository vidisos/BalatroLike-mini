local CONSTANTS = require "src.constants"
local Scenes = require "src.Scenes"
local Drawable  = require "src.Drawable"
local Utils = require "src.Utils"
local audio_list = require "src.audio_list"
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

local ranking_margin = 5

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
        Color.light_grey,
        10, Color.dark_grey
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
        LANG.back, Font:resizeFont(Font.font_paths.pixel_font, 20),
        Color.black,
        Color.dark_orange,
        function (self)
            Scenes:enableAllSceneInteractions()
            Scenes:disableScene("hand-rankings")
        end,
        2,
        {100/255, 50/255, 20/255}
    ),
}

---draws the rankings on the hand rackings scene in order from highets display index to lowest
function HandRankings:drawRankings()
    -- as they are in the original list but reversed
    local rankings_arrays = Utils.getArray(hand_rankings_list)
    local ranking_count = 0
    table.sort(rankings_arrays, function(a, b) return a.display_index < b.display_index end)

    for _, ranking in ipairs(rankings_arrays) do
        local background = Drawable:new(
            "rect-"..ranking.key, 1,
            rankings_x, rankings_y + ranking_count*(ranking_height + ranking_margin), ranking_width, ranking_height,
            nil, nil,
            function(self) self.color = Color:tintColor(self.base_color, 0.8) end,
            function(self) self.color = self.base_color end
        ):Rectangle(
            Color.light_grey,
            5, Color.dark_grey
        )

        local hand_text = Drawable:new(
            "text-"..ranking.key, 2,
            background.x, background.y, 350, background.height
        ):TextBox(
            ranking.title, nil,
            Color.white, nil, "left", 10
        )
        -- we need to reapply the font since it would normally take the font size of the lanugae entry
        hand_text.font = Font:resizeFont(Font.font_paths.pixel_font, 23)
        hand_text.forceDisableHover = true
        Scenes:addDrawable("hand-rankings", background)
        Scenes:addDrawable("hand-rankings", hand_text)
        --[[
        Scenes:addDrawable("hand-rankings", mult_back)
        Scenes:addDrawable("hand-rankings", mult_text)
        Scenes:addDrawable("hand-rankings", chips_back)
        Scenes:addDrawable("hand-rankings", chips_text)
        Scenes:addDrawable("hand-rankings", multiply_sign)
        ]]

        ranking_count = ranking_count + 1
    end
end

return HandRankings