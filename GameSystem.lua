local GameSystem = {}

require("Collision")
local cpml = require("cpml")

local config = require("config")
local Player = require("Player")
local Wall = require("Wall")
local Asteroid = require("Asteroid")

WIDTH, HEIGHT = love.graphics.getDimensions()

love.graphics.setFont (love.graphics.newFont (30))

font = love.graphics.getFont()
gameOverText = love.graphics.newText(font)
textHeight = font:getHeight()
gameOverText:add( {{1,1,1}, "Game Over"}, 0, 0, 0, 1, 1, -20, 0, 0, 0)
gameOverText:add( {{1,1,1}, "Press Enter to restart"}, 0, 0, 0, 0.7, 0.7, 0, -1.6*textHeight, 0,0)

function GameSystem:startGame()
    -- set world
    love.physics.setMeter(64)
    World = love.physics.newWorld(0, 0)
    World:setCallbacks(onCollision)
    -- set objects
    player = Player:new()
    borders = {
        left = Wall:new(cpml.vec2(0,0), cpml.vec2(0, HEIGHT)),
        right = Wall:new(cpml.vec2(WIDTH,0), cpml.vec2(WIDTH, HEIGHT)),
        top = Wall:new(cpml.vec2(0,0), cpml.vec2(WIDTH, 0)),
        bottom = Wall:new(cpml.vec2(0, HEIGHT), cpml.vec2(WIDTH, HEIGHT)),
    }
    asteroids = {}
    shots = {}
    -- bodies to clear
    destroyList = {}
    -- variables
    pause = false
    gameover = false
end

function GameSystem:update(dt)
    if not pause and not gameover then
        World:update(dt)
        player:move(dt)
        if love.timer.getTime() % config.asteroid_spawn_frequency <= dt then
            local asteroid = Asteroid:new(math.random(WIDTH), math.random(HEIGHT))
            table.insert(asteroids, asteroid)
        end

        for i = #destroyList, 1, -1 do
            destroyList[i]:destroy()
            table.remove(destroyList, i)
            -- clear list with object with no body
            clearObjects(shots)
            clearObjects(asteroids)
            clearPlayer()
        end
        --for k, wall in pairs(borders) do
        --    wall:collision(player)
        --end
        if love.keyboard.isDown("escape") then
            pause = true
        end
    end
    if pause then
        if love.keyboard.isDown("return") then
            pause = false
        end
    end
    if gameover then
        if love.keyboard.isDown("return") then
            gameover = false
            self.startGame()
        end
    end
end


return GameSystem
