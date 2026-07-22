local GameSystem = require("GameSystem")

function love.load()
    -- set physics
    GameSystem.startGame()
end

function love.update(dt)
    GameSystem:update(dt)
end

function love.draw()
    if not gameover then
        player:draw()
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
