local Utils = require "src.Utils"

---@class Spark : Drawable
local Spark = {}

---extension of Drawable: a spark with an effect and activation type
---@param spark_base SparkBase
---@param onClickFunc? fun()
---@return Spark
function Spark:Spark(spark_base, onClickFunc)
    self.type = "Spark"
    self.image = spark_base.image
    self.activation_type = spark_base.activation_type
    self.effect = spark_base.effect

    self.displayIndex = 1
    self.onClickFunc = onClickFunc or function () end

    self.drawFunc = function ()
        local scaleX = self.width / self.image:getWidth()
        local scaleY = self.height / self.image:getHeight()

        love.graphics.draw(self.image, self.x, self.y, 0, scaleX, scaleY)

        Utils.resetColor()
    end

    self.isClickedFunc = function (mx, my)
        local isClicked =
            self.x <= mx and mx <= self.x + self.width and
            self.y <= my and my <= self.y + self.height
        return isClicked
    end

    return self
end

return Spark
