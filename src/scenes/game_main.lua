local CONSTANTS = require "CONSTANTS"
local Scenes = require "Scenes"
local Drawable  = require "Drawable"
local Utils = require "Utils"
local audio_list = require "audio_list"
local image_list = require "image_list"
local GameState = require "GameState"

local pixel_font = "fonts/Karma Suture.otf"
local pixel_font_bold = "fonts/Karma Future.otf"
local ww = CONSTANTS.BASE_WIDTH
local wh = CONSTANTS.BASE_HEIGHT

-- adding extensions to the Drawable superclass
Drawable.ImageBox = require("ImageBox").ImageBox
Drawable.Rectangle = require("Rectangle").Rectangle
Drawable.TextBox = require("TextBox").TextBox
Drawable.Button = require("Button").Button

return {
    id = "game-main",
    shouldDraw = false,
    z_index = 0,
    drawables = {
        {
            id = "btn-abuioabu",
            z_index = 0,
            drawable = Drawable:new(200, 200, 300, 200):Button(
                "ABUIOABU", Utils.resizeFont(pixel_font, 30),
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