extern vec2 screen;
extern vec2 drop_positions[300];
extern float times[300];
extern float drop_expansion_speeds[300];
extern float time;
extern float drop_width;
extern float time_to_disappear;

vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords ){

    float final_color = 0.0;

    int i = 0;
    for (i = 0; i < 300; i++){
        float distance_from_drop = distance(screen_coords/screen, drop_positions[i]);
        float normalized_distance_from_drop = distance_from_drop;
        float final_color_norm = 1 - abs(normalized_distance_from_drop - drop_expansion_speeds[i] * (time - times[i]))/drop_width;
        final_color_norm =  final_color_norm*max(0, (time_to_disappear - (time - times[i])));

        final_color = max(final_color, final_color_norm);
    }

    vec4 color1 = vec4(final_color, final_color, final_color, 1.0);

    return color + color1*0.2;
}