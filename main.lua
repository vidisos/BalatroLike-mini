local CONSTANTS = require "src.constants"
local GameState = require "src.GameState"
local Scenes = require "src.Scenes"
local Audio = require "src.Audio"

function love.load()
    --[[
    love.window.setMode( 600, 800, {resizable=true} )
    local ww, wh = love.graphics.getDimensions()
    ]]

    love.window.setFullscreen(true)

    Scenes:init()

    Audio:playBackgroundMusic()
end

function love.update(dt)
    GameState.timer = GameState.timer + dt

    local ww, wh = love.graphics.getDimensions()
    local sx = ww / CONSTANTS.BASE_WIDTH
    local sy = wh / CONSTANTS.BASE_HEIGHT

    local mx, my = love.mouse.getPosition()
    GameState.mx = mx / sx
    GameState.my = my / sy

    Scenes:update(dt)
    Scenes:onHover(GameState.mx, GameState.my)
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
