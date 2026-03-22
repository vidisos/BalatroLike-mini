local Scenes = {
    ---@type Scene[]
    scene_list = {},

    ---@type Drawable
    last_hovered_drawable = nil
}

---initializes all the scenes and sorts them by z-index
function Scenes:init()
    table.insert(self.scene_list, require("src/scenes/start-menu"))
    table.insert(self.scene_list, require("src/scenes/game-main"))
    table.insert(self.scene_list, require("src/scenes/game-over"))
    table.insert(self.scene_list, require("src/scenes/round-won"))
    table.insert(self.scene_list, require("src/scenes/game-won"))
    table.insert(self.scene_list, require("src.HandRankings"))
    table.insert(self.scene_list, require("src.Options"))

    local HandRankings = Scenes:getScene("hand-rankings")
    HandRankings:drawRankings()

    self:sortAll()
end

---activates the update function of every drawable
---@param dt number
function Scenes:update(dt)
    for _, scene in ipairs(self.scene_list) do
        for _, drawable in ipairs(scene.drawables) do
            drawable:update(dt)
        end
    end
end

---activates the draw function of every drawable 
function Scenes:draw()
    for _, scene in ipairs(self.scene_list) do
        if scene.shouldDraw then
            for _, drawable in ipairs(scene.drawables) do
                if drawable.shouldDraw then
                    drawable:draw()
                end
            end
        end
    end
end

---checks if an items is hovered and activates it onclick function, accounts for z-index
---@param mx number
---@param my number
function Scenes:onClick(mx, my)
    -- we iterate the scenes by z-index highest to lowest
    for i = #self.scene_list, 1, -1 do
        local scene = self.scene_list[i]

        if scene.shouldDraw then
            local scene_clicked_drawables = {}

            for _, drawable in ipairs(scene.drawables) do
                if drawable.shouldDraw and drawable.isClickable and drawable:isHoveredFunc(mx, my) then
                    table.insert(scene_clicked_drawables, drawable)
                end
            end

            -- if any drawable in this scene is clicked, handle the top one and stop
            if #scene_clicked_drawables > 0 then
                table.sort(scene_clicked_drawables, function (a, b) return a.z_index > b.z_index end)
                local top_drawable = scene_clicked_drawables[1]
                top_drawable:onClickFunc()
                return
            end
        end
    end
end

---checks if a drawable is hovered and activates the hover func, contains hover exit and enter logic, accounts for z-index
---@param mx number
---@param my number
function Scenes:onHover(mx, my)
    -- we iterate the scenes by z-index highest to lowest
    for i = #self.scene_list, 1, -1 do
        local scene = self.scene_list[i]

        if scene.shouldDraw then
            local scene_hovered_drawables = {}

            for _, drawable in ipairs(scene.drawables) do
                if drawable.shouldDraw and drawable.isHoverable and drawable:isHoveredFunc(mx, my) then
                    table.insert(scene_hovered_drawables, drawable)
                end
            end

            -- if any drawable in this scene is hovered, handle the top one and stop
            if #scene_hovered_drawables > 0 then
                table.sort(scene_hovered_drawables, function (a, b) return a.z_index > b.z_index end)
                local top_drawable = scene_hovered_drawables[1]

                if self.last_hovered_drawable ~= top_drawable then
                    if self.last_hovered_drawable then
                        self.last_hovered_drawable.isHovered = false
                        self.last_hovered_drawable:onExitHoverFunc()
                    end

                    if not top_drawable.isHovered then
                        top_drawable.isHovered = true
                        top_drawable:onEnterHoverFunc()
                    end

                    self.last_hovered_drawable = top_drawable
                end

                top_drawable:onHoverFunc()

                return
            end
        end
    end

    -- if no hovered drawables in any scene, exit the last hovered
    if self.last_hovered_drawable then
        self.last_hovered_drawable.isHovered = false
        self.last_hovered_drawable:onExitHoverFunc()
        self.last_hovered_drawable = nil
    end
end

---prevents all scenes from being drawn and allows clicks and hovers on all of them
function Scenes:resetScenes()
    for _, scene in ipairs(self.scene_list) do
        scene.shouldDraw = false
        self:enableSceneInteractions(scene.id)
    end
end

--------------GET-ers-----------------
---returns a specific scene table with the id
---@param id string
---@return Scene
function Scenes:getScene(id)
    for _, scene in ipairs(self.scene_list) do
        if scene.id == id then
            return scene
        end
    end
end

---returns a specific drawable table with the id, goes through all scenes in case of drawable movement between scenes
---@return Drawable
function Scenes:getDrawableGlobal(id)
    for _, scene in ipairs(self.scene_list) do
        for _, drawable in ipairs(scene.drawables) do
            if drawable.id == id then
                return drawable
            end
        end
    end
end

---returns a specific drawable table with the id
---@param scene_id string
---@param id string
---@return Drawable
function Scenes:getDrawable(scene_id, id)
    local scene = Scenes:getScene(scene_id)
    for _, drawable in ipairs(scene.drawables) do
        if drawable.id == id then
            return drawable
        end
    end
end

--------------GENERAL SCENES-----------------

---allows one scene to be drawn
---@param scene_id string
function Scenes:enableScene(scene_id)
    local scene = Scenes:getScene(scene_id)
    scene.shouldDraw = true
end

---disables a scene from being drawn
---@param scene_id string
function Scenes:disableScene(scene_id)
    local scene = Scenes:getScene(scene_id)
    scene.shouldDraw = false
end

--------------INTERACTIONS-----------------

