local shader = love.graphics.newShader( "canvas_deformation3.fs" )
local current_time = 0.0
local current_frames = 1

local in_points = {
    {0.0, 0.0},
    {0.0, 1.0},
    {1.0, 1.0}
}

local out_points = {
    {0.0, 1.0},
    {1.0, 1.0},
    {1.0, 0.0}
}


function love.load()
    image = love.graphics.newImage("emoji.png")
    canvas = love.graphics.newCanvas(800, 800)

    love.graphics.setCanvas(canvas)
    love.graphics.draw(image, 0, 0)
    love.graphics.setCanvas()
end

function love.update(dt)
    if love.keyboard.isDown("a") then
        current_time = current_time + dt
        current_frames = current_frames + 1
    end


end

function love.draw()
    love.graphics.setShader(shader)

    --local screen = {love.graphics.getWidth( ), love.graphics.getHeight( ) }
    shader:send("in_points", unpack(in_points))
    shader:send("out_points", unpack(out_points))

    love.graphics.draw(canvas, 0, 0)

    love.graphics.setShader()
end

function love.keypressed(k)
    print(k)
end