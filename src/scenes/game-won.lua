local CONSTANTS = require "src.CONSTANTS"
local Scenes = require "src.Scenes"
local Drawable  = require "src.Drawable"
local Utils = require "src.Utils"
local audio_list = require "src.audio_list"
local image_list = require "src.image_list"
local GameState = require "src.GameState"
local LANG = require "src.LANG"

local pixel_font = "src/fonts/Karma Suture.otf"
local pixel_font_bold = "src/fonts/Karma Future.otf"
local ww = CONSTANTS.BASE_WIDTH
local wh = CONSTANTS.BASE_HEIGHT

local left_column = Scenes:getDrawable("game-main", "rect-left")

---@type Scene
return {
    id = "game-won",
    shouldDraw = false,
    isClickable = true,
    z_index = 1,
    drawables = {
        -- main background
        Drawable:new(
            "rect-background", 0,
            CONSTANTS.HAND_X-100, 500, CONSTANTS.HAND_WIDTH+200, 800
        ):Rectangle({134, 142, 156}, 10),

        -- level overlay
        Drawable:new(
            "text-choose-sparks", 1,
            Utils.getCenterAnchorX(left_column.x, left_column.width, left_column.width-50), 20, left_column.width-50, 375
        ):TextBox(
            LANG.choose_spark, Utils.resizeFont(pixel_font_bold, 90),
            nil,
            {134, 142, 156}
        )
    }
}