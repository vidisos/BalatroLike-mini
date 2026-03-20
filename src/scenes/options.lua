local CONSTANTS = require "src.constants"
local Scenes = require "src.Scenes"
local Drawable  = require "src.Drawable"
local Utils = require "src.Utils"
local audio_list = require "src.audio_list"
local image_list = require "src.image_list"
local card_list = require "src.card_list"
local GameState = require "src.GameState"

local LANG = require "src.LANG"
local Font = require "src.Font"
local current_lang = GameState.current_lang

local ww = CONSTANTS.BASE_WIDTH
local wh = CONSTANTS.BASE_HEIGHT

---@type Scene
return {
    id = "options",
    shouldDraw = false,
    isClickable = true,
    z_index = 3,
    drawables = {
        -- background
        Drawable:new("rect-background", 0,
            Utils.getCenterAnchorX(0, ww, 600), Utils.getCenterAnchorY(0, wh, 800), 600, 800
        ):Rectangle({59/255, 124/255, 217/255}),

        -- settings icon
        Drawable:new(
            "img-settings", 1,
            ww-100, 10, 90, 90
        ):ImageBox(
            image_list.settings_icon,
            function ()
                GameState:closeOptions()
            end
        ),
        --[[
        -- start button
        Drawable:new(
            "btn-start", 1,
            560, 800, 300, 150
        ):Button(
            LANG.start, Font:resizeFont(Font.font_paths.pixel_font, 90),
            {237/255, 164/255, 74/255},
            {212/255, 198/255, 182/255},
            function (self)
                Scenes:resetScenes()
                Scenes:enableScene("game-main")
                GameState:startNewGame()
                Scenes:sortDrawables("game-main")
            end,
            15,
            {100/255, 50/255, 20/255}
        ),

        -- quit button
        Drawable:new(
            "btn-quit", 1,
            1060, 810, 250, 130
        ):Button(
            LANG.quit, Font:resizeFont(Font.font_paths.pixel_font, 50),
            {0, 0, 100/255},
            {1, 0, 0},
            function()
                love.event.quit()
            end,
            10,
            {0, 100/255, 25/255}
        ),

        -- language button
        Drawable:new(
            "btn-change-lang", 1,
            1680, 950, 200, 100
        ):Button(
            LANG.language, Font:resizeFont(Font.font_paths.pixel_font, 30),
            {0, 0, 100/255},
            {1, 0, 0},
            function(self)
                GameState:changeLang()
            end
        )]]
    }
}