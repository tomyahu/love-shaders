local DropManager = require("DropManager")

local drop_manager = DropManager.new()

local shader = love.graphics.newShader( "shaders/test.fs" )
local current_time = 0.0
local current_frames = 1

function love.load()
    image = love.graphics.newImage("test_image2.png")
end

function love.update(dt)
    if math.random() < 0.05 then
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

    shader:send("screen", {love.graphics.getWidth( ), love.graphics.getHeight( )})

    local drops = drop_manager:getDrops()
    local times = drop_manager:getTimes()

    if (# drops) == 0 then
        print("aaa")
        drops = {{4000,4000}}
        times = {current_time}
    end

    shader:send("drop_positions", unpack(drops))
    shader:send("times", unpack(times))
    shader:send("time", current_time)

    shader:send("drop_width", drop_manager:getDropWidth())
    shader:send("drop_expansion_speed", drop_manager:getExpansionSpeed())
    shader:send("time_to_disappear", drop_manager:getTimeToDisappear())

    love.graphics.draw(image, 0, 0)

    love.graphics.setShader()
end

function love.keypressed(k)
    print(k)
end