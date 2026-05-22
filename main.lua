local cpml = require("cpml")

local Player = require("Player")
local Wall = require("Wall")

WIDTH, HEIGHT = love.graphics.getDimensions()

function love.load()
    player = Player:new()
    borders = {
        left = Wall:new(cpml.vec2(0,0), cpml.vec2(0, HEIGHT)),
        right = Wall:new(cpml.vec2(WIDTH,0), cpml.vec2(WIDTH, HEIGHT)),
        top = Wall:new(cpml.vec2(0,0), cpml.vec2(WIDTH, 0)),
        bottom = Wall:new(cpml.vec2(0, HEIGHT), cpml.vec2(WIDTH, HEIGHT)),
    }
end

function love.update(dt)
    player:move()
    player:update(dt)

    for k, wall in pairs(borders) do
        wall:collision(player)
    end
end

function love.draw()
    player:draw()
end
