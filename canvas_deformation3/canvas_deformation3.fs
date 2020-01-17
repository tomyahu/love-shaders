uniform vec2 in_points[3];
uniform vec2 out_points[3];

vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords ){
    vec2 p = texture_coords;

    vec2 p1 = out_points[0];
    vec2 p2 = out_points[1];
    vec2 p3 = out_points[2];
    vec2 p4 = out_points[3];

    // use barycentric coordinates in triangles
    float lambda1


    vec2 original_point = alpha*x1 + beta*y1 + o1;

    vec4 texture_color = Texel(tex, original_point);

    return texture_color;
}
