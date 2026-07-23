local GameSystem = require("GameSystem")

function love.load()
    GameSystem.startGame()
    -- load shaders
    player_shader = love.graphics.newShader("assets/shaders/player_shader.glsl")
end

function love.update(dt)
    GameSystem:update(dt)
    player_shader:send("time", love.timer.getTime())
end

function love.draw()
    if not gameover then
        love.graphics.setShader(player_shader)
        player:draw()
        love.graphics.setShader()
    end
    for k, shot in pairs(shots) do
        shot:draw()
    end
    for k, asteroid in pairs(asteroids) do
        asteroid:draw()
    end
    if gameover then
        love.graphics.draw(gameOverText, WIDTH/2-gameOverText:getWidth()/2, HEIGHT/2)
    end
end
