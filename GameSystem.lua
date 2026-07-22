local GameSystem = {}

require("Collision")
local cpml = require("cpml")

local config = require("config")
local Player = require("Player")
local Wall = require("Wall")
local Asteroid = require("Asteroid")

WIDTH, HEIGHT = love.graphics.getDimensions()

GameSystem.pause = false
GameSystem.gameover = false

function GameSystem:startGame()
    love.physics.setMeter(64)
    World = love.physics.newWorld(0, 0)
    World:setCallbacks(onCollision)
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
end

function GameSystem:update(dt)
    if not self.pause and not self.gameover then
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
        end
        --for k, wall in pairs(borders) do
        --    wall:collision(player)
        --end
        if love.keyboard.isDown("escape") then
            self.pause = true
        end
    end
    if self.pause then
        if love.keyboard.isDown("return") then
            self.pause = false
        end
    end
end

return GameSystem
