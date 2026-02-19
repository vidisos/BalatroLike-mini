local CONSTANTS = require "CONSTANTS"
local Scenes = require "Scenes"
local Drawable  = require "Drawable"
local Utils = require "Utils"
local audio_list = require "audio_list"
local image_list = require "image_list"
local card_list = require "card_list"
local GameState = require "GameState"

local LANG = require "LANG"
local current_lang = GameState.current_lang

local pixel_font = "fonts/Karma Suture.otf"
local pixel_font_bold = "fonts/Karma Future.otf"
local ww = CONSTANTS.BASE_WIDTH
local wh = CONSTANTS.BASE_HEIGHT

-- adding extensions to the Drawable superclass
Drawable.ImageBox = require("ImageBox").Card
Drawable.Rectangle = require("Rectangle").Rectangle
Drawable.TextBox = require("TextBox").TextBox
Drawable.Button = require("Button").Button
Drawable.Card = require("Card").Card

return {
    id = "start-menu",
    shouldDraw = true,
    z_index = 0,
    drawables = {
        {
            id = "rect-background",
            z_index = 0,
            drawable = Drawable:new(0, 0, ww, wh):Rectangle({59, 124, 217})
        },

        {
            id = "text-title",
            z_index = 1,
            drawable = Drawable:new(
                Utils.getCenterAnchorX(0, ww, 1200), Utils.getCenterAnchorY(0, wh, 400),
                1200, 400
            ):TextBox(LANG.title, Utils.resizeFont(pixel_font_bold, 300))
        },

        {
            id = "img-settings",
            z_index = 1,
            drawable = Drawable:new(ww-100, 10, 90, 90):ImageBox(image_list.settings_icon, function () audio_list.uderehee:stop() end)
        },

        {
            id = "btn-start",
            z_index = 1,
            drawable = Drawable:new(500, 800, 300, 150):Button(
                LANG.start, Utils.resizeFont(pixel_font, 90),
                {237, 164, 74},
                {212, 198, 182},
                function (self)
                    Scenes:disableScenes()
                    Scenes:enableScene("game-main")
                    Scenes:sortDrawables(Scenes:getScene("game-main"))
                end,
                15,
                {100, 50, 20}
            )
        },

        {
            id = "btn-quit",
            z_index = 1,
            drawable = Drawable:new(1000, 820, 250, 130):Button(
                LANG.quit, Utils.resizeFont(pixel_font, 50),
                {0, 0, 100},
                {255, 0, 0},
                function()
                    love.event.quit()
                end,
                10,
                {0, 100, 25}
            )
        },

        {
            id = "btn-change-lang",
            z_index = 1,
            drawable = Drawable:new(1600, 950, 200, 100):Button(
                LANG.language, Utils.resizeFont(pixel_font, 30),
                {0, 0, 100},
                {255, 0, 0},
                function(self)
                    if (GameState.current_lang == "en") then
                        GameState.current_lang = "sl"
                    else
                        GameState.current_lang = "en"
                    end
                end,
                nil,
                {0, 100, 25}
            )
        },

        {
            id = "text-dynamic",
            z_index = 1,
            drawable = Drawable:new(100, 100, 200, 200,
                function (self, dt)
                    self.text = string.format("%.2f", GameState.points + dt)
                end
                ):TextBox(
                tostring(GameState.points), Utils.resizeFont(pixel_font, 50),
                nil,
                {59, 124, 217}
            )
        }
    }
}