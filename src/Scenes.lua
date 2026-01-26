---@diagnostic disable: lowercase-global
local Button = require "Button"
local audio_list = require "audio"
local Scenes = {}

-- inizializira vse elemente v love.load namesto v require stavku
function Scenes:init()
    local font = "fonts/Karma Suture.otf"

    self.Scene_list = {
        ["start-menu"] = {
            shouldDraw = true,
            buttons = {
                Button:new(
                    "Hjelo blin", getFont(font, 40),
                    50, 50, 200, 100,
                    {237, 164, 74},
                    {212, 198, 182},
                    function()
                        audio_list["uderehee"]:stop()
                        audio_list["uderehee"]:play()
                    end
                ),
                Button:new(
                    nil, nil,
                    400, 50, 200, 100,
                    {237, 164, 74},
                    {212, 198, 182},
                    function()
                        disableScenes()
                        Scenes.Scene_list["test-second"].shouldDraw = true
                    end
                )
            }
        },
        ["test-second"] = {
            shouldDraw = false,
            buttons = {
                Button:new(
                    "ABUIOABU", getFont(font, 30),
                    200, 200, 300, 200,
                    {237, 164, 74},
                    {212, 198, 182},
                    function()
                        disableScenes()
                        Scenes.Scene_list["start-menu"].shouldDraw = true
                    end
                ),
            }
        },
    }
end

function disableScenes()
    for _, scene in pairs(Scenes.Scene_list) do
        scene.shouldDraw = false
    end
end

function getFont(font, size)
    local font = love.graphics.newFont(font, size)
    return font
end

return Scenes
