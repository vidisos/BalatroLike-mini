local CONSTANTS = require "src.constants"
local Scenes = require "src.Scenes"
local Drawable  = require "src.Drawable"
local Utils = require "src.Utils"
local audio_list = require "src.audio_list"
local image_list = require "src.image_list"
local GameState = require "src.GameState"
local Options   = require "src.Options"

local LANG = require "src.LANG"
local Font = require "src.Font"

local ww = CONSTANTS.BASE_WIDTH
local wh = CONSTANTS.BASE_HEIGHT

local left_column = Scenes:getDrawable("game-main", "rect-left")

---@type Scene
return {
    id = "round-won",
    shouldDraw = false,
    isClickable = true,
    z_index = 1,
    drawables = {
        -- main background
        Drawable:new(
            "rect-background", 0,
            CONSTANTS.HAND_X-100, 500, CONSTANTS.HAND_WIDTH+200, 800
        ):Rectangle({134/255, 142/255, 156/255}, 10),

        -- round overlay
        Drawable:new(
            "text-choose-sparks", 1,
            Utils.getCenterAnchorX(left_column.x, left_column.width, left_column.width-50), 20, left_column.width-50, 320
        ):TextBox(
            LANG.choose_spark, Font:resizeFont(Font.font_paths.pixel_font_bold, 90),
            nil,
            {134/255, 142/255, 156/255}
        ),

        -- skip sparks
        Drawable:new(
            "btn-skip-sparks", 1,
            Utils.getCenterAnchorX(CONSTANTS.HAND_X-100, CONSTANTS.HAND_WIDTH+200, 200), 900, 200, 100
        ):Button(LANG.skip, Font:resizeFont(Font.font_paths.pixel_font, 20), nil, nil,
            function (self)
                GameState:moveToNextRound()
            end
        ),

        -- settings
        Drawable:new("img-settings",1,
            ww-100,10,90,90
        ):ImageBox(
            image_list.settings_icon,
            function()
                Options:open("round-won")
            end
        ),
    }
}