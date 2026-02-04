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

    if #clicked_drawables > 0 then
        -- runs the onclick function of the most top layered item
        table.sort(clicked_drawables, function (a, b) return a.z_index > b.z_index end)

        clicked_drawables[1].drawable:onClickFunc()
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
---@return table?
function Scenes:getScene(id)
    for _, scene in ipairs(self.scene_list) do
        if scene.id == id then
            return scene
        end
    end
end

---sorts all scenes with z-index
function Scenes:sortScenes()
    table.sort(self.scene_list, function (a, b) return a.z_index < b.z_index end)
end

---sorts all drawables of a scene by z-index
function Scenes:sortDrawables(scene)
    table.sort(scene.drawables, function (a, b) return a.z_index < b.z_index end)
end

return Scenes
