uniform vec2 in_points[4];
uniform vec2 out_points[4];

vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords ){
    float in_x1 = in_points[0].x;
    float in_x2 = in_points[2].x;
    float in_y1 = in_points[0].y;
    float in_y2 = in_points[2].y;

    vec2 p = texture_coords;
    vec2 p1 = out_points[0];
    vec2 p2 = out_points[3];
    vec2 p3 = out_points[1];
    vec2 p4 = out_points[2];

    float a1 = 0;
    float a2 = 0;
    float a3 = - (p3.x*p1.y - p3.x*p2.y - p1.y*p4.x + p4.x*p2.y);
    float a4 = p1.x*p3.y - p2.x*p3.y;
    float a5 = - p1.x*p4.y + p2.x*p4.y;

    float b1 = - p.y*(p1.x - p2.x - p3.x + p4.x);
    float b2 =   p.x*(p1.y - p2.y);
    float b3 = - (p3.x*p2.y + p1.y*p4.x - 2*p4.x*p2.y);
    float b4 = p2.x*p3.y - p.x*p3.y;
    float b5 = p1.x*p4.y - 2*p2.x*p4.y + p.x*p4.y;

    float c1 = - p.y*(p2.x - p4.x);
    float c2 = p.x*p2.y;
    float c3 = - (p4.x*p2.y);
    float c4 = 0;
    float c5 = p2.x*p4.y - p.x*p4.y;

    float a = a1 + a2 + a3 + a4 + a5;
    float b = b1 + b2 + b3 + b4 + b5;
    float c = c1 + c2 + c3 + c4 + c5;

    float r = -c/b;
    float s = (p.y - (r*p3.y + (1-r)*p4.y))/(r*p1.y + (1-r)*p2.y - r*p3.y - (1-r)*p4.y);

    float new_p_x = in_x2 - r*(in_x2 - in_x1);
    float new_p_y = in_y2 - s*(in_y2 - in_y1);

    vec2 new_point = vec2(new_p_x, new_p_y);

    vec4 texture_color = Texel(tex, new_point);

    float alpha = 0;

    if (r >= 0 && r <= 1 && s >= 0 && s <= 1){
        alpha = 1;
    }

    return texture_color * vec4(1,1,1,alpha);
}
