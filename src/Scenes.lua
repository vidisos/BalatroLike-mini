local Scenes = {}

-- inizializira vse elemente v love.load namesto v require stavku
function Scenes:init()
    self.scene_list = {}
    table.insert(self.scene_list, require("scenes/start_menu"))
    table.insert(self.scene_list, require("scenes/game_main"))
end

function disableScenes()
    for _, scene in pairs(Scenes.scene_list) do
        scene.shouldDraw = false
    end
end

function enableScene(id)
    for _, scene in pairs(Scenes.scene_list) do
        if scene.id == id then
            scene.shouldDraw = true
        end
    end
end

return Scenes
