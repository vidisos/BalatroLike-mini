---@meta

---@class LanguageEntry
---@field en string
---@field sl string

---@class HandRanking
---@field chips number
---@field mult number

---@class Scene
---@field id string
---@field shouldDraw boolean
---@field isClickable boolean
---@field z_index number
---@field drawables Drawable[]

---@class CardBase
---@field baseImage love.Image
---@field backImage love.Image
---@field suit string
---@field rank number
---@field chips number

---@class Drawable
---@field id string
---@field z_index number
---@field isClickable boolean
---@field shouldDraw boolean
---@field type string
---@field x number
---@field y number
---@field width number
---@field height number
---@field updateFunc fun(self: Drawable, dt: number)
---@field drawFunc fun(self: Drawable)
---@field isClickedFunc fun(mx: number, my: number): boolean
---@field Button fun(self: Drawable, text?: table | string, font?: love.Font, text_color?: table, button_color?: table, onClickFunc?: fun(), border_width?: number, border_color?: table): Button
---@field ImageBox fun(self: Drawable, image?: love.Image, onClickFunc?: fun()): ImageBox
---@field Rectangle fun(self: Drawable, background_color?: table): Rectangle
---@field TextBox fun(self: Drawable, text?: table | string, font?: love.Font, text_color?: table, background_color?: table, alignment?: string): TextBox
---@field Card fun(self: Drawable, card_base?: CardBase, onClickFunc?: fun()): Card