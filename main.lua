require("Player")

function love.load()
    player = Player:new()
end

function love.update(dt)
    player:move()
    player:update(dt)
end

function love.draw()
    player:draw()
end
