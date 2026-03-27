local CONSTANTS = require "src.constants"
local Scenes = require "src.Scenes"
local Drawable  = require "src.Drawable"
local Utils = require "src.Utils"
local image_list = require "src.image_list"
local GameState = require "src.GameState"
local Options   = require "src.Options"
local Color = require "src.Color"

local LANG = require "src.LANG"
local Font = require "src.Font"

local ww = CONSTANTS.BASE_WIDTH
local wh = CONSTANTS.BASE_HEIGHT

---@type Scene
return {
    id = "start-menu",
    shouldDraw = true,
    z_index = 0,
    drawables = {
        -- background
        Drawable:new("rect-background", 0,
            0, 0, ww, wh
        ):Rectangle({59/255, 124/255, 217/255}),

        -- title
        Drawable:new(
            "text-title", 1,
            Utils.getCenterAnchorX(0, ww, 1200), Utils.getCenterAnchorY(0, wh, 400),
            1200, 400
        ):TextBox(LANG.title, Font:resizeFont(Font.font_paths.pixel_font_bold, 300)),

        -- settings icon
        Drawable:new(
            "img-settings", 1,
            ww-100, 10, 90, 90
        ):ImageBox(
            image_list.settings_icon,
            function ()
                Options:toggle("start-menu")
            end
        ),

        -- start button
        Drawable:new(
            "btn-start", 1,
            560, 800, 300, 150,
            nil,
            nil,
            function (self) self.color = Color:tintColor(self.base_color, 0.8) end,
            function (self) self.color = self.base_color end
        ):Button(
            LANG.start, Font:resizeFont(Font.font_paths.pixel_font, 90),
            Color.white,
            Color.play_green,
            function (self)
                Scenes:resetScenes()
                Scenes:enableScene("game-main")
                GameState:startNewGame()
                Scenes:sortDrawables("game-main")
            end,
            10,
            Color.dark_grey
        ),

        -- quit button
        Drawable:new(
            "btn-quit", 1,
            1060, 810, 250, 130,
            nil,
            nil,
            function (self) self.color = Color:tintColor(self.base_color, 0.8) end,
            function (self) self.color = self.base_color end
        ):Button(
            LANG.quit, Font:resizeFont(Font.font_paths.pixel_font, 50),
            Color.white,
            {1, 0, 0},
            function()
                love.event.quit()
            end,
            10,
            Color.dark_grey
        ),

        -- language button
        Drawable:new(
            "btn-change-lang", 1,
            1680, 950, 200, 100,
            nil,
            nil,
            function (self) self.color = Color:tintColor(self.base_color, 0.8) end,
            function (self) self.color = self.base_color end
        ):Button(
            LANG.language, Font:resizeFont(Font.font_paths.pixel_font, 30),
            Color.white,
            Color.light_grey,
            function(self)
                GameState:changeLang()
            end,
            8,
            Color.dark_grey
        )
    }
}