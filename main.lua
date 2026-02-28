local CONSTANTS = require "CONSTANTS"
local GameState = require "GameState"
local Scenes = require "Scenes"
local audio_list = require "audio_list"

function love.load()
    --[[
    love.window.setMode( 600, 800, {resizable=true} )
    local ww, wh = love.graphics.getDimensions()
    ]]

    love.window.setFullscreen(true)

    Scenes:init()

    local background_music = audio_list.background_music
    background_music:setVolume(0.3)
    background_music:setLooping(true)
    --[[
    background_music:play()
    ]]
end

function love.update(dt)
    GameState.timer = GameState.timer + dt
    Scenes:update(dt)
end

function love.draw()
    -- scaling based on window
    local ww, wh = love.graphics.getDimensions()
    local sx = ww / CONSTANTS.BASE_WIDTH
    local sy = wh / CONSTANTS.BASE_HEIGHT

    love.graphics.push()
    love.graphics.scale(sx, sy)

    Scenes:draw()

    love.graphics.pop()
end

function love.mousepressed(mx, my, mouse_button)
    -- only accepts left mouse clicks
    if mouse_button ~= 1 then return end

    -- scaling based on window
    local ww, wh = love.graphics.getDimensions()
    local sx = ww / CONSTANTS.BASE_WIDTH
    local sy = wh / CONSTANTS.BASE_HEIGHT

    mx = mx / sx
    my = my / sy

    Scenes:onClick(mx, my)
end