---disables clicks for all scenes
function Scenes:disableAllSceneInteractions()
    for _, scene in ipairs(self.scene_list) do
        self:disableSceneInteractions(scene.id)
    end
end

---enables clicks for all scenes
function Scenes:enableAllSceneInteractions()
    for _, scene in ipairs(self.scene_list) do
        self:enableSceneInteractions(scene.id)
    end
end

---disables hovers and clicks on a scene
---@param scene_id string
function Scenes:disableSceneInteractions(scene_id)
    self:disableSceneClicks(scene_id)
    self:disableSceneHover(scene_id)
end

---enables hovers and clicks on a scene
---@param scene_id string
function Scenes:enableSceneInteractions(scene_id)
    self:enableSceneClicks(scene_id)
    self:enableSceneHover(scene_id)
end

---disables hovers and clicks on a drawable
---@param scene_id string
---@param id string
function Scenes:disableItemInteractions(scene_id, id)
    self:disableItemClicks(scene_id, id)
    self:disableItemHover(scene_id, id)
end

---disables hovers and clicks on a scene
---@param scene_id string
---@param id string
function Scenes:enableItemInteractions(scene_id, id)
    self:enableItemClicks(scene_id, id)
    self:enableItemHover(scene_id, id)
end


--------------CLICKING-----------------

---disables clicks for all scenes
function Scenes:disableAllSceneClicks()
    for _, scene in ipairs(self.scene_list) do
        self:disableSceneClicks(scene.id)
    end
end

---enables clicks for all scenes
function Scenes:enableAllSceneClicks()
    for _, scene in ipairs(self.scene_list) do
        self:enableSceneClicks(scene.id)
    end
end

---disables clicks for a certain scene
---@param scene_id string
function Scenes:disableSceneClicks(scene_id)
    local scene = Scenes:getScene(scene_id)
    for _, drawable in ipairs(scene.drawables) do
        drawable.isClickable = false
    end
end

---enables clicks for a certain scene
---@param scene_id string
function Scenes:enableSceneClicks(scene_id)
    local scene = Scenes:getScene(scene_id)
    for _, drawable in ipairs(scene.drawables) do
        drawable.isClickable = true
    end
end

---disables clicks for a certain drawable
---@param scene_id string
---@param id string
function Scenes:disableItemClicks(scene_id, id)
    local drawable = Scenes:getDrawable(scene_id, id)
    drawable.isClickable = false
end

---enables clicks for a certain drawable
---@param scene_id string
---@param id string
function Scenes:enableItemClicks(scene_id, id)
    local drawable = Scenes:getDrawable(scene_id, id)
    drawable.isClickable = true
end

--------------HOVERS-----------------

---disables hovering for all scenes
function Scenes:disableAllSceneHover()
    for _, scene in ipairs(self.scene_list) do
        self:disableSceneHover(scene.id)
    end
end

---enables hovering for all scenes
function Scenes:enableAllSceneHover()
    for _, scene in ipairs(self.scene_list) do
        self:enableSceneHover(scene.id)
    end
end

---disables hovering for a certain scene
---@param scene_id string
function Scenes:disableSceneHover(scene_id)
    local scene = Scenes:getScene(scene_id)
    for _, drawable in ipairs(scene.drawables) do
        drawable.isHoverable = false
    end
end

---enables hovering for a certain scene
---@param scene_id string
function Scenes:enableSceneHover(scene_id)
    local scene = Scenes:getScene(scene_id)
    for _, drawable in ipairs(scene.drawables) do
        if not drawable.forceDisableHover then
            drawable.isHoverable = true
        end
    end
end

---disables hovering for a certain drawable
---@param scene_id string
---@param id string
function Scenes:disableItemHover(scene_id, id)
    local drawable = Scenes:getDrawable(scene_id, id)
    drawable.isHoverable = false
end

---enables hovering for a certain drawable
---@param scene_id string
---@param id string
function Scenes:enableItemHover(scene_id, id)
    local drawable = Scenes:getDrawable(scene_id, id)
    drawable.isHoverable = true
end

--------------DRAWABLES-----------------

---adds a new drawable to a certain scene
---@param scene_id string
---@param drawable Drawable
function Scenes:addDrawable(scene_id, drawable)
    local scene = Scenes:getScene(scene_id)
    if scene then
        table.insert(scene.drawables, drawable)
    end
end

---removes a drawable with the id in any scene, in case the drawable is moved around and such
function Scenes:removeDrawableGlobal(id)
    for _, scene in ipairs(self.scene_list) do
        for i, drawable in ipairs(scene.drawables) do
            if drawable.id == id then
                table.remove(scene.drawables, i)
            end
        end
    end
end

---removes a drawable from a certain scene
---@param scene_id string
---@param id string
function Scenes:removeDrawable(scene_id, id)
    local scene = Scenes:getScene(scene_id)
    for i, drawable in ipairs(scene.drawables) do
        if drawable.id == id then
            table.remove(scene.drawables, i)
            return
        end
    end
end

--------------SORTING-----------------

---sorts all scenes and their drawables by z-index
function Scenes:sortAll()
    self:sortScenes()
    for _, scene in ipairs(self.scene_list) do
        self:sortDrawables(scene.id)
    end
end

---sorts all scenes by z-index
function Scenes:sortScenes()
    table.sort(self.scene_list, function (a, b) return a.z_index < b.z_index end)
end

---sorts all drawables of a scene by z-index
---@param scene_id string
function Scenes:sortDrawables(scene_id)
    local scene = Scenes:getScene(scene_id)
    table.sort(scene.drawables, function (a, b) return a.z_index < b.z_index end)
end

return Scenes
