local Rectangle = require "Rectangle"
local Button = require "Button"
local TextBox = require "TextBox"
local ImageBox   = require "ImageBox"
local audio_list = require "audio"
local image_list = require "images"
local Utils = require "Utils"
local Scenes = require "Scenes"
local GameState = require "GameState"
local CONSTANTS = require "src.CONSTANTS"

local pixel_font = "fonts/Karma Suture.otf"
local pixel_font_bold = "fonts/Karma Future.otf"
local ww = CONSTANTS.BASE_WIDTH
local wh = CONSTANTS.BASE_HEIGHT

return {
    id = "start-menu",
    shouldDraw = true,
    drawables = {
        {
            id = "rect-background",
            drawable = Rectangle:new(
                0, 0,
                ww, wh,
                {59, 124, 217},
                nil
            )
        },

        {
            id = "text-title",
            drawable = TextBox:new(
                "Poinker", Utils.resizeFont(pixel_font_bold, 300),
                Utils.getCenterAnchorX(0, ww, 1200), Utils.getCenterAnchorY(0, wh, 400),
                1200, 400,
                nil,
                {59, 124, 217},
                nil
            )
        },

        {
            id = "img-settings",
            drawable = ImageBox:new(
                image_list.settings_icon,
                ww - 100, 10,
                90, 90,
                nil,
                nil
            )
        },

        {
            id = "rect-uderehee",
            drawable = Rectangle:new(
                360, wh - 210,
                320, 120,
                {100, 50, 20},
                nil
            )
        },
        {
            id = "btn-uderehee",
            drawable = Button:new(
                "Uderehee", Utils.resizeFont(pixel_font, 40),
                370, wh - 200,
                300, 100,
                {237, 164, 74},
                {212, 198, 182},
                function()
                    audio_list["uderehee"]:stop()
                    audio_list["uderehee"]:play()
                end,
                nil
            )
        },

        {
            id = "rect-new-screen",
            drawable = Rectangle:new(
                790, wh - 210,
                220, 120,
                {100, 50, 20},
                nil
            )
        },
        {
            id = "btn-new-screen",
            drawable = Button:new(
                "New Screen", Utils.resizeFont(pixel_font, 30),
                800, wh - 200,
                200, 100,
                {237, 164, 74},
                {212, 198, 182},
                function()
                    Scenes:disableScenes()
                    Scenes:enableScene("game-main")
                end,
                nil
            )
        },

        {
            id = "rect-quit",
            drawable = Rectangle:new(
                1340, wh - 210,
                220, 120,
                {224, 176, 16},
                nil
            )
        },
        {
            id = "btn-quit",
            drawable = Button:new(
                "Quit", Utils.resizeFont(pixel_font, 30),
                1350, wh - 200,
                200, 100,
                {0, 0, 100},
                {255, 0, 0},
                function()
                    love.event.quit()
                end,
                nil
            )
        },

        {
            id = "text-dynamic",
            drawable = TextBox:new(
                GameState.points, Utils.resizeFont(pixel_font, 50),
                100, 100,
                200, 200,
                nil,
                {59, 124, 217},
                function (self, dt)
                    self.text = GameState.points 
                end
            )
        }
    }
}