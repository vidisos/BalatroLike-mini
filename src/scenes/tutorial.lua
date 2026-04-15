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

local background_width = 1000
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
    )
}

local paragraph_margin = 30
local paragraph_start_x = background_x + paragraph_margin
local paragraph_start_y = background_y + paragraph_margin
local paragraph_width = background_width - (2*paragraph_margin)
local paragraph_gap = 10

local current_y = paragraph_start_y

local button = (
    Drawable:new(
        "btn-back", 1,
        Utils.getCenterAnchorX(background_x, background_width, background_width - 60), background_y + 800 - 60 - 30, background_width - 60, 60,
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

local how_to_title = (
    Drawable:new(
        "text-how-to-title", 1,
        paragraph_start_x, current_y, 250, 60
    ):TextBox(
        LANG.tutorial_how_to_title, Font:resizeFont(Font.font_paths.pixel_font, 40),
        Color.white,
        nil,
        "left"
    )
)
current_y = current_y + how_to_title.height

local how_to_desc = (
    Drawable:new(
        "text-how-to-desc", 1,
        paragraph_start_x, current_y, paragraph_width, 200
    ):TextBox(
        LANG.tutorial_how_to_desc, Font:resizeFont(Font.font_paths.pixel_font, 25),
        Color.black,
        Color.white,
        "left", 5
    )
)
current_y = current_y + how_to_desc.height + paragraph_gap

local scoring_title = (
    Drawable:new(
        "text-scoring-title", 1,
        paragraph_start_x, current_y, 200, 60
    ):TextBox(
        LANG.tutorial_scoring_title, Font:resizeFont(Font.font_paths.pixel_font, 40),
        Color.white,
        nil,
        "left"
    )
)
current_y = current_y + scoring_title.height

local scoring_desc = (
    Drawable:new(
        "text-scoring-desc", 1,
        paragraph_start_x, current_y, paragraph_width, 140
    ):TextBox(
        LANG.tutorial_scoring_desc, Font:resizeFont(Font.font_paths.pixel_font, 25),
        Color.black,
        Color.white,
        "left", 5
    )
)
current_y = current_y + scoring_desc.height + paragraph_gap

local sparks_title = (
    Drawable:new(
        "text-how-to", 1,
        paragraph_start_x, current_y, 250, 60
    ):TextBox(
        LANG.tutorial_sparks_title, Font:resizeFont(Font.font_paths.pixel_font, 40),
        Color.white,
        nil,
        "left"
    )
)
current_y = current_y + sparks_title.height

local sparks_desc = (
    Drawable:new(
        "text-how-to", 1,
        paragraph_start_x, current_y, paragraph_width, 110
    ):TextBox(
        LANG.tutorial_sparks_desc, Font:resizeFont(Font.font_paths.pixel_font, 25),
        Color.black,
        Color.white,
        "left", 5
    )
)

table.insert(Tutorial.drawables, button)
table.insert(Tutorial.drawables, how_to_title)
table.insert(Tutorial.drawables, how_to_desc)
table.insert(Tutorial.drawables, scoring_title)
table.insert(Tutorial.drawables, scoring_desc)
table.insert(Tutorial.drawables, sparks_title)
table.insert(Tutorial.drawables, sparks_desc)


return Tutorial