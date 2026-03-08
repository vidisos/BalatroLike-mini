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

---gets plain text string from a languauge entry, colored text table or just normal text
---@param val any
---@return string
function Utils.plainTextFrom(val)
    if type(val) ~= "table" then
        return tostring(val)
    end

    local buf = {}
    for _, v in ipairs(val) do
        if type(v) == "string" then
            buf[#buf+1] = v
        end
    end

    return table.concat(buf)
end

---counts the number of lines in a string or colored-text table, including the first line
---@param text string|table 
function Utils.countLines(text)
    -- in case of a colored text table
    if type(text) == "table" then
        local text_concatenated = {}
        for _, v in ipairs(text) do
            if type(v) == "string" then
                table.insert(text_concatenated, v)
            end
        end

        text = table.concat(text_concatenated)
    end

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

---insert the values of the input table into the original and returns the table with now unpacked values
---@param original table
---@param input_table table
---@return table
function Utils.insertFromUnpackedTable(original, input_table)
    for _, v in ipairs(input_table) do
        table.insert(original, v)
    end

    return original
end

return Utils
