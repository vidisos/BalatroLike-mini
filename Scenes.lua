local Utils = require "Utils"
local Scenes = {
    scene_list = {}
}

---initializes all the scenes and sorts them by z-index
function Scenes:init()
    table.insert(self.scene_list, require("scenes/start_menu"))
    table.insert(self.scene_list, require("scenes/game_main"))

    Scenes:sortScenes()
    for _, scene in ipairs(self.scene_list) do
        Scenes:sortDrawables(scene)
    end
end

---activates the update function of every drawable
---@param dt number
function Scenes:update(dt)
    for _, scene in ipairs(self.scene_list) do
        for _, item in ipairs(scene.drawables) do
            item.drawable:update(dt)
        end
    end
end

---activates the draw function of every drawable 
function Scenes:draw()
    for _, scene in ipairs(self.scene_list) do
        if scene.shouldDraw then
            for _, item in ipairs(scene.drawables) do
                item.drawable:draw()
            end
        end
    end
end

---checks if items are clicked, accounts for z-index
---@param mx number
---@param my number
function Scenes:onClick(mx, my)
    local clicked_drawables = {}

    for _, scene in ipairs(self.scene_list) do
        if scene.shouldDraw then

            for _, item in ipairs(scene.drawables) do
                if item.drawable:isClicked(mx, my) then
                    table.insert(clicked_drawables, item)
                end
            end
        end
    end

    -- runs the onclick function of the most top layered item
    if #clicked_drawables > 0 then
        table.sort(clicked_drawables, function (a, b) return a.z_index > b.z_index end)

        local top_item = clicked_drawables[1]

        if top_item.drawable.isClickable then
            top_item.drawable:onClickFunc()
        end
    end
end

---prevents all scenes from being drawn
function Scenes:disableScenes()
    for _, scene in ipairs(self.scene_list) do
        scene.shouldDraw = false
    end
end

---allows one scene to be drawn
---@param id string
function Scenes:enableScene(id)
    for _, scene in ipairs(self.scene_list) do
        if scene.id == id then
            scene.shouldDraw = true
        end
    end
end

---returns a specific scene table with the id
---@param id string
---@return Scene
function Scenes:getScene(id)
    for _, scene in ipairs(self.scene_list) do
        if scene.id == id then
            return scene
        end
    end

    error("Scenes:getScene(id): Bad scene id")
end

---returns a specific drawable item table with the id
---@param id string
---@return DrawableItem
function Scenes:getDrawableItem(scene_id, id)
    for _, scene in ipairs(self.scene_list) do
        if scene.id == scene_id then

            for _, item in ipairs(scene.drawables) do
                if item.id == id then
                    return item
                end
            end
        end
    end

    error("Scenes:getDrawableItem(scene_id, id): smth wrong idk lel")
end

---sorts all scenes by z-index
function Scenes:sortScenes()
    table.sort(self.scene_list, function (a, b) return a.z_index < b.z_index end)
end

---sorts all drawables of a scene by z-index
function Scenes:sortDrawables(scene)
    table.sort(scene.drawables, function (a, b) return a.z_index < b.z_index end)
end

---adds a new drawable to a scene
function Scenes:addDrawable(scene, id, z_index, drawable)
    if scene then
        table.insert(scene.drawables, {id = id, z_index = z_index, drawable = drawable})
    end
end

---deletes all the cards currently in the main game cards table
function Scenes:clearCards()
    local scene = self:getScene("game-main")

    -- we need to iterate backwards otherwise it doesnt remove properly(the index moves and stuff)
    for i = #scene.drawables, 1, -1 do

        local item = scene.drawables[i]
        if item.drawable.type == "Card" then
            table.remove(scene.drawables, i)
        end
    end
end

return Scenes
