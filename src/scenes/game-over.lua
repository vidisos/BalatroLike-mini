local Scenes = require "src.Scenes"
local Drawable  = require "src.Drawable"
local Utils = require "src.Utils"
local GameState = require "src.GameState"

local LANG = require "src.LANG"
local Font = require "src.Font"

---@type Scene
return {
    id = "game-over",
    shouldDraw = false,
    z_index = 2,
    drawables = {
        -- main background
        Drawable:new(
            "rect-background", 0,
            860, 120, 400, 800
        ):Rectangle({134/255, 142/255, 156/255}, 10),

        -- u lose
        Drawable:new(
            "text-you-lose", 1,
            Utils.getCenterAnchorX(860, 400, 370), 300, 370, 100
        ):TextBox(
            LANG.you_lose,
            Font:resizeFont(Font.font_paths.pixel_font_bold, 110)
        ),

        -- start new game
        Drawable:new(
            "btn-new-game", 1,
            Utils.getCenterAnchorX(860, 400, 330), 650, 330, 100
        ):Button(
            LANG.new_game,
            Font:resizeFont(Font.font_paths.pixel_font, 30),
            {0, 0, 100/255},
            {1, 0, 0},
            function(self)
                GameState:startNewGame()
                Scenes:resetScenes()
                Scenes:enableScene("game-main")
            end,
            10,
            {0, 100/255, 25/255}
        ),

        -- to main menu
        Drawable:new(
            "btn-to-main-menu", 1,
            Utils.getCenterAnchorX(860, 400, 330), 780, 330, 100
        ):Button(
            LANG.to_main_menu,
            Font:resizeFont(Font.font_paths.pixel_font, 30),
            {0, 0, 100/255},
            {1, 0, 0},
            function(self)
                Scenes:resetScenes()
                Scenes:enableScene("start-menu")
            end,
            10,
            {0, 100/255, 25/255}
        )
    }
}