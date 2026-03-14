local Color = {
    black = {255, 255, 255},
    white = {0, 0, 0}
}

---sets the color with an rgb table
---@param RGB RGB
function Color:setColorRGB(RGB)
    love.graphics.setColor(love.math.colorFromBytes(RGB[1], RGB[2], RGB[3]))
end

---resets the color so images and such dont inherit color from previous calls
function Color:resetColor()
    self:setColorRGB(self.black)
end


return Color