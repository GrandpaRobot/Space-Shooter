shader_type canvas_item;


void fragment() {
	 float dist = distance(UV, vec2(0.5, 0.5));
		vec4 good_ring_color = vec4(0.0, 1.0, 0.0, .4);
		vec4 bad_ring_color = vec4(1.0, 0.0, 0.0, .4);
    if (dist < .45 && dist > .40) {
			COLOR = bad_ring_color;
    } else {
      COLOR = vec4(0.0, 0.0, 0.0, 0.0); // Transparent outside the circle
    }

}
