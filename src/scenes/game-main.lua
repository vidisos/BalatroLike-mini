local CONSTANTS = require "src.constants"
local Scenes = require "src.Scenes"
local Drawable  = require "src.Drawable"
local Utils = require "src.Utils"
local audio_list = require "src.audio_list"
local image_list = require "src.image_list"
local GameState = require "src.GameState"
local Color     = require "src.Color"
local Options   = require "src.Options"

local LANG = require "src.LANG"
local Font = require "src.Font"

local ww = CONSTANTS.BASE_WIDTH
local wh = CONSTANTS.BASE_HEIGHT

---@type Scene
return {
    id = "game-main",
    shouldDraw = false,
    z_index = 0,
    drawables = {
        --background
        Drawable:new("rect-background", 0,
            0, 0, ww, wh
        ):Rectangle(Color.background_blue),

        --background left column
        Drawable:new("rect-left", 1,
            0, 0, 450, wh
        ):Rectangle(Color.blue),

        --title of round
        Drawable:new("text-level-title", 2,
            Utils.getCenterAnchorX(0,450,400), 30, 400,120,
            function (self, dt)
                self.text = LANG.round[GameState.current_lang] .. " " .. GameState.round
            end
        ):TextBox(
            nil,
            Font:resizeFont(Font.font_paths.pixel_font,80),
            nil,{1,1,0}
        ),

        --round requirement
        Drawable:new("rect-level-requirement-background",2,
            Utils.getCenterAnchorX(0,450,310),165,310,170
        ):Rectangle(Color.light_grey),

        Drawable:new("text-level-requirement-text",3,
            Utils.getCenterAnchorX(0,450,400),165,400,80
        ):TextBox(
            LANG.score_text,
            Font:resizeFont(Font.font_paths.pixel_font,35)
        ),

        Drawable:new("text-level-requirement-score",3,
            Utils.getCenterAnchorX(0,450,400),235,400,80,
            function(self)
                self.text = tostring(GameState.score_requirement)
            end
        ):TextBox(
            tostring(GameState.score_requirement),
            Font:resizeFont(Font.font_paths.pixel_font,80),
            Color.red
        ),

        -- current score
        Drawable:new("rect-current-score-base-background",2,
            Utils.getCenterAnchorX(0,450,400),350,400,100
        ):Rectangle({0,0,0}),

        Drawable:new("text-current-score-text",3,
            30,350,120,100
        ):TextBox(
            LANG.round_score,
            Font:resizeFont(Font.font_paths.pixel_font,30),
            {1,1,1}
        ),

        Drawable:new("rect-current-score-background",3,
            160,360,250,80
        ):Rectangle({154/255,162/255,173/255}),

        Drawable:new("text-current-score",4,
            100,350,400,100,
            function(self)
                self.text = tostring(GameState.score)
            end
        ):TextBox(
            tostring(GameState.score),
            Font:resizeFont(Font.font_paths.pixel_font,60),
            {1,1,1}
        ),

        -- selected hand
        Drawable:new("rect-selected-hand-background",2,
            Utils.getCenterAnchorX(0,450,400),470,400,220
        ):Rectangle({154/255,162/255,173/255}),

        Drawable:new("text-selected-hand",3,
            Utils.getCenterAnchorX(Utils.getCenterAnchorX(0,450,400),400,380),
            470,380,100,
            function(self)
                self.text = LANG[GameState.selected_hand]
            end
        ):TextBox(
            GameState.selected_hand,
            Font:resizeFont(Font.font_paths.pixel_font,60),
            {1,1,1}
        ),

        -- chips and mult
        Drawable:new("text-chips",3,
            40,570,160,100,
            function(self)
                self.text = tostring(GameState.chips)
            end
        ):TextBox(
            tostring(GameState.chips),
            Font:resizeFont(Font.font_paths.pixel_font,60),
            {1,1,1},
            {0,0,1},
            "right",
            -5
        ),

        Drawable:new("text-multiply-sign",3,
            Utils.getCenterAnchorX(Utils.getCenterAnchorX(0,450,400),400,50),
            595,50,50
        ):TextBox(
            "X",
            Font:resizeFont(Font.font_paths.pixel_font,60),
            {1,0,0}
        ),

        Drawable:new("text-mult",3,
            250,570,160,100,
            function(self)
                self.text = tostring(GameState.mult)
            end
        ):TextBox(
            tostring(GameState.mult),
            Font:resizeFont(Font.font_paths.pixel_font,60),
            {1,1,1},
            {1,0,0},
            "left",
            5
        ),

        -- hand count
        Drawable:new("rect-hand-count-background",2,
            25,710,175,130
        ):Rectangle({113/255,142/255,171/255}, 5, Color.black),

        Drawable:new("text-hand-count-text",3,
            Utils.getCenterAnchorX(25,175,100),725,100,30
        ):TextBox(
            LANG.hands,
            Font:resizeFont(Font.font_paths.pixel_font,30),
            {1,1,1}
        ),

        Drawable:new("text-hand-count",3,
            Utils.getCenterAnchorX(25,175,150),760,150,70,
            function(self)
                self.text = tostring(GameState.hands_remaining)
            end
        ):TextBox(
            tostring(GameState.hands_remaining),
            Font:resizeFont(Font.font_paths.pixel_font,60),
            {1,1,1},
            {70/255,79/255,84/255}
        ),

        -- discard count
        Drawable:new("rect-discard-count-background",2,
            250,710,175,130
        ):Rectangle({207/255,123/255,116/255}, 5, Color.black),

        Drawable:new("text-discard-count-text",3,
            Utils.getCenterAnchorX(250,175,140),725,140,30
        ):TextBox(
            LANG.discards,
            Font:resizeFont(Font.font_paths.pixel_font,30),
            {1,1,1}
        ),

        Drawable:new("text-discard-count",3,
            Utils.getCenterAnchorX(250,175,150),760,150,70,
            function(self)
                self.text = tostring(GameState.discards_remaining)
            end
        ):TextBox(
            tostring(GameState.discards_remaining),
            Font:resizeFont(Font.font_paths.pixel_font,60),
            {1,1,1},
            {70/255,79/255,84/255}
        ),

        --hand rankings info
        Drawable:new("btn-hand-rankings-info",2,
            35,890,150,150
        ):Button(
            LANG.ranking_info,
            Font:resizeFont(Font.font_paths.pixel_font,30),
            {237/255,164/255,74/255},
            {212/255,198/255,182/255},
            function()
                Scenes:resetScenes()
                Scenes:enableScene("start-menu")
            end,
            8,
            Color.black
        ),

        -- ante count
        Drawable:new("rect-hand-count-background",2,
            250,860,175,100
        ):Rectangle({113/255,142/255,171/255}, 5, Color.black),

        Drawable:new("text-hand-count-text",3,
            Utils.getCenterAnchorX(250,175,100),870,100,30
        ):TextBox(
            LANG.ante,
            Font:resizeFont(Font.font_paths.pixel_font,25),
            {1,1,1}
        ),

        Drawable:new("text-hand-count",3,
            Utils.getCenterAnchorX(250,175,150),900,150,50,
            function(self)
                self.text = tostring(GameState.ante) .. "/" .. tostring(GameState.ante_win)
            end
        ):TextBox(
            nil,
            Font:resizeFont(Font.font_paths.pixel_font,40),
            {1,1,1},
            {70/255,79/255,84/255}
        ),

        -- round count
        Drawable:new("rect-hand-count-background",2,
            250,970,175,100
        ):Rectangle({113/255,142/255,171/255}, 5, Color.black),

        Drawable:new("text-hand-count-text",3,
            Utils.getCenterAnchorX(250,175,100),980,100,30
        ):TextBox(
            LANG.round,
            Font:resizeFont(Font.font_paths.pixel_font,25),
            {1,1,1}
        ),

        Drawable:new("text-hand-count",3,
            Utils.getCenterAnchorX(250,175,150),1010,150,50,
            function(self)
                self.text = tostring(GameState.round)
            end
        ):TextBox(
            nil,
            Font:resizeFont(Font.font_paths.pixel_font,40),
            {1,1,1},
            {70/255,79/255,84/255}
        ),

        -- play hand
        Drawable:new("btn-play-hand",2,
            820,950,230,100
        ):Button(
            LANG.play_hand,
            Font:resizeFont(Font.font_paths.pixel_font,40),
            {237/255,164/255,74/255},
            {212/255,198/255,182/255},
            function()
                GameState:playHand()
            end,
            10,
            {1,0,0}
        ),

        -- discard
        Drawable:new("btn-discard",2,
            1200,950,230,100
        ):Button(
            LANG.discard_hand,
            Font:resizeFont(Font.font_paths.pixel_font,40),
            {237/255,164/255,74/255},
            {212/255,198/255,182/255},
            function()
                GameState:discard()
            end,
            10,
            {1,0,0}
        ),

        -- sparks background
        Drawable:new("rect-sparks",1,
            CONSTANTS.SPARKS_X - 30,CONSTANTS.SPARKS_Y - 10,CONSTANTS.SPARKS_WIDTH + 60,CONSTANTS.SPARKS_HEIGHT + 20
        ):Rectangle({105/255, 151/255, 224/255}),

        -- sparks count
        Drawable:new("text-sparks-count",1,
            CONSTANTS.SPARKS_X - 30,CONSTANTS.SPARKS_Y + CONSTANTS.SPARKS_HEIGHT + 20,100,50,
            function(self)
                self.text = #GameState:getActiveSparks() .. "/" .. GameState.spark_active_max
            end
        ):TextBox(
            nil,
            Font:resizeFont(Font.font_paths.pixel_font,40),
            {1,1,1}
        ),

        -- deck count
        Drawable:new("text-deck-count",1,
            1730,980,140,50,
            function(self)
                self.text = GameState.deck_count .. "/" .. GameState.deck_size
            end
        ):TextBox(
            nil,
            Font:resizeFont(Font.font_paths.pixel_font,40),
            {1,1,1}
        ),

        -- settings
        Drawable:new("img-settings",1,
            ww-100,10,90,90
        ):ImageBox(
            image_list.settings_icon,
            function()
                Options:open("game-main")
            end
        ),
    }
}