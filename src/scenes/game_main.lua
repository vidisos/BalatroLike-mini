local CONSTANTS = require "CONSTANTS"
local Scenes = require "Scenes"
local Drawable  = require "Drawable"
local Utils = require "Utils"
local audio_list = require "audio_list"
local image_list = require "image_list"
local GameState = require "GameState"
local LANG = require "LANG"

local pixel_font = "fonts/Karma Suture.otf"
local pixel_font_bold = "fonts/Karma Future.otf"
local ww = CONSTANTS.BASE_WIDTH
local wh = CONSTANTS.BASE_HEIGHT

-- adding extensions to the Drawable superclass
Drawable.ImageBox = require("ImageBox").Card
Drawable.Rectangle = require("Rectangle").Rectangle
Drawable.TextBox = require("TextBox").TextBox
Drawable.Button = require("Button").Button

return {
    id = "game-main",
    shouldDraw = false,
    z_index = 0,
    drawables = {
        {
            id = "rect-background",
            z_index = 0,
            drawable = Drawable:new(0, 0, ww, wh):Rectangle({255, 100, 50})
        },

        {
            id = "rect-left",
            z_index = 1,
            drawable = Drawable:new(0, 0, 450, wh):Rectangle({50, 100, 200})
        },

        {
            id = "text-level-title",
            z_index = 2,
            drawable = Drawable:new(Utils.getCenterAnchorX(0, 450, 400), 50, 400, 120):TextBox(
                LANG:getCurrentLevelText(), Utils.resizeFont(pixel_font, 80),
                nil, {255, 255, 0}
            )
        }, 

        {
            id = "rect-level-background",
            z_index = 2,
            drawable = Drawable:new(Utils.getCenterAnchorX(0, 450, 310), 200, 310, 190):Rectangle(
                {111, 123, 143}
            )
        },
        {
            id = "text-level-requirement-text",
            z_index = 3,
            drawable = Drawable:new(Utils.getCenterAnchorX(0, 450, 400), 200, 400, 100):TextBox(
                LANG.scoreText, Utils.resizeFont(pixel_font, 35),
                nil, nil
            )
        },
        {
            id = "text-level-requirement-score",
            z_index = 3,
            drawable = Drawable:new(Utils.getCenterAnchorX(0, 450, 400), 270, 400, 100):TextBox(
                tostring(GameState.score_requirement), Utils.resizeFont(pixel_font, 80),
                {240, 67, 67}, nil
            )
        },

        {
            id = "btn-quit",
            z_index = 1,
            drawable = Drawable:new(1700, 600, 300, 200):Button(
                LANG.quit, Utils.resizeFont(pixel_font, 30),
                {237, 164, 74},
                {212, 198, 182},
                function()
                    Scenes:disableScenes()
                    Scenes:enableScene("start-menu")
                end
            )
        }
    }
}