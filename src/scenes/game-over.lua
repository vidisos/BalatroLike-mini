local Scenes = require "src.Scenes"
local Drawable  = require "src.Drawable"
local Utils = require "src.Utils"
local GameState = require "src.GameState"
local Color = require "src.Color"
local Audio = require "src.Audio"

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
        ):Rectangle(Color.dark_grey, 10, Color.light_grey),

        -- u lose
        Drawable:new(
            "text-you-lose", 1,
            Utils.getCenterAnchorX(860, 400, 370), 300, 370, 100
        ):TextBox(
            LANG.you_lose, Font:resizeFont(Font.font_paths.pixel_font_bold, 110),
            Color.red
        ),

        -- start new game
        Drawable:new(
            "btn-new-game", 1,
            Utils.getCenterAnchorX(860, 400, 330), 650, 330, 100,
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
                Audio:playSound(Audio.sfx.button_click)

                GameState:startNewGame()
                Scenes:resetScenes()
                Scenes:enableScene("game-main")
            end,
            5,
            Color.light_blue
        ),

        -- to main menu
        Drawable:new(
            "btn-to-main-menu", 1,
            Utils.getCenterAnchorX(860, 400, 330), 780, 330, 100,
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
                Audio:playSound(Audio.sfx.button_click)

                Scenes:resetScenes()
                Scenes:enableScene("start-menu")
            end,
            5,
            Color.light_blue
        )
    }
}