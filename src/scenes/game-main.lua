local CONSTANTS = require "src.constants"
local Scenes = require "src.Scenes"
local Drawable  = require "src.Drawable"
local Utils = require "src.Utils"
local image_list = require "src.image_list"
local GameState = require "src.GameState"
local Color     = require "src.Color"
local Options   = require "src.Options"
local Audio     = require "src.Audio"

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
        ):Rectangle(Color.blue),

        --background left column
        Drawable:new("rect-left", 1,
            0, 0, 450, wh
        ):Rectangle(Color.grey),

        --title of round
        Drawable:new("text-level-title", 2,
            Utils.getCenterAnchorX(0,450,400), 30, 400,120,
            function (self, dt)
                self.text = GameState:getStageTitleText()
                if self.text == LANG.small then
                    self.color = Color.dark_blue
                elseif self.text == LANG.medium then
                    self.color = Color.dark_orange
                elseif self.text == LANG.big then
                    self.color = Color.red
                end
            end
        ):TextBox(
            nil,
            Font:resizeFont(Font.font_paths.pixel_font,80),
            Color.white
        ),

        --round requirement
        Drawable:new("rect-level-requirement-background",2,
            Utils.getCenterAnchorX(0,450,310),165,310,170
        ):Rectangle(Color.dark_grey),

        Drawable:new("text-level-requirement-text",3,
            Utils.getCenterAnchorX(0,450,400),165,400,80
        ):TextBox(
            LANG.score_text,
            Font:resizeFont(Font.font_paths.pixel_font,35),
            Color.white
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
        ):Rectangle(Color.dark_grey),

        Drawable:new("text-current-score-text",3,
            30,350,120,100
        ):TextBox(
            LANG.round_score,
            Font:resizeFont(Font.font_paths.pixel_font,30),
            Color.white
        ),

        Drawable:new("text-current-score",4,
            Utils.getCenterAnchorX(0,450,400) + 130, 350 + 10,
            260,80,
            function(self)
                self.text = tostring(GameState.score)
            end
        ):TextBox(
            tostring(GameState.score),
            Font:resizeFont(Font.font_paths.pixel_font,60),
            Color.white,
            Color.grey
        ),

        -- selected hand
        Drawable:new("rect-selected-hand-background",2,
            Utils.getCenterAnchorX(0,450,400),470,400,220
        ):Rectangle(Color.dark_grey),

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
            Color.white,
            Color.light_blue,
            "right",
            -5
        ),

        Drawable:new("text-multiply-sign",3,
            Utils.getCenterAnchorX(Utils.getCenterAnchorX(0,450,400),400,50),
            595,50,50
        ):TextBox(
            "X",
            Font:resizeFont(Font.font_paths.pixel_font,60),
            Color.red
        ),

        Drawable:new("text-mult",3,
            250,570,160,100,
            function(self)
                self.text = tostring(GameState.mult)
            end
        ):TextBox(
            tostring(GameState.mult),
            Font:resizeFont(Font.font_paths.pixel_font,60),
            Color.white,
            Color.red,
            "left",
            5
        ),

        -- hand count
        Drawable:new("rect-hand-count-background",2,
            25,710,175,130
        ):Rectangle(Color.dark_grey),

        Drawable:new("text-hand-count-text",3,
            Utils.getCenterAnchorX(25,175,100),725,100,30
        ):TextBox(
            LANG.hands, Font:resizeFont(Font.font_paths.pixel_font,30),
            Color.white
        ),

        Drawable:new("text-hand-count",3,
            Utils.getCenterAnchorX(25,175,150),760,150,70,
            function(self)
                self.text = tostring(GameState.hands_remaining)
            end
        ):TextBox(
            tostring(GameState.hands_remaining),
            Font:resizeFont(Font.font_paths.pixel_font,60),
            Color.light_blue,
            Color.grey
        ),

        -- discard count
        Drawable:new("rect-discard-count-background",2,
            250,710,175,130
        ):Rectangle(Color.dark_grey),

        Drawable:new("text-discard-count-text",3,
            Utils.getCenterAnchorX(250,175,140),725,140,30
        ):TextBox(
            LANG.discards,
            Font:resizeFont(Font.font_paths.pixel_font,30),
            Color.white
        ),

        Drawable:new("text-discard-count",3,
            Utils.getCenterAnchorX(250,175,150),760,150,70,
            function(self)
                self.text = tostring(GameState.discards_remaining)
            end
        ):TextBox(
            tostring(GameState.discards_remaining),
            Font:resizeFont(Font.font_paths.pixel_font,60),
            Color.red,
            Color.grey
        ),

        --hand rankings info
        Drawable:new("btn-hand-rankings-info",2,
            25,850,200,130,
            nil,
            nil,
            function (self) self.color = Color:tintColor(self.base_color, 0.8) end,
            function (self) self.color = self.base_color end
        ):Button(
            LANG.ranking_info,
            Font:resizeFont(Font.font_paths.pixel_font,40),
            Color.white,
            Color.orange,
            function()
                Audio:playSound(Audio.sfx.button_click)

                Scenes:disableAllSceneInteractions()
                Scenes:enableSceneInteractions("hand-rankings")
                Scenes:enableScene("hand-rankings")
            end,
            8,
            Color.dark_orange
        ),

        --rules
        Drawable:new("btn-rules",2,
            25,990,200,85,
            nil,
            nil,
            function (self) self.color = Color:tintColor(self.base_color, 0.8) end,
            function (self) self.color = self.base_color end
        ):Button(
            "Pravila",
            Font:resizeFont(Font.font_paths.pixel_font,40),
            Color.white,
            Color.orange,
            function()
                Audio:playSound(Audio.sfx.button_click)
                
            end,
            8,
            Color.dark_orange
        ),

        -- ante count
        Drawable:new("rect-hand-count-background",2,
            Utils.getCenterAnchorX(250, 175, 140),850,140,100
        ):Rectangle(
            Color.dark_grey
        ),

        Drawable:new("text-hand-count-text",3,
            Utils.getCenterAnchorX(Utils.getCenterAnchorX(250, 175, 140),140,75),855,75,30
        ):TextBox(
            LANG.ante, Font:resizeFont(Font.font_paths.pixel_font,25),
            Color.white
        ),

        Drawable:new("text-hand-count",3,
            Utils.getCenterAnchorX(Utils.getCenterAnchorX(250, 175, 140),140,110),890,110,50,
            function(self)
                self.text = {Color.orange, tostring(GameState.ante), Color.white, "/" .. tostring(GameState.ante_win)}
            end
        ):TextBox(
            nil,
            Font:resizeFont(Font.font_paths.pixel_font,40),
            Color.white,
            Color.grey
        ),

        -- round count
        Drawable:new("rect-round-count-background",2,
            Utils.getCenterAnchorX(250, 175, 140),960,140,100
        ):Rectangle(Color.dark_grey),

        Drawable:new("text-round-count-text",3,
            Utils.getCenterAnchorX(Utils.getCenterAnchorX(250, 175, 140), 140, 100),965,100,30
        ):TextBox(
            LANG.round, Font:resizeFont(Font.font_paths.pixel_font,25),
            Color.white
        ),

        Drawable:new("text-round-count",3,
            Utils.getCenterAnchorX(Utils.getCenterAnchorX(250, 175, 140),140,110),1000,110,50,
            function(self)
                self.text = tostring(GameState.round)
            end
        ):TextBox(
            nil,
            Font:resizeFont(Font.font_paths.pixel_font,45),
            Color.orange,
            Color.grey
        ),

        -- play hand
        Drawable:new("btn-play-hand",2,
            820,950,230,100,
            nil,
            nil,
            function (self) self.color = Color:tintColor(self.base_color, 0.8) end,
            function (self) self.color = self.base_color end
        ):Button(
            LANG.play_hand,
            Font:resizeFont(Font.font_paths.pixel_font,40),
            Color.white,
            Color.dark_blue,
            function()
                GameState:playHand()
            end,
            5,
            Color.dark_grey
        ),

        -- discard
        Drawable:new("btn-discard",2,
            1200,950,230,100,
            nil,
            nil,
            function (self) self.color = Color:tintColor(self.base_color, 0.8) end,
            function (self) self.color = self.base_color end
        ):Button(
            LANG.discard_hand,
            Font:resizeFont(Font.font_paths.pixel_font,40),
            Color.white,
            Color.red,
            function()
                GameState:discard()
            end,
            5,
            Color.dark_grey
        ),

        -- sparks background
        Drawable:new("rect-sparks",1,
            CONSTANTS.SPARKS_X - 10,CONSTANTS.SPARKS_Y - 10,CONSTANTS.SPARKS_WIDTH + 20,CONSTANTS.SPARKS_HEIGHT + 20
        ):ImageBox(image_list.sparks_background),

        -- sparks count
        Drawable:new("text-sparks-count",1,
            CONSTANTS.SPARKS_X - 10,CONSTANTS.SPARKS_Y + CONSTANTS.SPARKS_HEIGHT + 20,100,50,
            function(self)
                self.text = #GameState:getActiveSparks() .. "/" .. GameState.spark_active_max
            end
        ):TextBox(
            nil,
            Font:resizeFont(Font.font_paths.pixel_font,40),
            Color.white
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
            Color.white
        ),

        -- settings
        Drawable:new("img-settings",1,
            ww-100,10,90,90,
            nil,
            nil,
            function (self) self.color = Color.light_grey end,
            function (self) self.color = self.base_color end
        ):ImageBox(
            image_list.settings_icon,
            function()
                Audio:playSound(Audio.sfx.button_click)

                Options:toggle("game-main")
            end
        ),
    }
}