---@diagnostic disable: lowercase-global
local Button = require "Button"
local TextBox = require "TextBox"
local Rectangle = require "Rectangle"
local Utils = require "Utils"
local audio_list = require "audio"
local Scenes = {}

-- inizializira vse elemente v love.load namesto v require stavku
function Scenes:init()
    local pixel_font = "fonts/Karma Suture.otf"
    local pixel_font_bold = "fonts/Karma Future.otf"
    local ww, wh = love.graphics.getDimensions()

    -- ne najde background_ music kot bljižnico for some reason (audio_list. *avtomatsko da*)
    local background_music = audio_list.background_music
    background_music:setVolume(0.04)
    background_music:setLooping(true)
    background_music:play()

    self.scene_list = {
        ["start-menu"] = {
            shouldDraw = true,
            drawables = {
                Rectangle:new(
                    0, 0,
                    ww, wh,
                    {59, 124, 217}
                ),

                TextBox:new(
                    "Poinker", Utils.resizeFont(pixel_font_bold, 300),
                    Utils.getCenterAnchorX(0, ww, 1200), Utils.getCenterAnchorY(0, wh, 400),
                    1200, 400,
                    nil,
                    {59, 124, 217}
                ),

                -- uderehee
                Rectangle:new(
                    360, wh - 210,
                    320, 120,
                    {100, 50, 20}
                ),
                Button:new(
                    "Uderehee", Utils.resizeFont(pixel_font, 40),
                    370, wh - 200,
                    300, 100,
                    {237, 164, 74},
                    {212, 198, 182},
                    function()
                        audio_list["uderehee"]:stop()
                        audio_list["uderehee"]:play()
                    end
                ),

                Rectangle:new(
                    790, wh - 210,
                    220, 120,
                    {100, 50, 20}
                ),
                -- new screen
                Button:new(
                    "New Screen", Utils.resizeFont(pixel_font, 30),
                    800, wh - 200,
                    200, 100,
                    {237, 164, 74},
                    {212, 198, 182},
                    function()
                        disableScenes()
                        Scenes.scene_list["test-second"].shouldDraw = true
                    end
                ),

                -- quit
                Rectangle:new(
                    1340, wh - 210,
                    220, 120,
                    {224, 176, 16}
                ),
                Button:new(
                    "Quit", Utils.resizeFont(pixel_font, 30),
                    1350, wh - 200,
                    200, 100,
                    {0, 0, 100},
                    {255, 0, 0},
                    function()
                        love.event.quit()
                    end
                ),
            }
        },
        ["test-second"] = {
            shouldDraw = false,
            drawables = {
                Button:new(
                    "ABUIOABU", Utils.resizeFont(pixel_font, 30),
                    200, 200, 300, 200,
                    {237, 164, 74},
                    {212, 198, 182},
                    function()
                        disableScenes()
                        Scenes.scene_list["start-menu"].shouldDraw = true
                    end
                ),
            }
        },
    }
end

function disableScenes()
    for _, scene in pairs(Scenes.scene_list) do
        scene.shouldDraw = false
    end
end

return Scenes
