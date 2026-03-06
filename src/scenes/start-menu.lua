local CONSTANTS = require "src.CONSTANTS"
local Scenes = require "src.Scenes"
local Drawable  = require "src.Drawable"
local Utils = require "src.Utils"
local audio_list = require "src.audio_list"
local image_list = require "src.image_list"
local card_list = require "src.card_list"
local GameState = require "src.GameState"

local LANG = require "src.LANG"
local current_lang = GameState.current_lang

local pixel_font = "src/fonts/Karma Suture.otf"
local pixel_font_bold = "src/fonts/Karma Future.otf"
local ww = CONSTANTS.BASE_WIDTH
local wh = CONSTANTS.BASE_HEIGHT

-- adding extensions to the Drawable "superclass"
Drawable.ImageBox = require("src.ImageBox").ImageBox
Drawable.Rectangle = require("src.Rectangle").Rectangle
Drawable.TextBox = require("src.TextBox").TextBox
Drawable.Button = require("src.Button").Button
Drawable.Card = require("src.Card").Card

---@class Scene
return {
    id = "start-menu",
    shouldDraw = true,
    isClickable = true,
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
            drawable = Drawable:new(ww-100, 10, 90, 90):ImageBox(image_list.settings_icon, 
                function () 
                    if audio_list.background_music:isPlaying() then
                        audio_list.background_music:pause()
                    else
                        audio_list.background_music:play()
                    end
                end
            )
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
                    GameState:startNewRound()
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
            drawable = Drawable:new(1680, 950, 200, 100):Button(
                LANG.language, Utils.resizeFont(pixel_font, 30),
                {0, 0, 100},
                {255, 0, 0},
                function(self)
                    GameState:changeLang()
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
                    self.text = string.format("%.2f", GameState.timer)
                end
                ):TextBox(
                tostring(GameState.timer), Utils.resizeFont(pixel_font, 50),
                nil,
                {59, 124, 217}
            )
        }
    }
}