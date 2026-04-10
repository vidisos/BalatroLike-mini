local image_list = require "src.image_list"
local LANG       = require "src.LANG"

local spark_images = image_list.sparks

---@type SparkBase[]
local spark_list = {
    twintiply = {image = spark_images.twintiply, id = "twintiply", title = LANG.twintiply_title, desc = LANG.twintiply_desc, activation_type = "end-of-hand", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        function(self, gamestate)
            if gamestate:handContains("pair") then
                gamestate.mult = gamestate.mult + 8
            end
        end
    },
    red_dragon = {image = spark_images.red_dragon, id = "red_dragon", title = LANG.red_dragon_title, desc = LANG.red_dragon_desc, activation_type = "end-of-hand", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        function(self, gamestate)
            if gamestate:handContains("three_of_a_kind") then
                gamestate.mult = gamestate.mult + 12
            end
        end
    },
    double_pears = {image = spark_images.double_pears, id = "double_pears", title = LANG.double_pears_title, desc = LANG.double_pears_desc, activation_type = "end-of-hand", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        function(self, gamestate)
            if gamestate:handContains("two_pair") then
                gamestate.mult = gamestate.mult + 10
            end
        end
    },
    multiline = {image = spark_images.multiline, id = "multiline", title = LANG.multiline_title, desc = LANG.multiline_desc, activation_type = "end-of-hand", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        function(self, gamestate)
            if gamestate:handContains("straight") then
                gamestate.mult = gamestate.mult + 12
            end
        end
    },
    colorofall = {image = spark_images.colorofall, id = "colorofall", title = LANG.colorofall_title, desc = LANG.colorofall_desc, activation_type = "end-of-hand", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        function(self, gamestate)
            if gamestate:handContains("flush") then
                gamestate.mult = gamestate.mult + 10
            end
        end
    },

    twin_chips = {image = spark_images.twin_chips, id = "twin_chips", title = LANG.twin_chips_title, desc = LANG.twin_chips_desc, activation_type = "end-of-hand", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        function(self, gamestate)
            if gamestate:handContains("pair") then
                gamestate.chips = gamestate.chips + 50
            end
        end
    },
    blue_dragon = {image = spark_images.blue_dragon, id = "blue_dragon", title = LANG.blue_dragon_title, desc = LANG.blue_dragon_desc, activation_type = "end-of-hand", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        function(self, gamestate)
            if gamestate:handContains("three_of_a_kind") then
                gamestate.chips = gamestate.chips + 100
            end
        end
    },
    double_scizzors = {image = spark_images.double_scizzors, id = "double_scizzors", title = LANG.double_scizzors_title, desc = LANG.double_scizzors_desc, activation_type = "end-of-hand", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        function(self, gamestate)
            if gamestate:handContains("two_pair") then
                gamestate.chips = gamestate.chips + 80
            end
        end
    },
    grand_line = {image = spark_images.grand_line, id = "grand_line", title = LANG.grand_line_title, desc = LANG.grand_line_desc, activation_type = "end-of-hand", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        function(self, gamestate)
            if gamestate:handContains("straight") then
                gamestate.chips = gamestate.chips + 100
            end
        end
    },
    collector = {image = spark_images.collector, id = "collector", title = LANG.collector_title, desc = LANG.collector_desc, activation_type = "end-of-hand", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        function(self, gamestate)
            if gamestate:handContains("flush") then
                gamestate.chips = gamestate.chips + 80
            end
        end
    },

    controller = {image = spark_images.controller, id = "controller", title = LANG.controller_title, desc = LANG.controller_desc, activation_type = "passive",
        effect =
            ---@param self Spark|Drawable
            ---@param gamestate GameState
            function(self, gamestate)
                gamestate.active_hands_remaining_max = gamestate.active_hands_remaining_max + 1
            end,
        deactivate =
            ---@param self Spark|Drawable
            ---@param gamestate GameState
            function(self, gamestate)
                gamestate.active_hands_remaining_max = gamestate.active_hands_remaining_max - 1
            end
    },
    spark = {image = spark_images.spark, id = "spark", title = LANG.spark_title, desc = LANG.spark_desc, activation_type = "passive",
        effect =
            ---@param self Spark|Drawable
            ---@param gamestate GameState
            function(self, gamestate)
                gamestate.spark_select_max = gamestate.spark_select_max + 1
            end,
        deactivate =
            ---@param self Spark|Drawable
            ---@param gamestate GameState
            function(self, gamestate)
                gamestate.spark_select_max = gamestate.spark_select_max - 1
            end
    },
    ace = {image = spark_images.ace, id = "ace", title = LANG.ace_title, desc = LANG.ace_desc, activation_type = "per-card", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        ---@param card Card|Drawable
        function(self, gamestate, card)
            if card.rank == 14 then
                gamestate.mult = gamestate.mult + 4
            end
        end
    },
    trash_can = {image = spark_images.trash_can, id = "trash-can", title = LANG.trash_can_title, desc = LANG.trash_can_desc, activation_type = "passive",
        effect =
            ---@param self Spark|Drawable
            ---@param gamestate GameState
            function(self, gamestate)
                gamestate.active_discards_remaining_max = gamestate.active_discards_remaining_max + 2
            end,
        deactivate =
            ---@param self Spark|Drawable
            ---@param gamestate GameState
            function(self, gamestate)
                gamestate.active_discards_remaining_max = gamestate.active_discards_remaining_max - 2
            end
    }
}

return spark_list
