local shader = love.graphics.newShader( "displacements.fs" )
local current_time = 0.0
local current_frames = 1

function love.load()
    image = love.graphics.newImage("test_image2.png")
    image2 = love.graphics.newImage("Displacements.png")
end

function love.update(dt)
    if love.keyboard.isDown("a") then
        current_time = current_time + dt
        current_frames = current_frames + 1
    end
end

function love.draw()
    love.graphics.setShader(shader)

    shader:send("displacement_tex", image2)
    shader:send("magnitude", current_time/25)

    love.graphics.draw(image, 0, 0)

    love.graphics.setShader()
end

function love.keypressed(k)
    print(k)
end