function love.conf(t)
    t.modules.joystick = false
    --TODO remember to turn console to false in final version or smth
    t.console = true
    t.window.title = "Poinker"
    t.window.icon = "src/images/icon.png"

    -- uncaps framerate
    --t.window.vsync = 0
end