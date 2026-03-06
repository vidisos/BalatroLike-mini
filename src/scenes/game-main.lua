local CONSTANTS = require "src.CONSTANTS"
local Scenes = require "src.Scenes"
local Drawable  = require "src.Drawable"
local Utils = require "src.Utils"
local audio_list = require "src.audio_list"
local image_list = require "src.image_list"
local GameState = require "src.GameState"
local LANG = require "src.LANG"

local pixel_font = "src/fonts/Karma Suture.otf"
local pixel_font_bold = "src/fonts/Karma Future.otf"
local ww = CONSTANTS.BASE_WIDTH
local wh = CONSTANTS.BASE_HEIGHT

-- adding extensions to the Drawable superclass
Drawable.ImageBox = require("src.ImageBox").ImageBox
Drawable.Rectangle = require("src.Rectangle").Rectangle
Drawable.TextBox = require("src.TextBox").TextBox
Drawable.Button = require("src.Button").Button
Drawable.Card = require("src.Card").Card

---@class Scene
return {
    id = "game-main",
    shouldDraw = false,
    isClickable = true,
    z_index = 0,
    drawables = {
        --background
        {
            id = "rect-background",
            z_index = 0,
            drawable = Drawable:new(0, 0, ww, wh):Rectangle({96, 168, 209})
        },

        --background left column
        {
            id = "rect-left",
            z_index = 1,
            drawable = Drawable:new(0, 0, 450, wh):Rectangle({50, 100, 200})
        },

        --title of level
        {
            id = "text-level-title",
            z_index = 2,
            drawable = Drawable:new(Utils.getCenterAnchorX(0, 450, 400), 50, 400, 120):TextBox(
                LANG:getCurrentLevelText(), Utils.resizeFont(pixel_font, 80),
                nil, {255, 255, 0}
            )
        },

        --level requirement
        {
            id = "rect-level-requirement-background",
            z_index = 2,
            drawable = Drawable:new(Utils.getCenterAnchorX(0, 450, 310), 200, 310, 190):Rectangle(
                {111, 123, 143}
            )
        },
        {
            id = "text-level-requirement-text",
            z_index = 3,
            drawable = Drawable:new(Utils.getCenterAnchorX(0, 450, 400), 200, 400, 100):TextBox(
                LANG.score_text, Utils.resizeFont(pixel_font, 35),
                nil, nil
            )
        },
        {
            id = "text-level-requirement-score",
            z_index = 3,
            drawable = Drawable:new(Utils.getCenterAnchorX(0, 450, 400), 270, 400, 100, 
                function (self, dt) 
                    self.text = tostring(GameState.score_requirement)
                end
                ):TextBox(
                tostring(GameState.score_requirement), Utils.resizeFont(pixel_font, 80),
                {240, 67, 67}, nil
            )
        },


        --current score
        {
            id = "rect-current-score-base-background",
            z_index = 2,
            drawable = Drawable:new(Utils.getCenterAnchorX(0, 450, 400), 400, 400, 100):Rectangle({0, 0, 0})
        },
        {
            id = "text-current-score-text",
            z_index = 3,
            drawable = Drawable:new(40, 400, 100, 100):TextBox(
                LANG.round_score, Utils.resizeFont(pixel_font, 30),
                {255, 255, 255}, nil
            )
        },
        {
            id = "rect-current-score-background",
            z_index = 3,
            drawable = Drawable:new(160, 410, 250, 80):Rectangle({154, 162, 173})
        },
        {
            id = "text-current-score",
            z_index = 4,
            drawable = Drawable:new(100, 400, 400, 100, 
                function (self, dt)
                    self.text = tostring(GameState.score)
                end
                ):TextBox(
                tostring(GameState.score), Utils.resizeFont(pixel_font, 60),
                {255, 255, 255}, nil
            )
        },

        --selected hand
        {
            id = "rect-selected-hand-background",
            z_index = 2,
            drawable = Drawable:new(Utils.getCenterAnchorX(0, 450, 400), 525, 400, 220):Rectangle({154, 162, 173})
        },
        {
            id = "text-selected-hand",
            z_index = 3,
            drawable = Drawable:new(Utils.getCenterAnchorX(Utils.getCenterAnchorX(0, 450, 400), 400, 200), 525, 200, 100,
                function (self, dt)
                    self.text = LANG[GameState.selected_hand]
                end
                ):TextBox(
                GameState.selected_hand, Utils.resizeFont(pixel_font, 60),
                {255, 255, 255}, nil
            )
        },
        {
            id = "text-chips",
            z_index = 3,
            drawable = Drawable:new(40, 625, 160, 100,
                function (self, dt)
                    self.text = tostring(GameState.chips)
                end
                ):TextBox(
                tostring(GameState.chips), Utils.resizeFont(pixel_font, 60),
                {255, 255, 255}, {0, 0, 255}, "right"
            )
        },
        {
            id = "text-multiply-sign",
            z_index = 3,
            drawable = Drawable:new(Utils.getCenterAnchorX(Utils.getCenterAnchorX(0, 450, 400), 400, 50), 650, 50, 50):TextBox(
                "X", Utils.resizeFont(pixel_font, 60),
                {255, 0, 0}, nil
            )
        },
        {
            id = "text-mult",
            z_index = 3,
            drawable = Drawable:new(250, 625, 160, 100,
                function (self, dt)
                    self.text = tostring(GameState.mult)
                end
                ):TextBox(
                tostring(GameState.mult), Utils.resizeFont(pixel_font, 60),
                {255, 255, 255}, {255, 0, 0}, "left"
            )
        },

        --hand count
        {
            id = "rect-hand-count-background",
            z_index = 10,
            drawable = Drawable:new(25, 780, 175, 130):Rectangle({113, 142, 171})
        },
        {
            id = "text-hand-count-text",
            z_index = 11,
            drawable = Drawable:new(Utils.getCenterAnchorX(25, 175, 50), 790, 50, 30):TextBox(
                LANG.hands, Utils.resizeFont(pixel_font, 30),
                {255, 255, 255}, nil
            )
        },
        {
            id = "text-hand-count",
            z_index = 11,
            drawable = Drawable:new(Utils.getCenterAnchorX(25, 175, 150), 830, 150, 70,
                function (self, dt)
                    self.text = tostring(GameState.hands_remaining)
                end
                ):TextBox(
                tostring(GameState.hands_remaining), Utils.resizeFont(pixel_font, 60),
                {255, 255, 255}, {70, 79, 84}
            )
        },

        --discard count
        {
            id = "rect-discard-count-background",
            z_index = 10,
            drawable = Drawable:new(250, 780, 175, 130):Rectangle({207, 123, 116})
        },
        {
            id = "text-discard-count-text",
            z_index = 11,
            drawable = Drawable:new(Utils.getCenterAnchorX(250, 175, 50), 790, 50, 30):TextBox(
                LANG.discards, Utils.resizeFont(pixel_font, 30),
                {255, 255, 255}, nil
            )
        },
        {
            id = "text-discard-count",
            z_index = 11,
            drawable = Drawable:new(Utils.getCenterAnchorX(250, 175, 150), 830, 150, 70,
                function (self, dt)
                    self.text = tostring(GameState.discards_remaining)
                end
                ):TextBox(
                tostring(GameState.discards_remaining), Utils.resizeFont(pixel_font, 60),
                {255, 255, 255}, {70, 79, 84}
            )
        },

        --hand rankings info
        {
            id = "btn-hand-rankings-info",
            z_index = 2,
            drawable = Drawable:new(Utils.getCenterAnchorX(0, 450, 200), 940, 200, 115):Button(
                LANG.ranking_info, Utils.resizeFont(pixel_font, 40),
                {237, 164, 74},
                {212, 198, 182},
                function()
                    Scenes:disableScenes()
                    Scenes:enableScene("start-menu")
                end
            )
        },

        --play hand button
        {
            id = "btn-play-hand",
            z_index = 2,
            drawable = Drawable:new(820, 950, 230, 100):Button(
                LANG.play_hand, Utils.resizeFont(pixel_font, 40),
                {237, 164, 74},
                {212, 198, 182},
                function()
                    GameState:playHand()
                end,
                10,
                {255, 0, 0}
            )
        },

        --discard button
        {
            id = "btn-discard",
            z_index = 2,
            drawable = Drawable:new(1200, 950, 230, 100):Button(
                LANG.discard_hand, Utils.resizeFont(pixel_font, 40),
                {237, 164, 74},
                {212, 198, 182},
                function()
                    GameState:discard()
                end,
                10,
                {255, 0, 0}
            )
        },

        --deck count
        {
            id = "text-deck-count",
            z_index = 1,
            drawable = Drawable:new(1780, 980, 50, 50,
                function (self, dt)
                    self.text = GameState.deck_count .. "/" .. GameState.deck_size
                end
                ):TextBox(
                nil, Utils.resizeFont(pixel_font, 40),
                {255, 255, 255}, nil
            )
        },

        --misc
        {
            id = "img-settings",
            z_index = 1,
            drawable = Drawable:new(ww-100, 10, 90, 90):ImageBox(
                image_list.settings_icon,
                function ()
                    if audio_list.background_music:isPlaying() then
                        audio_list.background_music:pause()
                    else
                        audio_list.background_music:play()
                    end
                end
            )
        },
    }
}