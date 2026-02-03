local Scenes = {
    scene_list = {}
}

-- inizializira vse elemente v love.load namesto v require stavku
function Scenes:init()
    table.insert(self.scene_list, require("scenes/start_menu"))
    table.insert(self.scene_list, require("scenes/game_main"))
end

function Scenes:disableScenes()
    for _, scene in pairs(self.scene_list) do
        scene.shouldDraw = false
    end
end

function Scenes:enableScene(id)
    for _, scene in pairs(self.scene_list) do
        if scene.id == id then
            scene.shouldDraw = true
        end
    end
end

function Scenes:getScene(id)
    for _, scene in pairs(self.scene_list) do
        if scene.id == id then
            return scene
        end
    end

    return nil
end

function Scenes:update(dt)
    for _, scene in ipairs(self.scene_list) do
        for _, item in ipairs(scene.drawables) do
            item.drawable:update(dt)
        end
    end
end

function Scenes:draw()
    for _, scene in ipairs(self.scene_list) do
        if scene.shouldDraw then
            for _, item in ipairs(scene.drawables) do
                item.drawable:draw()
            end
        end
    end
end

-- goes through all the drawables and if they can be clicked they do the onClick check
function Scenes:onClick(mx, my)
    for _, scene in ipairs(self.scene_list) do
        if scene.shouldDraw then
            for _, item in ipairs(scene.drawables) do
                item.drawable:onClick(mx, my)
            end
        end
    end
end

return Scenes
