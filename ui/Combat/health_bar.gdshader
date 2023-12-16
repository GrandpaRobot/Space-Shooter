shader_type canvas_item;

uniform float normalized_health_amount;
uniform vec4 fill_color = vec4(0.66, 0.06, 0.06, 1.0); // TODO - why isn't this default actually working?

void fragment() {
    float dist = distance(UV, vec2(0.5, 0.5));

    if (dist < .45 && UV.y > (1.0 - normalized_health_amount)) {
        // Apply the accumulated blend factor to mix the colors
		vec4 textureColor = texture(TEXTURE, UV + vec2(0.1, 0.1));
        //COLOR = vec4(1.0, 0, 0, 1.0);
        COLOR = mix(textureColor, fill_color, .94); // Resource color
	} else if (dist < .45 && UV.y > .995 - normalized_health_amount){
		COLOR = vec4(0.86, 0.52, 0.52, 1.0); // TODO - Trying to add a shine at the top?
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0); // Transparent outside the circle
    }
}
