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

---@type Scene
return {
    id = "game-main",
    shouldDraw = false,
    isClickable = true,
    z_index = 0,
    drawables = {
        --background
        Drawable:new("rect-background", 0,
            0, 0, ww, wh
        ):Rectangle({96,168,209}),

        --background left column
        Drawable:new("rect-left", 1,
            0, 0, 450, wh
        ):Rectangle({50,100,200}),

        --title of level
        Drawable:new("text-level-title", 2,
            Utils.getCenterAnchorX(0,450,400), 50, 400,120
        ):TextBox(
            LANG:getCurrentLevelText(),
            Utils.resizeFont(pixel_font,80),
            nil,{255,255,0}
        ),

        --level requirement
        Drawable:new("rect-level-requirement-background",2,
            Utils.getCenterAnchorX(0,450,310),200,310,190
        ):Rectangle({111,123,143}),

        Drawable:new("text-level-requirement-text",3,
            Utils.getCenterAnchorX(0,450,400),200,400,100
        ):TextBox(
            LANG.score_text,
            Utils.resizeFont(pixel_font,35)
        ),

        Drawable:new("text-level-requirement-score",3,
            Utils.getCenterAnchorX(0,450,400),270,400,100,
            function(self)
                self.text = tostring(GameState.score_requirement)
            end
        ):TextBox(
            tostring(GameState.score_requirement),
            Utils.resizeFont(pixel_font,80),
            {240,67,67}
        ),

        --current score
        Drawable:new("rect-current-score-base-background",2,
            Utils.getCenterAnchorX(0,450,400),400,400,100
        ):Rectangle({0,0,0}),

        Drawable:new("text-current-score-text",3,
            40,400,100,100
        ):TextBox(
            LANG.round_score,
            Utils.resizeFont(pixel_font,30),
            {255,255,255}
        ),

        Drawable:new("rect-current-score-background",3,
            160,410,250,80
        ):Rectangle({154,162,173}),

        Drawable:new("text-current-score",4,
            100,400,400,100,
            function(self)
                self.text = tostring(GameState.score)
            end
        ):TextBox(
            tostring(GameState.score),
            Utils.resizeFont(pixel_font,60),
            {255,255,255}
        ),

        --selected hand
        Drawable:new("rect-selected-hand-background",2,
            Utils.getCenterAnchorX(0,450,400),525,400,220
        ):Rectangle({154,162,173}),

        Drawable:new("text-selected-hand",3,
            Utils.getCenterAnchorX(Utils.getCenterAnchorX(0,450,400),400,200),
            525,200,100,
            function(self)
                self.text = LANG[GameState.selected_hand]
            end
        ):TextBox(
            GameState.selected_hand,
            Utils.resizeFont(pixel_font,60),
            {255,255,255}
        ),

        Drawable:new("text-chips",3,
            40,625,160,100,
            function(self)
                self.text = tostring(GameState.chips)
            end
        ):TextBox(
            tostring(GameState.chips),
            Utils.resizeFont(pixel_font,60),
            {255,255,255},
            {0,0,255},
            "right"
        ),

        Drawable:new("text-multiply-sign",3,
            Utils.getCenterAnchorX(Utils.getCenterAnchorX(0,450,400),400,50),
            650,50,50
        ):TextBox(
            "X",
            Utils.resizeFont(pixel_font,60),
            {255,0,0}
        ),

        Drawable:new("text-mult",3,
            250,625,160,100,
            function(self)
                self.text = tostring(GameState.mult)
            end
        ):TextBox(
            tostring(GameState.mult),
            Utils.resizeFont(pixel_font,60),
            {255,255,255},
            {255,0,0},
            "left"
        ),

        --hand count
        Drawable:new("rect-hand-count-background",10,
            25,780,175,130
        ):Rectangle({113,142,171}),

        Drawable:new("text-hand-count-text",11,
            Utils.getCenterAnchorX(25,175,50),790,50,30
        ):TextBox(
            LANG.hands,
            Utils.resizeFont(pixel_font,30),
            {255,255,255}
        ),

        Drawable:new("text-hand-count",11,
            Utils.getCenterAnchorX(25,175,150),830,150,70,
            function(self)
                self.text = tostring(GameState.hands_remaining)
            end
        ):TextBox(
            tostring(GameState.hands_remaining),
            Utils.resizeFont(pixel_font,60),
            {255,255,255},
            {70,79,84}
        ),

        --discard count
        Drawable:new("rect-discard-count-background",10,
            250,780,175,130
        ):Rectangle({207,123,116}),

        Drawable:new("text-discard-count-text",11,
            Utils.getCenterAnchorX(250,175,50),790,50,30
        ):TextBox(
            LANG.discards,
            Utils.resizeFont(pixel_font,30),
            {255,255,255}
        ),

        Drawable:new("text-discard-count",11,
            Utils.getCenterAnchorX(250,175,150),830,150,70,
            function(self)
                self.text = tostring(GameState.discards_remaining)
            end
        ):TextBox(
            tostring(GameState.discards_remaining),
            Utils.resizeFont(pixel_font,60),
            {255,255,255},
            {70,79,84}
        ),

        --hand rankings info
        Drawable:new("btn-hand-rankings-info",2,
            Utils.getCenterAnchorX(0,450,200),940,200,115
        ):Button(
            LANG.ranking_info,
            Utils.resizeFont(pixel_font,40),
            {237,164,74},
            {212,198,182},
            function()
                Scenes:disableScenes()
                Scenes:enableScene("start-menu")
            end
        ),

        --play hand
        Drawable:new("btn-play-hand",2,
            820,950,230,100
        ):Button(
            LANG.play_hand,
            Utils.resizeFont(pixel_font,40),
            {237,164,74},
            {212,198,182},
            function()
                GameState:playHand()
            end,
            10,
            {255,0,0}
        ),

        --discard
        Drawable:new("btn-discard",2,
            1200,950,230,100
        ):Button(
            LANG.discard_hand,
            Utils.resizeFont(pixel_font,40),
            {237,164,74},
            {212,198,182},
            function()
                GameState:discard()
            end,
            10,
            {255,0,0}
        ),

        --deck count
        Drawable:new("text-deck-count",1,
            1780,980,50,50,
            function(self)
                self.text = GameState.deck_count .. "/" .. GameState.deck_size
            end
        ):TextBox(
            nil,
            Utils.resizeFont(pixel_font,40),
            {255,255,255}
        ),

        --settings
        Drawable:new("img-settings",1,
            ww-100,10,90,90
        ):ImageBox(
            image_list.settings_icon,
            function()
                if audio_list.background_music:isPlaying() then
                    audio_list.background_music:pause()
                else
                    audio_list.background_music:play()
                end
            end
        ),
    }
}