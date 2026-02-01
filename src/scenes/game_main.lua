local Rectangle = require "Rectangle"
local Button = require "Button"
local TextBox = require "TextBox"
local ImageBox   = require "ImageBox"
local audio_list = require "audio"
local image_list = require "images"
local Utils = require "Utils"
local CONSTANTS = require "constants"

local pixel_font = "fonts/Karma Suture.otf"
local pixel_font_bold = "fonts/Karma Future.otf"
local ww = CONSTANTS.BASE_WIDTH
local wh = CONSTANTS.BASE_HEIGHT

return {
    id = "game-main",
    shouldDraw = false,
    drawables = {
        {
            id = "btn-abuioabu",
            drawable = Button:new(
                "ABUIOABU", Utils.resizeFont(pixel_font, 30),
                200, 200, 300, 200,
                {237, 164, 74},
                {212, 198, 182},
                function()
                    disableScenes()
                    enableScene("start-menu")
                end
            )
        }
    }
}