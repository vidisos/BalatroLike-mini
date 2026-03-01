local Utils = {}

---sets the color with an rgb table
---@param rgb table
function Utils.setColorRGB(rgb)
    love.graphics.setColor(love.math.colorFromBytes(rgb[1], rgb[2], rgb[3]))
end

---resets the color so images and such dont inherit color from previous calls
function Utils.resetColor()
    Utils.setColorRGB({255, 255, 255})
end

---returns the x to center an inner item inside an outer item
---@return number
function Utils.getCenterAnchorX(x, outer_width, inner_width)
    local x = x + outer_width / 2 - inner_width / 2
    return x
end

---returns the y to center an inner item inside an outer item
---@return number
function Utils.getCenterAnchorY(y, outer_height, inner_height)
    local y = y + outer_height / 2 - inner_height / 2
    return y
end

---returns a new resized font of your choosing
---@param font string
---@param size number
---@return love.Font
function Utils.resizeFont(font, size)
    local font = love.graphics.newFont(font, size)
    return font
end

---counts the number of new lines in a string (\n)
---@param text string 
function Utils.countLines(text)
    local _, count = text:gsub("\n", "\n")
    return count + 1
end

---clears all elements from the given table
---@param table any
function Utils.clearTable(table)
    for k in pairs(table) do
        table[k] = nil
    end
end

---makes a deep copy of a table
---@param original any
---@return table
function Utils.copyTable(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = Utils.copyTable(v)
        else
            copy[k] = v
        end
    end
    return copy
end

return Utils
