local shader = love.graphics.newShader( "canvas_deformation2.fs" )
local current_time = 0.0
local current_frames = 1

local in_points = {
    {0.0, 0.0},
    {0.0, 1.0},
    {1.0, 1.0},
    {1.0, 0.0}
}

local out_points = {
    {0.3, 0.2},
    {0.2, 0.8},
    {0.8, 0.8},
    {0.8, 0.2}
}
------------------------------------------------------------------------------------------------------------------------
local p = {0.55, 0.2}

local in_x1 = in_points[1][1];
local in_x2 = in_points[3][1];
local in_y1 = in_points[1][2];
local in_y2 = in_points[3][2];

local p1 = out_points[1];
local p2 = out_points[4];
local p3 = out_points[2];
local p4 = out_points[3];

local a1 = 0;
local a2 = 0;
local a3 = - (p3[1]*p1[2] - p3[1]*p2[2] - p1[2]*p4[1] + p4[1]*p2[2]);
local a4 = p1[1]*p3[2] - p2[1]*p3[2];
local a5 = - p1[1]*p4[2] + p2[1]*p4[2];

local b1 = - p[2]*(p1[1] - p2[1] - p3[1] + p4[1]);
local b2 =   p[1]*(p1[2] - p2[2]);
local b3 = - (p3[1]*p2[2] + p1[2]*p4[1] - 2*p4[1]*p2[2]);
local b4 = p2[1]*p3[2] - p[1]*p3[2];
local b5 = p1[1]*p4[2] - 2*p2[1]*p4[2] + p[1]*p4[2];

local c1 = - p[2]*(p2[1] - p4[1]);
local c2 = p[1]*p2[2];
local c3 = - (p4[1]*p2[2]);
local c4 = 0;
local c5 = p2[1]*p4[2] - p[1]*p4[2];

local a = a1 + a2 + a3 + a4 + a5;
local b = b1 + b2 + b3 + b4 + b5;
local c = c1 + c2 + c3 + c4 + c5;

local r = -c/b;
local s = (p[2] - (r*p3[2] + (1-r)*p4[2]))/(r*p1[2] + (1-r)*p2[2] - r*p3[2] - (1-r)*p4[2]);

local new_p_x = in_x2 - r*(in_x2 - in_x1);
local new_p_y = in_y2 - s*(in_y2 - in_y1);

print(r, s)
print(new_p_x, new_p_y)

------------------------------------------------------------------------------------------------------------------------


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