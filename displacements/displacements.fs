extern Image displacement_tex;
extern float magnitude;

vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords ){
    vec4 displacement_tex_color = Texel(displacement_tex, texture_coords)* magnitude;

    vec2 new_texture_coords = vec2(texture_coords.x + displacement_tex_color.x, texture_coords.y + displacement_tex_color.y);

    vec4 texturecolor = Texel(tex, new_texture_coords);
    return color * texturecolor;
}