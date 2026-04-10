function love.conf(t)
    t.modules.joystick = false
    --TODO remember to turn console to false in final version
    --TODO TRY TO IMPLEMENT TUTORIAL? (JUST LIKE ONE SCREEN OF TEXT)
    t.console = false
    t.window.title = "Poinker"
    t.window.icon = "src/images/icon.png"

    -- uncaps framerate
    --t.window.vsync = 0
end
