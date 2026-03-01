---@meta

---@class LanguageEntry
---@field en string
---@field sl string

---@class Scene
---@field id string
---@field shouldDraw boolean
---@field z_index number
---@field drawables DrawableItem[]

---@class CardBase
---@field baseImage love.Image
---@field backImage love.Image
---@field suit string
---@field rank number

---@class Drawable
---@field type string
---@field x number
---@field y number
---@field width number
---@field height number
---@field isClickable boolean
---@field updateFunc fun(self: Drawable, dt: number)
---@field drawFunc fun(self: Drawable)
---@field isClickedFunc fun(mx: number, my: number): boolean
---@field Button fun(self: Drawable, text?: table | string, font?: love.Font, text_color?: table, button_color?: table, onClickFunc?: fun(), border_width?: number, border_color?: table): Button
---@field ImageBox fun(self: Drawable, image?: love.Image, onClickFunc?: fun()): ImageBox
---@field Rectangle fun(self: Drawable, background_color?: table): Rectangle
---@field TextBox fun(self: Drawable, text?: table | string, font?: love.Font, text_color?: table, background_color?: table): TextBox
---@field Card fun(self: Drawable, card_base?: CardBase, onClickFunc?: fun()): Card

---@class DrawableItem
---@field id string
---@field z_index number
---@field drawable Drawable

---@class Card : Drawable
---@field type string
---@field isClickable boolean
---@field image love.Image
---@field baseImage love.Image
---@field backImage love.Image
---@field suit string
---@field rank number
---@field selected boolean
---@field flipped boolean
---@field inHand boolean
---@field inDeck boolean
---@field displayIndex number
---@field onClickFunc fun()
---@field drawFunc fun(self: Card)
---@field isClickedFunc fun(mx: number, my: number): boolean
---@field x number
---@field y number
---@field width number
---@field height number