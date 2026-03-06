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

-- adding extensions to the Drawable superclass
Drawable.ImageBox = require("src.ImageBox").ImageBox
Drawable.Rectangle = require("src.Rectangle").Rectangle
Drawable.TextBox = require("src.TextBox").TextBox
Drawable.Button = require("src.Button").Button
Drawable.Card = require("src.Card").Card

---@class Scene
return {
    id = "game-over",
    shouldDraw = false,
    isClickable = true,
    z_index = 1,
    drawables = {
        {
            id = "rect-background",
            z_index = 0,
            drawable = Drawable:new(500, 500, 500, 500):Rectangle({255, 0, 0})
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
    }
}