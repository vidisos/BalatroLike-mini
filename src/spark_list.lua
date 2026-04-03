local image_list = require "src.image_list"
local LANG       = require "src.LANG"

local spark_images = image_list.sparks

---@type SparkBase[]
local spark_list = {
    spark1 = {image = spark_images.spark1, id = "spark1", title = LANG.spark_1_title, desc = LANG.spark_1_desc, activation_type = "end-of-hand", effect =
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
    spark3 = {image = spark_images.spark3, id = "spark3", title = LANG.spark_3_title, desc = LANG.spark_3_desc, activation_type = "end-of-hand", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        function(self, gamestate)
            if gamestate:handContains("two_pair") then
                gamestate.mult = gamestate.mult + 10
            end
        end
    },
    spark4 = {image = spark_images.spark4, id = "spark4", title = LANG.spark_4_title, desc = LANG.spark_4_desc, activation_type = "end-of-hand", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        function(self, gamestate)
            if gamestate:handContains("straight") then
                gamestate.mult = gamestate.mult + 12
            end
        end
    },
    spark5 = {image = spark_images.spark5, id = "spark5", title = LANG.spark_5_title, desc = LANG.spark_5_desc, activation_type = "end-of-hand", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        function(self, gamestate)
            if gamestate:handContains("flush") then
                gamestate.mult = gamestate.mult + 10
            end
        end
    },

    spark6 = {image = spark_images.spark6, id = "spark6", title = LANG.spark_6_title, desc = LANG.spark_6_desc, activation_type = "end-of-hand", effect =
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
    spark8 = {image = spark_images.spark8, id = "spark8", title = LANG.spark_8_title, desc = LANG.spark_8_desc, activation_type = "end-of-hand", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        function(self, gamestate)
            if gamestate:handContains("two_pair") then
                gamestate.chips = gamestate.chips + 80
            end
        end
    },
    spark9 = {image = spark_images.spark9, id = "spark9", title = LANG.spark_9_title, desc = LANG.spark_9_desc, activation_type = "end-of-hand", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        function(self, gamestate)
            if gamestate:handContains("straight") then
                gamestate.chips = gamestate.chips + 100
            end
        end
    },
    spark10 = {image = spark_images.spark10, id = "spark10", title = LANG.spark_10_title, desc = LANG.spark_10_desc, activation_type = "end-of-hand", effect =
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
    spark12 = {image = spark_images.spark12, id = "leguana", title = LANG.spark_12_title, desc = LANG.spark_12_desc, activation_type = "passive",
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
    spark13 = {image = spark_images.spark13, id = "americatime", title = LANG.spark_13_title, desc = LANG.spark_13_desc, activation_type = "per-card", effect =
        ---@param self Spark|Drawable
        ---@param gamestate GameState
        ---@param card Card|Drawable
        function(self, gamestate, card)
            if card.rank == 14 then
                gamestate.mult = gamestate.mult + 2
            end
        end
    },
    spark14 = {image = spark_images.spark14, id = "trash-can", title = LANG.trash_can_title, desc = LANG.trash_can_desc, activation_type = "passive",
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
