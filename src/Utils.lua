local Utils = {}
local Color = require "src.Color"

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

---draws text (preventing button and textbox code duplication for text)
---@param text string|LanguageEntry|table
---@param base_font love.Font
---@param text_color RGBA
---@param lang string
---@param x number
---@param y number
---@param width number
---@param height number
---@param alignment? string
---@param x_margin? number
function Utils.drawText(text, base_font, text_color, lang, x, y, width, height, alignment, x_margin)
    alignment = alignment or "center"
    x_margin = x_margin or 0

    local display = Utils.resolveText(text, lang)

    local font = base_font
    -- if its a language entry with an added font then we use that instead
    if type(text) == "table" and text.font then
        font = text.font
    end

    local isColored = type(display) == "table"
    local plain
    if isColored then
        plain = Utils.plainTextFrom(display)
    else
        plain = display
    end

    local _, lines = font:getWrap(plain, width)
    local text_y = Utils.getCenterAnchorY(y, height, font:getHeight() * #lines)

    love.graphics.setFont(font)
    if not isColored then
        Color:setColor(text_color)
    else
        Color:resetColor()
    end
    love.graphics.printf(display, x + x_margin, text_y, width, alignment)
    Color:resetColor()
end

---returns a string(can be from language entry) or a colored table from any input
---@param text string|LanguageEntry|table
---@param lang string
---@return table|string  -- colored table or plain string
function Utils.resolveText(text, lang)
    if type(text) == "string" then
        return text  -- plain string, let caller set color
    end

    if type(text) == "table" then
        -- colored table: { {r,g,b}, "str", {r,g,b}, "str", ... }
        if type(text[1]) == "table" then
            return text
        end

        -- language table: { en="...", sl="...", font=..., colored={...} }
        local entry = text[lang] or text.en or ""

        -- language entry can itself be a colored table
        if type(entry) == "table" and type(entry[1]) == "table" then
            return entry
        end

        return entry  -- plain string from lang table
    end

    return ""
end

---gets plain text string from a languauge entry, colored text table or just normal text
---@param val string|LanguageEntry|table
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

---returns an array {key, value1, value1} from the input key,table table
---@param key_table table
---@return table
function Utils.getArray(key_table)
    local array = {}
    for key, value in pairs(key_table) do
        value.key = key
        table.insert(array, value)
    end
    return array
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
