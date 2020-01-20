uniform vec2 in_points[3];
uniform vec2 out_points[3];

vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords ){
    vec2 p = texture_coords;

    vec2 p1 = out_points[0];
    vec2 p2 = out_points[1];
    vec2 p3 = out_points[2];

    // use barycentric coordinates in triangles
    float k = ((p2.y - p3.y)*(p1.x - p3.x) + (p3.x - p2.x)*(p1.y - p3.y));

    float lambda1 = ((p2.y - p3.y)*(p.x - p3.x) + (p3.x - p2.x)*(p.y - p3.y)) / k;
    float lambda2 = ((p3.y - p1.y)*(p.x - p3.x) + (p1.x - p3.x)*(p.y - p3.y)) / k;
    float lambda3 = 1 - lambda1 - lambda2;

    p1 = in_points[0];
    p2 = in_points[1];
    p3 = in_points[2];

    vec2 original_point = p1*lambda1 + p2*lambda2 + p3*lambda3;

    vec4 texture_color = Texel(tex, original_point);

    float alpha = 0;

    if ((lambda1 > 0) && (lambda1 < 1) && (lambda2 > 0) && (lambda2 < 1) && (lambda3 > 0) && (lambda3 < 1)){
        alpha = 1;
    }


    return texture_color * vec4(1,1,1,alpha);
}
