local GameSystem = require("GameSystem")
local config = require("config")

function love.load()
    -- set physics
    GameSystem.startGame()
end

function love.update(dt)
    GameSystem:update(dt)
end

function love.draw()
    player:draw()
    for k, shot in pairs(shots) do
        shot:draw()
    end
    for k, asteroid in pairs(asteroids) do
        asteroid:draw()
    end
end
