extern vec2 screen;

vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords ){
    vec2 delta_pixel = vec2(1.0/screen.x, 1.0/screen.y);

    vec4 top_texturecolor = Texel(tex, vec2(texture_coords.x, texture_coords.y - delta_pixel.y));
    vec4 bot_texturecolor = Texel(tex, vec2(texture_coords.x, texture_coords.y + delta_pixel.y));
    vec4 right_texturecolor = Texel(tex, vec2(texture_coords.x + delta_pixel.x, texture_coords.y));
    vec4 left_texturecolor = Texel(tex, vec2(texture_coords.x - delta_pixel.x, texture_coords.y));

    vec4 final_blurred_color = (top_texturecolor + bot_texturecolor + right_texturecolor + left_texturecolor)/4.0;

    return final_blurred_color;
}