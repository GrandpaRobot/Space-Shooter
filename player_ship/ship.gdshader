shader_type canvas_item;

uniform float hit_angle[5];

void fragment() {
    vec2 center = vec2(0.5, 0.5);
    vec4 shield_color = vec4(0.75, 0.57, 0.24, 1.0);
    vec4 hit_color = vec4(0.84, 0.26, 0.26, .2); // Red hit color
    float dist = distance(UV, center);
    float angle_of_point = atan(UV.y - center.y, UV.x - center.x);

    // Normalize the angle
    angle_of_point = mod(angle_of_point, 2.0 * PI);

    // Initialize a variable to accumulate blend factors
    float total_blend_factor = 0.0;

    // Draw the circle
    if (dist > .4 && dist < .45) {
        for (int i = 0; i < 5; ++i) {
			if(hit_angle[i] == 0.0) break;
            float normalized_hit_angle = mod(hit_angle[i], 2.0 * PI);
            float angle_diff = abs(angle_of_point - normalized_hit_angle);
            angle_diff = min(angle_diff, 2.0 * PI - angle_diff);
            float fade_width = 0.3; // Width of the fade effect
            float blend_factor = smoothstep(fade_width, 0.0, angle_diff);

            // Accumulate the blend factor
            total_blend_factor = max(total_blend_factor, blend_factor);
        }

        // Apply the accumulated blend factor to mix the colors
        COLOR = mix(shield_color, hit_color, total_blend_factor);
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0); // Transparent outside the circle
    }
}

//void fragment() {
    //vec2 center = vec2(0.5, 0.5);
    //vec4 shield_color = vec4(0.75, 0.57, 0.24, 1.0);
    //vec4 hit_color = vec4(0.84, 0.26, 0.26, 1.0); // Red hit color
    //float dist = distance(UV, center);
    //float angle_of_point = atan(UV.y - center.y, UV.x - center.x);
//
    //// Normalize the angle
    //angle_of_point = mod(angle_of_point, 2.0 * PI);
//
    //// Draw the circle
    //if (dist > .4 && dist < .45) {
    	//float normalized_hit_angle = mod(hit_angle, 2.0 * PI);
        //float angle_diff = abs(angle_of_point - normalized_hit_angle);
        //angle_diff = min(angle_diff, 2.0 * PI - angle_diff);
        //float fade_width = 0.3; // Width of the fade effect
        //float blend_factor = smoothstep(fade_width, 0.0, angle_diff); // Inverted smoothstep for fading out
//
        //COLOR = mix(shield_color, hit_color, blend_factor);
    //} else {
        //COLOR = vec4(0.0, 0.0, 0.0, 0.0); // Transparent outside the circle
    //}
//}
