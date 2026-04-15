local CONSTANTS = require "src.constants"
local Scenes = require "src.Scenes"
local Drawable  = require "src.Drawable"
local Utils = require "src.Utils"
local Audio = require "src.Audio"
local Color     = require "src.Color"

local LANG = require "src.LANG"
local Font = require "src.Font"

local ww = CONSTANTS.BASE_WIDTH
local wh = CONSTANTS.BASE_HEIGHT

local background_width = 800
local background_height = 800
local background_x = Utils.getCenterAnchorX(0, ww, background_width)
local background_y = Utils.getCenterAnchorY(0, wh, background_height)

---@type Scene
local Tutorial = {}

Tutorial.id = "tutorial"
Tutorial.shouldDraw = false
Tutorial.z_index = 3

Tutorial.drawables = {
    -- background
    Drawable:new(
        "rect-background", 0,
        background_x, background_y, background_width, background_height
    ):Rectangle(
        Color.dark_grey,
        6, Color.light_grey
    ),
}

local background = (
    Drawable:new(
        "btn-back", 1,
        Utils.getCenterAnchorX(Utils.getCenterAnchorX(0, ww, 800), 800, 700), Utils.getCenterAnchorY(0, wh, 800) + 800 - 60 - 30, 700, 60,
        nil,
        nil,
        function (self) self.color = Color:tintColor(self.base_color, 0.8) end,
        function (self) self.color = self.base_color end
    ):Button(
        LANG.back, Font:resizeFont(Font.font_paths.pixel_font, 30),
        Color.white,
        Color.orange,
        function (self)
            Audio:playSound(Audio.sfx.button_click_back)

            Scenes:enableAllSceneInteractions()
            Scenes:disableScene("tutorial")
        end
    )
)

table.insert(Tutorial.drawables, background)


return Tutorial