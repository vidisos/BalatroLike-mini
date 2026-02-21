function love.conf(t)
    t.modules.joystick = false
    t.console = true
    t.window.title = "Poinker"
    t.window.icon = "images/icon.png"

    -- uncaps framerate
    --t.window.vsync = 0
end