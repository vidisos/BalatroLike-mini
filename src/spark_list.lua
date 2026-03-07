local image_list = require "src.image_list"

local spark_images = image_list.sparks

---@type SparkBase[]
local spark_list = {
    controller = {image = spark_images.controller, activation_type = "passive", effect = function ()  end},
    spark2 = {image = spark_images.spark2, activation_type = "per-card", effect = function ()  end},
    spark3 = {image = spark_images.spark3, activation_type = "end-of-hand", effect = function ()  end},
    spark4 = {image = spark_images.spark4, activation_type = "passive", effect = function ()  end},
    spark5 = {image = spark_images.spark5, activation_type = "passive", effect = function ()  end},
    spark6 = {image = spark_images.spark6, activation_type = "passive", effect = function ()  end},
    spark7 = {image = spark_images.spark7, activation_type = "passive", effect = function ()  end},
    spark8 = {image = spark_images.spark8, activation_type = "passive", effect = function ()  end},
    spark9 = {image = spark_images.spark9, activation_type = "passive", effect = function ()  end},
    spark10 = {image = spark_images.spark10, activation_type = "passive", effect = function ()  end}
}

return spark_list
