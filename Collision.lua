local config = require("config")

function onCollision(fixture_a, fixture_b, contact)
    local categories = { fixture_a:getCategory(), fixture_b:getCategory() }
    local isShotAsteroid = (categories[1] == config.asteroid_mask and categories[2] == config.shot_mask) or 
                           (categories[1] == config.shot_mask and categories[2] == config.asteroid_mask)
    local isPlayerAsteroid = (categories[1] == config.player_mask and categories[2] == config.asteroid_mask) or 
                             (categories[1] == config.asteroid_mask and categories[2] == config.player_mask)
    if isShotAsteroid then
        table.insert(destroyList, fixture_a:getBody())
        table.insert(destroyList, fixture_b:getBody())
    end
    if isPlayerAsteroid then
        table.insert(destroyList, fixture_a:getBody())
        table.insert(destroyList, fixture_b:getBody())
        gameover = true
    end
end

function clearObjects(objectList)
    for i = #objectList, 1, -1 do
        if objectList[i].body:isDestroyed() then
            table.remove(objectList, i)
        end
    end
end

function clearPlayer()
    if gameover then
        player = nil
    end
end
