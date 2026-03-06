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

---@type Scene
return {
    id = "game-over",
    shouldDraw = false,
    isClickable = true,
    z_index = 1,
    drawables = {
        -- main background
        Drawable:new(
            "rect-background", 0,
            860, 120, 400, 800
        ):Rectangle({134, 142, 156}, 10),

        -- u lose
        Drawable:new(
            "text-you-lose", 1,
            Utils.getCenterAnchorX(860, 400, 370), 300, 370, 100
        ):TextBox(
            LANG.you_lose,
            Utils.resizeFont(pixel_font_bold, 110)
        ),

        -- start new game
        Drawable:new(
            "btn-new-game", 1,
            Utils.getCenterAnchorX(860, 400, 330), 650, 330, 100
        ):Button(
            LANG.new_game,
            Utils.resizeFont(pixel_font, 30),
            {0, 0, 100},
            {255, 0, 0},
            function(self)
                GameState:startNewRound()
                Scenes:disableScene("game-over")
                Scenes:enableSceneClicks("game-main")
            end,
            10,
            {0, 100, 25}
        ),

        -- to main menu
        Drawable:new(
            "btn-to-main-menu", 1,
            Utils.getCenterAnchorX(860, 400, 330), 780, 330, 100
        ):Button(
            LANG.to_main_menu,
            Utils.resizeFont(pixel_font, 30),
            {0, 0, 100},
            {255, 0, 0},
            function(self)
                Scenes:disableScenes()
                Scenes:enableSceneClicks("game-main")
                Scenes:enableScene("start-menu")
            end,
            10,
            {0, 100, 25}
        ),
    }
}