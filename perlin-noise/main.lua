local matrix_lib = require("lib.math.matrixes")

local shader = love.graphics.newShader( "perlin_noise.fs" )
local current_time = 0.0
local current_frames = 1
local rows = 2
local cols = 2
local iterations = 8
local fade_iterations = 3

math.randomseed(os.clock())

local basic_vectors_speed = {}
for i = 1,(# matrix_lib.basic_vectors) do
    local vec_speed = {}
    vec_speed[1] = 0
    vec_speed[2] = 0
    table.insert(basic_vectors_speed, vec_speed)
end


local perlin_matrixes = {}
local perlin_matrixes2 = {}
local r,s = rows,cols
for i = 1,iterations do
    local perlin_matrix = matrix_lib.createRandomPerlinNoiseMatrix(r,s)
    local perlin_matrix2 = matrix_lib.createRandomPerlinNoiseMatrix(r,s)
    table.insert(perlin_matrixes, perlin_matrix)
    table.insert(perlin_matrixes2, perlin_matrix2)
    r = r*2
    s = s*2
end

local canvas = love.graphics.newCanvas()
function love.load()
end

function love.update(dt)
    if love.keyboard.isDown("a") then
        current_time = current_time + dt
        current_frames = current_frames + 1
    end
end

function love.draw()
    local screen = {love.graphics.getWidth( ), love.graphics.getHeight( ) }
    local alpha = 1


    love.graphics.setCanvas(canvas)
        love.graphics.setShader(shader)
        local u,v = rows,cols
        for i = 1,iterations do
            local imageData = love.image.newImageData( v, u )
            for x = 0, (v-1) do
                for y = 0, (u-1) do
                    local r = (perlin_matrixes[i][y+1][x+1][1] + 1)/2
                    local g = (perlin_matrixes[i][y+1][x+1][2] + 1)/2
                    local b = 0.0
                    local a = 1.0
                    imageData:setPixel(x, y, r, g, b, a)
                end
            end

            local image = love.graphics.newImage(imageData)
            image:setFilter("nearest", "nearest")
            image:setWrap("repeat", "repeat")

            shader:send("screen", screen)
            shader:send("perlin_tex", image)
            shader:send("rows", u)
            shader:send("cols", v)
            shader:send("alpha", alpha)
            shader:send("fade_iterations", fade_iterations)

            love.graphics.rectangle("fill", 0, 0, screen[1], screen[2])

            u = u * 2
            v = v * 2
            alpha = alpha / 2
        end
        love.graphics.setShader()
    love.graphics.setCanvas()

    love.graphics.draw(canvas)
end

function love.update(dt)
    -- update speeds
    for i=1,(# matrix_lib.basic_vectors) do
        basic_vectors_speed[i][1] = basic_vectors_speed[i][1] + (math.random()*2 - 1)*dt
        basic_vectors_speed[i][2] = basic_vectors_speed[i][2] + (math.random()*2 - 1)*dt

        basic_vectors_speed[i][1] = math.min(math.max(-0.1, basic_vectors_speed[i][1]),0.1)
        basic_vectors_speed[i][2] = math.min(math.max(-0.1, basic_vectors_speed[i][2]),0.1)
    end

    for i = 1, (# matrix_lib.basic_vectors) do
        matrix_lib.basic_vectors[i][1] = matrix_lib.basic_vectors[i][1] + basic_vectors_speed[i][1]
        matrix_lib.basic_vectors[i][2] = matrix_lib.basic_vectors[i][2] + basic_vectors_speed[i][2]

        matrix_lib.basic_vectors[i][1] = math.min(math.max(-1, matrix_lib.basic_vectors[i][1]),1)
        matrix_lib.basic_vectors[i][2] = math.min(math.max(-1, matrix_lib.basic_vectors[i][2]),1)
    end
end

function love.keypressed(k)
end