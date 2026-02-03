local CONSTANTS = require "src.CONSTANTS"
local Scenes = require "Scenes"
local Drawable  = require "Drawable"
local Utils = require "Utils"
local audio_list = require "audio"
local image_list = require "images"
local GameState = require "GameState"

local pixel_font = "fonts/Karma Suture.otf"
local pixel_font_bold = "fonts/Karma Future.otf"
local ww = CONSTANTS.BASE_WIDTH
local wh = CONSTANTS.BASE_HEIGHT

Drawable.ImageBox = require("ImageBox").ImageBox
Drawable.Rectangle = require("Rectangle").Rectangle
Drawable.TextBox = require("TextBox").TextBox
Drawable.Button = require("Button").Button

return {
    id = "start-menu",
    shouldDraw = true,
    drawables = {
        {
            id = "rect-background",
            drawable = Drawable:new(0, 0, ww, wh):Rectangle({59, 124, 217})
        },

        {
            id = "text-title",
            drawable = Drawable:new(
                Utils.getCenterAnchorX(0, ww, 1200), Utils.getCenterAnchorY(0, wh, 400),
                1200, 400
            ):TextBox(
                "Poinker", Utils.resizeFont(pixel_font_bold, 300),
                nil,
                {59, 124, 217}
            )
        },

        {
            id = "img-settings",
            drawable = Drawable:new(ww-100, 10, 90, 90):ImageBox(image_list.settings_icon)
        },

        {
            id = "btn-uderehee",
            drawable = Drawable:new(370, wh-200, 300, 100):Button(
                "Uderehee", Utils.resizeFont(pixel_font, 40),
                {237, 164, 74},
                {212, 198, 182},
                function()
                    audio_list["uderehee"]:stop()
                    audio_list["uderehee"]:play()
                end,
                10,
                {100, 50, 20}
            )
        },

        {
            id = "btn-new-screen",
            drawable = Drawable:new(800, wh-200, 200, 100):Button(
                "New Screen", Utils.resizeFont(pixel_font, 30),
                {237, 164, 74},
                {212, 198, 182},
                function()
                    Scenes:disableScenes()
                    Scenes:enableScene("game-main")
                end,
                10,
                {100, 50, 20}
            )
        },

        {
            id = "btn-quit",
            drawable = Drawable:new(1350, wh-200, 200, 100):Button(
                "Quit", Utils.resizeFont(pixel_font, 30),
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
            id = "text-dynamic",
            drawable = Drawable:new(100, 100, 200, 200,
                function (self, dt)
                    self.text = GameState.points
                end
            ):TextBox(
                GameState.points, Utils.resizeFont(pixel_font, 50),
                nil,
                {59, 124, 217}
            )
        }
    }
}