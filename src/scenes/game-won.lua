local Scenes = require "src.Scenes"
local Drawable  = require "src.Drawable"
local Utils = require "src.Utils"
local GameState = require "src.GameState"
local Color = require "src.Color"

local LANG = require "src.LANG"
local Font = require "src.Font"

---@type Scene
return {
    id = "game-won",
    shouldDraw = false,
    z_index = 2,
    drawables = {
        -- main background
        Drawable:new(
            "rect-background", 0,
            860, 120, 420, 800
        ):Rectangle(Color.dark_grey, 10),

        -- u lose
        Drawable:new(
            "text-you-win", 1,
            860, 280, 420, 100
        ):TextBox(
            LANG.you_win,
            Font:resizeFont(Font.font_paths.pixel_font_bold, 110),
            Color.blue
        ),

        -- continue game
        Drawable:new(
            "btn-continue-game", 1,
            Utils.getCenterAnchorX(860, 420, 360), 520, 360, 100,
            nil,
            nil,
            function (self) self.color = Color:tintColor(self.base_color, 0.8) end,
            function (self) self.color = self.base_color end
        ):Button(
            LANG.continue,
            Font:resizeFont(Font.font_paths.pixel_font, 50),
            Color.white,
            Color.dark_blue,
            function(self)
                Scenes:resetScenes()
                Scenes:enableScene("game-main")
                Scenes:enableScene("round-won")
            end,
            5,
            Color.light_blue
        ),

        -- start new game
        Drawable:new(
            "btn-new-game", 1,
            Utils.getCenterAnchorX(860, 420, 360), 650, 360, 100,
            nil,
            nil,
            function (self) self.color = Color:tintColor(self.base_color, 0.8) end,
            function (self) self.color = self.base_color end
        ):Button(
            LANG.new_game,
            Font:resizeFont(Font.font_paths.pixel_font, 50),
            Color.white,
            Color.dark_blue,
            function(self)
                Scenes:resetScenes()
                GameState:startNewGame()
                Scenes:enableScene("game-main")
            end,
            5,
            Color.light_blue
        ),

        -- to main menu
        Drawable:new(
            "btn-to-main-menu", 1,
            Utils.getCenterAnchorX(860, 420, 360), 780, 360, 100,
            nil,
            nil,
            function (self) self.color = Color:tintColor(self.base_color, 0.8) end,
            function (self) self.color = self.base_color end
        ):Button(
            LANG.to_main_menu,
            Font:resizeFont(Font.font_paths.pixel_font, 50),
            Color.white,
            Color.dark_blue,
            function(self)
                Scenes:resetScenes()
                Scenes:enableScene("start-menu")
            end,
            5,
            Color.light_blue
        )
    }
}