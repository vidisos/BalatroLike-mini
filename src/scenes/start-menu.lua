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

---@type Scene
return {
    id = "start-menu",
    shouldDraw = true,
    isClickable = true,
    z_index = 0,
    drawables = {
        -- background
        Drawable:new("rect-background", 0,
            0, 0, ww, wh
        ):Rectangle({59, 124, 217}),

        -- title
        Drawable:new(
            "text-title", 1,
            Utils.getCenterAnchorX(0, ww, 1200), Utils.getCenterAnchorY(0, wh, 400),
            1200, 400
        ):TextBox(LANG.title, Utils.resizeFont(pixel_font_bold, 300)),

        -- settings icon
        Drawable:new(
            "img-settings", 1,
            ww-100, 10, 90, 90
        ):ImageBox(
            image_list.settings_icon,
            function ()
                if audio_list.background_music:isPlaying() then
                    audio_list.background_music:pause()
                else
                    audio_list.background_music:play()
                end
            end
        ),

        -- start button
        Drawable:new(
            "btn-start", 1,
            560, 800, 300, 150
        ):Button(
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
        ),

        -- quit button
        Drawable:new(
            "btn-quit", 1,
            1060, 810, 250, 130
        ):Button(
            LANG.quit, Utils.resizeFont(pixel_font, 50),
            {0, 0, 100},
            {255, 0, 0},
            function()
                love.event.quit()
            end,
            10,
            {0, 100, 25}
        ),

        -- language button
        Drawable:new(
            "btn-change-lang", 1,
            1680, 950, 200, 100
        ):Button(
            LANG.language, Utils.resizeFont(pixel_font, 30),
            {0, 0, 100},
            {255, 0, 0},
            function(self)
                GameState:changeLang()
            end,
            nil,
            {0, 100, 25}
        )
    }
}