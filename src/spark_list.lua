local image_list = require "src.image_list"
local LANG       = require "src.LANG"

local spark_images = image_list.sparks

---@type SparkBase[]
local spark_list = {
    spark1 = {image = spark_images.spark2, id = "spark1", title = LANG.spark_1_title, desc = LANG.spark_1_desc, activation_type = "end-of-hand", effect = function () end},
    spark2 = {image = spark_images.spark2, id = "spark2", title = LANG.spark_2_title, desc = LANG.spark_2_desc, activation_type = "end-of-hand", effect = function () end},
    spark3 = {image = spark_images.spark3, id = "spark3", title = LANG.spark_3_title, desc = LANG.spark_3_desc, activation_type = "end-of-hand", effect = function () end},
    spark4 = {image = spark_images.spark4, id = "spark4", title = LANG.spark_4_title, desc = LANG.spark_4_desc, activation_type = "end-of-hand", effect = function () end},
    spark5 = {image = spark_images.spark5, id = "spark5", title = LANG.spark_5_title, desc = LANG.spark_5_desc, activation_type = "end-of-hand", effect = function () end},
    spark6 = {image = spark_images.spark6, id = "spark6", title = LANG.spark_6_title, desc = LANG.spark_6_desc, activation_type = "end-of-hand", effect = function () end},
    spark7 = {image = spark_images.spark7, id = "spark7", title = LANG.spark_7_title, desc = LANG.spark_7_desc, activation_type = "end-of-hand", effect = function () end},
    spark8 = {image = spark_images.spark8, id = "spark8", title = LANG.spark_8_title, desc = LANG.spark_8_desc, activation_type = "end-of-hand", effect = function () end},
    spark9 = {image = spark_images.spark9, id = "spark9", title = LANG.spark_9_title, desc = LANG.spark_9_desc, activation_type = "end-of-hand", effect = function () end},
    spark10 = {image = spark_images.spark10, id = "spark10", title = LANG.spark_10_title, desc = LANG.spark_10_desc, activation_type = "end-of-hand", effect = function () end},

    controller = {image = spark_images.controller, id = "controller", title = LANG.spark_11_title, desc = LANG.spark_11_desc, activation_type = "passive", effect = function () end},
    spark12 = {image = spark_images.spark12, id = "leguana", title = LANG.spark_12_title, desc = LANG.spark_12_desc, activation_type = "end-of-hand", effect = function () end},
    spark13 = {image = spark_images.spark13, id = "americatime", title = LANG.spark_13_title, desc = LANG.spark_13_desc, activation_type = "per-card", effect = function () end},
    spark14 = {image = spark_images.spark14, id = "banana", title = LANG.spark_14_title, desc = LANG.spark_14_desc, activation_type = "per-card", effect = function () end}
}

return spark_list
