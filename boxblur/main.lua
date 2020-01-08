local shader = love.graphics.newShader( "boxblur.fs" )
local current_time = 0.0
local current_frames = 1

function love.load()
    image = love.graphics.newImage("emoji.png")
end

function love.update(dt)
    if love.keyboard.isDown("a") then
        current_time = current_time + dt
        current_frames = current_frames + 1
    end
end

function love.draw()
    love.graphics.setShader(shader)

    local screen = {love.graphics.getWidth( ), love.graphics.getHeight( ) }
    shader:send("screen", screen)

    love.graphics.draw(image, 0, 0)

    love.graphics.setShader()
end

function love.keypressed(k)
    print(k)
end