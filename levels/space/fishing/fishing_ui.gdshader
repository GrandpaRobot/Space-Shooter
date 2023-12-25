shader_type canvas_item;

uniform float base_radius = .5;  // Relative to the node size
uniform float line_width = 0.2;  // Also relative
uniform float feathering = 0.02; // Line edge feathering amount
uniform float circumference_width = 0.02; // Line around the circumferance width
uniform float bulge_size = 0.05; // Size of the bulge

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

    // Determine the angle for the arc
    float angle = atan(norm_coord.y, norm_coord.x);
    if (angle < 0.0) {
        angle += 2.0 * PI;  // Convert negative angles to positive range
    }

    bool in_arc = angle >= good_arc_min && angle <= good_arc_max;

    // Adjust the outer radius based on the angle
    float modified_outer_radius = base_radius - circumference_width;
    if (in_arc) {
				float dist_from_arc_middle = min(angle - good_arc_min, good_arc_max - angle) * 2.0;
        modified_outer_radius += bulge_size * dist_from_arc_middle;
    }

    float inner_radius = base_radius - line_width / 2.0 - circumference_width;
    float outer_radius = modified_outer_radius;

    // Adjusted alpha calculation
    float alpha_inner = smoothstep(inner_radius - feathering, inner_radius, dist);
    float alpha_outer = step(dist, outer_radius + circumference_width);
    float alpha = alpha_inner * alpha_outer - alpha_subtract;

    vec4 final_color = in_arc ? sweet_spot_color : base_color;
    final_color = dist >= outer_radius ? circumference_color : final_color;

    COLOR = vec4(final_color.rgb, final_color.a * alpha);
}

//void fragment() {
    //vec2 center = vec2(0.5, 0.5);
    //float dist = distance(UV, center);
    //vec2 norm_coord = (UV - center);
//
    //float inner_radius = base_radius - line_width / 2.0 - circumference_width;
    //float outer_radius = base_radius - circumference_width;
//
    //// Adjusted alpha calculation
		//float alpha_inner = smoothstep(inner_radius - feathering, inner_radius, dist);
    //float alpha_outer = step(dist, outer_radius + circumference_width);
    //float alpha = alpha_inner * alpha_outer - alpha_subtract;
//
    ////// Determine the angle for the arc
    //float angle = atan(norm_coord.y, norm_coord.x);
    //if (angle < 0.0) {
        //angle += 2.0 * PI;  // Convert negative angles to positive range
    //}
    //bool in_arc = angle >= good_arc_min && angle <= good_arc_max;
//
    //vec4 final_color = in_arc ? sweet_spot_color : base_color;
    //final_color = dist >= outer_radius ? circumference_color : final_color;
//
    //COLOR = vec4(final_color.rgb, final_color.a * alpha);
//}

