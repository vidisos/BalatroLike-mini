local Scenes = require "Scenes" -- a sort of 'class' which has the list of screens inside after init()

local BASE_WIDTH = 1920
local BASE_HEIGHT = 1080

function love.load()
    Scenes:init()

    love.window.setFullscreen(true)
    --[[
        local ww, wh = love.graphics.getDimensions()
        love.graphics.setDefaultFilter('nearest', 'nearest')
        love.window.setMode( ww/2, wh/2, {resizable=true} )
    ]]
end

function love.update(dt)

end

function love.draw()
    -- scaling based on window
    local ww, wh = love.graphics.getDimensions()
    local sx = ww / BASE_WIDTH
    local sy = wh / BASE_HEIGHT

    love.graphics.push()
    love.graphics.scale(sx, sy)

    for _, scene in pairs(Scenes.Scene_list) do

        -- doesnt draw the current screen if the bool is false
        if scene.shouldDraw then
            for _, button in pairs(scene.buttons) do
                button:draw()
            end
        end
    end

    love.graphics.pop()
end

function love.mousepressed(mx, my, mouse_button)
    if mouse_button ~= 1 then return end

    -- scaling based on window
    local ww, wh = love.graphics.getDimensions()
    local sx = ww / BASE_WIDTH
    local sy = wh / BASE_HEIGHT

    mx = mx / sx
    my = my / sy

    -- goes through all the drawn buttons
    for _, scenes in pairs(Scenes.Scene_list) do
        if scenes.shouldDraw then
            for _, button in pairs(scenes.buttons) do
                button:onClick(mx, my)
            end
        end
    end
end
