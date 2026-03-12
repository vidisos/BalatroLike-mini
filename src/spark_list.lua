local image_list = require "src.image_list"
local LANG       = require "src.LANG"

local spark_images = image_list.sparks

---@type SparkBase[]
local spark_list = {
    controller = {image = spark_images.controller, title = LANG.spark_1_title, desc = LANG.spark_1_desc, activation_type = "passive", effect = function () end},
    spark2 = {image = spark_images.spark2, title = LANG.spark_2_title, desc = LANG.spark_2_desc, activation_type = "per-card", effect = function () end},
    spark3 = {image = spark_images.spark3, title = LANG.spark_3_title, desc = LANG.spark_3_desc, activation_type = "end-of-hand", effect = function () end},
    spark4 = {image = spark_images.spark4, title = LANG.spark_4_title, desc = LANG.spark_4_desc, activation_type = "passive", effect = function () end},
    spark5 = {image = spark_images.spark5, title = LANG.spark_5_title, desc = LANG.spark_5_desc, activation_type = "passive", effect = function () end},
    spark6 = {image = spark_images.spark6, title = LANG.spark_6_title, desc = LANG.spark_6_desc, activation_type = "passive", effect = function () end},
    spark7 = {image = spark_images.spark7, title = LANG.spark_7_title, desc = LANG.spark_7_desc, activation_type = "passive", effect = function () end},
    spark8 = {image = spark_images.spark8, title = LANG.spark_8_title, desc = LANG.spark_8_desc, activation_type = "passive", effect = function () end},
    spark9 = {image = spark_images.spark9, title = LANG.spark_9_title, desc = LANG.spark_9_desc, activation_type = "passive", effect = function () end},
    spark10 = {image = spark_images.spark10, title = LANG.spark_10_title, desc = LANG.spark_10_desc, activation_type = "passive", effect = function () end}
}

return spark_list
