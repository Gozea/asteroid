local math = require("math")
local cpml = require("cpml")

local config = require("config")

local Asteroid = {}

function Asteroid:new(x, y)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    x, y, vx, vy = self:randomSpawn()
    instance.body = love.physics.newBody(World, x, y, "dynamic")
    instance.shape = love.physics.newCircleShape(math.random(config.asteroid_min_size, config.asteroid_max_size))
    instance.fixture = love.physics.newFixture(instance.body, instance.shape)
    instance.fixture:setCategory(config.asteroid_mask)
    instance.fixture:setMask(config.wall_mask)
    -- launch at creation
    instance.body:applyLinearImpulse(vx*math.random(config.asteroid_min_impulse, config.asteroid_max_impulse), vy*math.random(config.asteroid_min_impulse, config.asteroid_max_impulse))
    return instance
end

function Asteroid:draw()
    local x, y = self.body:getPosition()
    love.graphics.circle("line", x, y, self.shape:getRadius())
end

function Asteroid:randomSpawn()
    local randomizeDimension = math.random(2) -- choose random x or y axis
    local x, y, vx, vy
    if randomizeDimension == 1 then
        x = (math.random(2)-1)*WIDTH --will eith suck the left or right wall
        y = math.random(HEIGHT)
        vx = x == 0 and 1 or -1 -- goes right if spawn on the left ; goes left if spawn on right
        vy = math.random(-HEIGHT/2, HEIGHT/2)/(HEIGHT/2)
    else 
        x = math.random(WIDTH)
        y = (math.random(2)-1)*HEIGHT --will eith suck the top or bottom wall
        vx = math.random(-WIDTH/2, WIDTH/2)/(WIDTH/2)
        vy = y == 0 and 1 or -1 -- goes top if spawn on the bottom ; goes bottom if spawn on top
    end
    return x, y, vx, vy
end

return Asteroid
