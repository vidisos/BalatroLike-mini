local CONSTANTS = require "CONSTANTS"
local Scenes = require "Scenes"
local Drawable  = require "Drawable"
local Utils = require "Utils"
local audio_list = require "audio_list"
local image_list = require "image_list"
local card_list = require "card_list"
local GameState = require "GameState"

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
            z_index = 0,
            drawable = Drawable:new(
                Utils.getCenterAnchorX(0, ww, 1200), Utils.getCenterAnchorY(0, wh, 400),
                1200, 400
            ):TextBox("Poinker", Utils.resizeFont(pixel_font_bold, 300))
        },

        {
            id = "img-settings",
            z_index = 0,
            drawable = Drawable:new(ww-100, 10, 90, 90):ImageBox(image_list.settings_icon, function () audio_list.uderehee:stop() end)
        },

        {
            id = "btn-uderehee",
            z_index = 0,
            drawable = Drawable:new(370, wh-200, 300, 100):Button(
                "Uderehee", Utils.resizeFont(pixel_font, 40),
                {237, 164, 74},
                {212, 198, 182},
                function ()
                    audio_list.uderehee:stop()
                    audio_list.uderehee:play()
                end,
                nil,
                {100, 50, 20}
            )
        },

        {
            id = "btn-new-screen",
            z_index = 0,
            drawable = Drawable:new(800, wh-200, 200, 100):Button(
                "New Screen", Utils.resizeFont(pixel_font, 30),
                {237, 164, 74},
                {212, 198, 182},
                function (self)
                    Scenes:disableScenes()
                    Scenes:enableScene("game-main")

                    self.x = self.x - 200
                    Scenes:addDrawable(
                        Scenes:getScene("game-main"),
                        "card",
                        10,
                        Drawable:new(0, 0, 200, 200*CONSTANTS.CARD_IMAGE_RATIO, function(self, dt) local x_movement = 500 self.x = self.x + x_movement * dt end):Card(
                            card_list.cards.spade1
                        )
                    )

                    Scenes:sortDrawables(Scenes:getScene("game-main"))
                end,
                10,
                {100, 50, 20}
            )
        },

        {
            id = "btn-quit",
            z_index = 0,
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
            id = "btn-test",
            z_index = 1,
            drawable = Drawable:new(1250, wh-200, 200, 100):Button(
                "layered", Utils.resizeFont(pixel_font, 30),
                {0, 0, 100},
                {255, 0, 0},
                nil,
                0,
                {0, 25, 255}
            )
        },

        {
            id = "text-dynamic",
            z_index = 0,
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