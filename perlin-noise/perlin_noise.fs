uniform vec2 screen;
uniform Image perlin_tex;
uniform int rows;
uniform int cols;
uniform float alpha;
uniform int fade_iterations;

float fade(float t){
    return 6*pow(t,5) - 15*pow(t,4) + 10*pow(t,3);
}

vec2 fadeVec2(vec2 v){
    return vec2(fade(v.x), fade(v.y));
}

vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords ){
    vec2 norm_screen_coord = screen_coords/screen;

    float col = norm_screen_coord.x*(cols-1);
    float row = norm_screen_coord.y*(rows-1);

    float p_col = (floor(col));
    float n_col = (ceil(col));
    float p_row = (floor(row));
    float n_row = (ceil(row));

    vec2 tl_point = vec2(p_col/(cols-1),p_row/(rows-1));
    vec2 tr_point = vec2(n_col/(cols-1),p_row/(rows-1));
    vec2 bl_point = vec2(p_col/(cols-1),n_row/(rows-1));
    vec2 br_point = vec2(n_col/(cols-1),n_row/(rows-1));

    vec4 tl_perlin_vec = Texel(perlin_tex, tl_point);
    vec4 tr_perlin_vec = Texel(perlin_tex, tr_point);
    vec4 bl_perlin_vec = Texel(perlin_tex, bl_point);
    vec4 br_perlin_vec = Texel(perlin_tex, br_point);

    vec2 aux_screen_coord = (vec2((norm_screen_coord.x - tl_point.x) * (cols-1), (norm_screen_coord.y - tl_point.y) * (rows-1)));

    vec2 tl_distance = aux_screen_coord;
    vec2 tr_distance = aux_screen_coord - vec2(1,0);
    vec2 bl_distance = aux_screen_coord - vec2(0,1);
    vec2 br_distance = aux_screen_coord - vec2(1,1);

    float tl_val = dot(vec2(tl_perlin_vec) * 2 - 1, tl_distance);
    float tr_val = dot(vec2(tr_perlin_vec) * 2 - 1, tr_distance);
    float bl_val = dot(vec2(bl_perlin_vec) * 2 - 1, bl_distance);
    float br_val = dot(vec2(br_perlin_vec) * 2 - 1, br_distance);

    aux_screen_coord = fadeVec2(aux_screen_coord);

    float top_val = tl_val + aux_screen_coord.x * (tr_val - tl_val);
    float bot_val = bl_val + aux_screen_coord.x * (br_val - bl_val);

    float ponderated_val = top_val + aux_screen_coord.y * (bot_val - top_val);
    ponderated_val = (ponderated_val + 1) / 2;

    int i = 0;
    for(i = 0; i < fade_iterations; i++){
        ponderated_val = fade(ponderated_val);
    }

    return vec4(ponderated_val,ponderated_val,ponderated_val,alpha);
}