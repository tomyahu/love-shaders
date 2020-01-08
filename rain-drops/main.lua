local DropManager = require("DropManager")

local drop_manager = DropManager.new()

local shader = love.graphics.newShader( "rain.fs" )
local current_time = 0.0
local current_frames = 1

function love.load()
end

function love.update(dt)
    if math.random() < 0.1 then
        drop_manager:addRandomDrop(current_time)
    end
    if current_frames%100 == 0 then
        drop_manager:purge(current_time)
    end

    current_time = current_time + dt
    current_frames = current_frames + 1

    print(# drop_manager:getDrops())
end

function love.draw()
    love.graphics.setShader(shader)
    local screen = {love.graphics.getWidth( ), love.graphics.getHeight( )}

    shader:send("screen", screen)

    local drops = drop_manager:getDrops()
    local times = drop_manager:getTimes()
    local speeds = drop_manager:getExpansionSpeeds()

    if (# drops) == 0 then
        drops = {{4000,4000}}
        times = {current_time}
        speeds = {0}
    end

    shader:send("drop_positions", unpack(drops))
    shader:send("times", unpack(times))
    shader:send("drop_expansion_speeds", unpack(speeds))

    shader:send("time", current_time)

    shader:send("drop_width", drop_manager:getDropWidth())
    shader:send("time_to_disappear", drop_manager:getTimeToDisappear())

    love.graphics.setColor( 79/255, 205/255, 255/255, 1.0 )
    love.graphics.rectangle("fill", 0, 0, screen[1], screen[2])
    love.graphics.setShader()
end

function love.keypressed(k)
    print(k)
end