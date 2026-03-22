---@meta

---@class LanguageEntry
---@field en string
---@field sl string

---@class RGBA
---@field [1] number  Red (0-255)
---@field [2] number  Green (0-255)
---@field [3] number  Blue (0-255)

---@class Scene
---@field id string
---@field shouldDraw boolean
---@field z_index number
---@field drawables Drawable[]

---@class Options
---@field id string
---@field shouldDraw boolean
---@field z_index number
---@field drawables Drawable[]
---@field toggle fun(self, source: string)
---@field open fun(self, source: string)
---@field close fun(self)
---@field source string

---@class HandRankings
---@field id string
---@field shouldDraw boolean
---@field z_index number
---@field drawables Drawable[]
---@field drawRankings fun(self)

---@class CardBase
---@field baseImage love.Image
---@field backImage love.Image
---@field suit string
---@field rank number
---@field chips number
---@field title LanguageEntry

---@class SparkBase
---@field image love.Image
---@field id string
---@field title LanguageEntry
---@field desc LanguageEntry
---@field activation_type string
---@field effect fun(self, gamestate)
---@field deactivate fun(self, gamestate)

---@class Drawable
---@field id string
---@field z_index number
---@field isClickable boolean
---@field isHoverable boolean
---@field isHovered boolean
---@field shouldDraw boolean
---@field type string
---@field x number
---@field y number
---@field width number
---@field height number
---@field updateFunc fun(self: Drawable, dt: number)
---@field onHoverFunc fun(self: Drawable, dt: number)
---@field onEnterHoverFunc fun(self: Drawable)
---@field onExitHoverFunc fun(self: Drawable)
---@field drawFunc fun(self: Drawable)
---@field isHoveredFunc fun(self: Drawable, mx: number, my: number): boolean
---@field Button fun(self: Drawable, text?: LanguageEntry | string, font?: love.Font, text_color?: RGBA, color?: RGBA, onClickFunc?: fun(self), border_width?: number, border_color?: RGBA, text_alignment?: "left"|"center"|"right", text_margin?: number): Button
---@field ImageBox fun(self: Drawable, image?: love.Image, onClickFunc?: fun(self)): ImageBox
---@field Rectangle fun(self: Drawable, color?: table, border_width?: number, border_color?: table): Rectangle
---@field TextBox fun(self: Drawable, text?: table | LanguageEntry | string, font?: love.Font, text_color?: RGBA, color?: RGBA, text_alignment?: "left"|"center"|"right", text_margin?: number): TextBox
---@field Card fun(self: Drawable, card_base: CardBase, onClickFunc?: fun(self)): Card
---@field Spark fun(self: Drawable, spark_base: SparkBase, onClickFunc?: fun(self)): Spark|Drawable
---@field Slider fun(self: Drawable, color?: RGBA, value: number, min: number, max: number, setter?: fun(value: number), orientation?: "horizontal"|"vertical", track?: "rectangle"|"line"|"roundrect", knob?: "rectangle"|"circle"): Slider

---@class Button : Drawable

---@class Rectangle : Drawable

---@class TextBox : Drawable

---@class ImageBox : Drawable

---@class Card : Drawable

---@class Spark : Drawable

---@class Slider : Drawable