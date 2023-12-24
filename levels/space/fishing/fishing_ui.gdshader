shader_type canvas_item;

uniform float base_radius = .5;  // Relative to the node size
uniform float line_width = 0.2;  // Also relative
uniform float feathering = 0.02; // Line edge feathering amount
uniform float circumference_width = 0.02; // Line around the circumferance width

uniform float alpha_subtract = .5; // Blanket alpha reduction
uniform vec4 base_color : source_color = vec4(0.81, 0.39, 0.29, 1.0);
uniform vec4 sweet_spot_color : source_color = vec4(0.0, 1.0, 0.12, 1.0);
uniform vec4 circumference_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);

uniform float good_arc_min; // In radians
uniform float good_arc_max; // In radians


void fragment() {
    vec2 center = vec2(0.5, 0.5);
    float dist = distance(UV, center);
    vec2 norm_coord = (UV - center);

    float inner_radius = base_radius - line_width / 2.0 - circumference_width;
    float outer_radius = base_radius - circumference_width;

    // Adjusted alpha calculation
    float alpha_inner = step(inner_radius, dist);
    float alpha_outer = step(dist, outer_radius + circumference_width);
    float alpha = alpha_inner * alpha_outer - alpha_subtract;

    //// Determine the angle for the arc
    float angle = atan(norm_coord.y, norm_coord.x);
    if (angle < 0.0) {
        angle += 2.0 * PI;  // Convert negative angles to positive range
    }
    bool in_arc = angle >= good_arc_min && angle <= good_arc_max;

    vec4 final_color = in_arc ? sweet_spot_color : base_color;
    final_color = dist >= outer_radius ? circumference_color : final_color;

    COLOR = vec4(final_color.rgb, final_color.a * alpha);
}

//void fragment() {
    //vec2 center = vec2(0.5, 0.5);
    //float dist = distance(UV, center);
    //vec2 norm_coord = (UV - center);
//
    //// Adjust the base radius to fit the edge within the node
    //float adjusted_base_radius = base_radius;
//
    //// Calculate alpha for the main circle (without outer feathering)
    //float inner_radius = adjusted_base_radius - line_width / 2.0;
    //float outer_radius = adjusted_base_radius + line_width / 2.0;
    //float alpha = smoothstep(inner_radius, outer_radius, dist);
//
    //// Determine the angle for the arc
    ////float angle = atan(norm_coord.y, norm_coord.x);
    ////if (angle < 0.0) {
        ////angle += 2.0 * PI;  // Convert negative angles to positive range
    ////}
    ////bool in_arc = angle >= good_arc_min && angle <= good_arc_max;
//
    //// Determine the final color
    ////vec4 final_color = in_arc ? sweet_spot_color : base_color;
    //vec4 final_color = base_color;
    ////final_color = dist >= adjusted_base_radius ? circumference_color : final_color;
    //COLOR = vec4(final_color.rgb, final_color.a * alpha);
//}

//
//void fragment() {
	  //vec2 center = vec2(0.5, 0.5);
    //float dist = distance(UV, center);
 		//vec2 norm_coord = (UV - center);
//
    //float adjusted_radius = base_radius - (line_width / 2.0);
    //float alpha = smoothstep(adjusted_radius - feathering, adjusted_radius, dist) -
                  //smoothstep(base_radius - feathering, base_radius + feathering, dist) - alpha_subtract;
//
    //float angle = atan(norm_coord.y, norm_coord.x);
    //if (angle < 0.0) {
        //angle += 2.0 * PI;  // Convert negative angles to positive range
    //}
		//bool in_arc = angle >= good_arc_min && angle <= good_arc_max;
//
    //vec4 final_color = in_arc ? sweet_spot_color : base_color;
		//final_color = dist >= (base_radius + 0.001) ? circumference_color : final_color;
    //COLOR = vec4(final_color.rgb, final_color.a * alpha);
//}

