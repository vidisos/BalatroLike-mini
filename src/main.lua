local CONSTANTS = require "constants"
local Scenes = require "Scenes"
local audio_list = require "audio"

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setFullscreen(true)

    --[[    
        love.window.setMode( 600, 800, {resizable=true} )
        local ww, wh = love.graphics.getDimensions()
    ]]

    Scenes:init()

    local background_music = audio_list.background_music
    background_music:setVolume(0.04)
    background_music:setLooping(true)
    background_music:play()

end

function love.update(dt)

end

function love.draw()
    -- scaling based on window
    local ww, wh = love.graphics.getDimensions()
    local sx = ww / CONSTANTS.BASE_WIDTH
    local sy = wh / CONSTANTS.BASE_HEIGHT

    love.graphics.push()
    love.graphics.scale(sx, sy)

    for _, scene in ipairs(Scenes.scene_list) do
        if scene.shouldDraw then
            for _, item in ipairs(scene.drawables) do
                item.drawable:draw()
            end
        end
    end

    love.graphics.pop()
end

function love.mousepressed(mx, my, mouse_button)
    if mouse_button ~= 1 then return end

    -- scaling based on window
    local ww, wh = love.graphics.getDimensions()
    local sx = ww / CONSTANTS.BASE_WIDTH
    local sy = wh / CONSTANTS.BASE_HEIGHT

    mx = mx / sx
    my = my / sy

    -- goes through all the drawables and if they can be clicked they do the onClick check
    for _, scene in ipairs(Scenes.scene_list) do
        if scene.shouldDraw then
            for _, item in ipairs(scene.drawables) do
                if item.drawable.isClickable then
                    item.drawable:onClick(mx, my)
                end
            end
        end
    end
end


