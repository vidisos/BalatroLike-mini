local CONSTANTS = require "src.constants"
local Scenes = require "src.Scenes"
local Drawable  = require "src.Drawable"
local Utils = require "src.Utils"
local audio_list = require "src.audio_list"
local image_list = require "src.image_list"
local card_list = require "src.card_list"
local GameState = require "src.GameState"
local Color     = require "src.Color"

local LANG = require "src.LANG"
local Font = require "src.Font"
local current_lang = GameState.current_lang

local ww = CONSTANTS.BASE_WIDTH
local wh = CONSTANTS.BASE_HEIGHT

local start_menu_height = 350
local game_main_height = 700

---@type Options
local Options = {}
Options.id = "options"
Options.shouldDraw = false
Options.z_index = 3
Options.drawables = {
    -- background
    Drawable:new("rect-background", 0,
        Utils.getCenterAnchorX(0, ww, 600), Utils.getCenterAnchorY(0, wh, game_main_height), 600, game_main_height
    ):Rectangle(Color.light_grey, 10),

    -- Setting text
    Drawable:new(
        "text-settings-title", 1,
        Utils.getCenterAnchorX(Utils.getCenterAnchorX(0, ww, 600), 600, 300), Utils.getCenterAnchorY(0, wh, game_main_height) + 20, 300, 50
    ):TextBox(
        LANG.settings, Font:resizeFont(Font.font_paths.pixel_font, 50)
    ),

    -- background music volume slider
    Drawable:new(
        "slider-background-volume-text", 1,
        Utils.getCenterAnchorX(0, ww, 600), Utils.getCenterAnchorY(0, wh, game_main_height) + 100, 300, 50
    ):TextBox(
        LANG.background_music, Font:resizeFont(Font.font_paths.pixel_font, 25),
        nil, nil, "left", 20
    ),
    Drawable:new(
        "slider-background-volume", 1,
        Utils.getCenterAnchorX(0, ww, 600)+310, Utils.getCenterAnchorY(0, wh, game_main_height) + 100, 240, 50,
        nil,
        nil,
        function (self) self.color = Color.dark_grey end,
        function (self) self.color = self.base_color end
    ):Slider(
        nil,
        1, 0, 0.1,
        function(v)
            audio_list.background_music:setVolume(v)
        end
    ),

    --TODO mek sound effect work and stuff
    -- sound effects volume slider
    Drawable:new(
        "slider-sound-effects-volume-text", 1,
        Utils.getCenterAnchorX(0, ww, 600), Utils.getCenterAnchorY(0, wh, game_main_height) + 200, 300, 50
    ):TextBox(
        LANG.sound_effects, Font:resizeFont(Font.font_paths.pixel_font, 25),
        nil, nil, "left", 20
    ),
    Drawable:new(
        "slider-sound-effects-volume", 1,
        Utils.getCenterAnchorX(0, ww, 600)+280, Utils.getCenterAnchorY(0, wh, game_main_height) + 200, 270, 50,
        nil,
        nil,
        function (self) self.color = Color.dark_grey end,
        function (self) self.color = self.base_color end
    ):Slider(
        nil,
        1, 0, 0.1,
        function(v)
            audio_list.background_music:setVolume(v)
        end
    ),

    -- back
    Drawable:new(
        "btn-back", 1,
        Utils.getCenterAnchorX(Utils.getCenterAnchorX(0, ww, 600), 600, 500), Utils.getCenterAnchorY(0, wh, game_main_height) + 300, 500, 60,
        nil,
        nil,
        function (self) self.color = Color.dark_grey end,
        function (self) self.color = self.base_color end
    ):Button(
        LANG.back, Font:resizeFont(Font.font_paths.pixel_font, 20),
        Color.black,
        Color.dark_orange,
        function (self)
            Options:close()
        end,
        2,
        {100/255, 50/255, 20/255}
    ),

    -- new game
    Drawable:new(
        "btn-start", 1,
        Utils.getCenterAnchorX(Utils.getCenterAnchorX(0, ww, 600), 600, 400), Utils.getCenterAnchorY(0, wh, game_main_height) + 270, 400, 100,
        nil,
        nil,
        function (self) self.color = Color.dark_grey end,
        function (self) self.color = self.base_color end
    ):Button(
        LANG.new_game, Font:resizeFont(Font.font_paths.pixel_font, 50),
        {237/255, 164/255, 74/255},
        {212/255, 198/255, 182/255},
        function (self)
            Scenes:resetScenes()
            Scenes:enableScene("game-main")
            GameState:startNewGame()
            Options:close()
        end,
        10,
        {100/255, 50/255, 20/255}
    ),

    -- main menu
    Drawable:new(
        "btn-start-menu", 1,
        Utils.getCenterAnchorX(Utils.getCenterAnchorX(0, ww, 600), 600, 400), Utils.getCenterAnchorY(0, wh, game_main_height) + 380, 400, 100,
        nil,
        nil,
        function (self) self.color = Color.dark_grey end,
        function (self) self.color = self.base_color end
    ):Button(
        LANG.to_main_menu, Font:resizeFont(Font.font_paths.pixel_font, 50),
        {237/255, 164/255, 74/255},
        {212/255, 198/255, 182/255},
        function (self)
            Scenes:resetScenes()
            Scenes:enableScene("start-menu")
            Options:close()
        end,
        10,
        {100/255, 50/255, 20/255}
    ),


    -- language button
    Drawable:new(
        "btn-change-lang", 1,
        Utils.getCenterAnchorX(Utils.getCenterAnchorX(0, ww, 600), 600, 400), Utils.getCenterAnchorY(0, wh, game_main_height) + 490, 400, 100,
        nil,
        nil,
        function (self) self.color = Color.dark_grey end,
        function (self) self.color = self.base_color end
    ):Button(
        LANG.language, Font:resizeFont(Font.font_paths.pixel_font, 30),
        {0, 0, 100/255},
        {1, 0, 0},
        function(self)
            GameState:changeLang()
        end
    )
}
Options.source = ""

---toggles between opened and closed options
---@param source? string
function Options:toggle(source)
    if self.source == "" then
        self:open(source)
    else
        self:close()
    end
end

---opens the options menu and changes depending on if its on start menu
---@param source string
function Options:open(source)
    self.source = source
    Scenes:disableAllSceneInteractions()
    Scenes:enableScene("options")
    Scenes:enableSceneInteractions("options")
    Scenes:enableItemClicks(source, "img-settings")

    local background = Scenes:getDrawable("options", "rect-background")

    if self.source == "start-menu" then
        background.height = start_menu_height

        Scenes:getDrawable("options", "btn-start-menu").shouldDraw = false
        Scenes:getDrawable("options", "btn-start").shouldDraw = false
        Scenes:getDrawable("options", "btn-change-lang").shouldDraw = false
    else
        background.height = game_main_height

        Scenes:getDrawable("options", "btn-start-menu").shouldDraw = true
        Scenes:getDrawable("options", "btn-start").shouldDraw = true
        Scenes:getDrawable("options", "btn-change-lang").shouldDraw = true
    end

    local back_button = Scenes:getDrawable("options", "btn-back")
    back_button.y = (background.y + background.height - 20) - back_button.height
end

---closes the options
function Options:close()
    Scenes:enableAllSceneInteractions()
    Scenes:disableScene("options")
    self.source = ""
end


return Options