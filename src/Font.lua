local Font = {}

---@class FontLinks
---@field pixel_font string
---@field pixel_font_bold string
Font.font_paths = {
    pixel_font = "src/fonts/Karma Suture.otf",
    pixel_font_bold = "src/fonts/Karma Future.otf"
}

---@class FontCollection
---@field font_small love.Font
---@field font_average love.Font
Font.fonts = {
    font_small = love.graphics.newFont(Font.font_paths.pixel_font, 40),
    font_average = love.graphics.newFont(Font.font_paths.pixel_font, 50)
}

---returns a new resized font of your choosing
---@param font string
---@param size number
---@return love.Font
function Font:resizeFont(font, size)
    local font = love.graphics.newFont(font, size)
    return font
end

return Font
