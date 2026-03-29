local CONSTANTS = require "src.constants"
local Scenes = require "src.Scenes"
local Drawable  = require "src.Drawable"
local Utils = require "src.Utils"
local image_list = require "src.image_list"
local GameState = require "src.GameState"
local Options   = require "src.Options"
local Color = require "src.Color"
local Audio = require "src.Audio"

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
        ):Rectangle(Color.blue),

        -- title
        Drawable:new(
            "text-title", 1,
            Utils.getCenterAnchorX(0, ww, 1200), Utils.getCenterAnchorY(0, wh, 400),
            1200, 400
        ):TextBox(LANG.title, Font:resizeFont(Font.font_paths.pixel_font_bold, 300)),

        -- settings icon
        Drawable:new(
            "img-settings", 1,
            ww-100, 10, 90, 90,
            nil, nil,
            function(self) self.color = Color.light_grey end,
            function(self) self.color = self.base_color end
        ):ImageBox(
            image_list.settings_icon,
            function ()
                Audio:playSound(Audio.sfx.button_click)
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
            Color.green,
            function (self)
                Audio:playSound(Audio.sfx.button_click)

                Scenes:resetScenes()
                Scenes:enableScene("game-main")
                GameState:startNewGame()
                Scenes:sortDrawables("game-main")
            end
        ),

        -- quit button
        Drawable:new(
            "btn-quit", 1,
            1060, 810, 270, 130,
            nil,
            nil,
            function (self) self.color = Color:tintColor(self.base_color, 0.8) end,
            function (self) self.color = self.base_color end
        ):Button(
            LANG.quit, Font:resizeFont(Font.font_paths.pixel_font, 70),
            Color.white,
            Color.red,
            function()
                Audio:playSound(Audio.sfx.button_click)

                love.event.quit()
            end
        ),

        -- language button
        Drawable:new(
            "btn-change-lang", 1,
            1560, 950, 280, 100,
            nil,
            nil,
            function (self) self.color = Color:tintColor(self.base_color, 0.8) end,
            function (self) self.color = self.base_color end
        ):Button(
            nil, nil,
            nil,
            Color.grey,
            function(self)
                Audio:playSound(Audio.sfx.button_click)

                GameState:changeLang()
            end,
            5,
            Color.light_grey
        ),

        Drawable:new(
            "img-lang-icon", 2,
            1570, 970, 80, 60,
            nil, nil, nil, nil, true
        ):ImageBox(image_list.language_icon),

        Drawable:new(
            "text-change-lang", 1,
            1570 + 80, 950, 190, 100,
            nil, nil, nil, nil, true
        ):TextBox(
            LANG.language, Font:resizeFont(Font.font_paths.pixel_font, 35),
            Color.white
        ),
    }
}