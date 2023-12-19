shader_type canvas_item;

uniform sampler2D noise1 : repeat_enable;
uniform sampler2D noise2 : repeat_enable;
uniform sampler2D wake_texture : filter_linear;

uniform vec2 scroll1 = vec2(.05, .05);
uniform vec2 scroll2 = vec2(-.05, -.05);

uniform float distortion_strength : hint_range(-1, 1) = 0.2;
uniform vec4 tone_color : source_color;
uniform vec4 top_color : source_color;
uniform float light_start : hint_range(0.0, 1.0) = .275;
uniform float light_end : hint_range(0.0, 1.0) = .4;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform vec2 normalized_player_position = vec2(-.05, -.05);

// -.3 is stretched out
uniform float y_stretch_factor = 1.5;

// .5 is stretched out
uniform float wake_clip_threshold = 1.0;

// -.1 is stretched out
uniform float falloff_range = 0.0;

// 2 is stretched out
uniform float scale_size = 3.0;

void fragment() {
    // Calculate the aspect ratio of the wake texture
		// TODO - This should probably be calculated rather than hard coded
    float aspect_ratio = 64.0 / 50.0; // Width divided by height

    // Noise depth calculation
    float original_depth = texture(noise1, UV + scroll1 * TIME).r * texture(noise2, UV + scroll2 * TIME).r;

    // Adjust the wake UV coordinates
    vec2 wake_uv_offset = (UV - normalized_player_position);
    wake_uv_offset.y *= y_stretch_factor / aspect_ratio; // Apply stretching to the Y-axis considering the aspect ratio
    vec2 wake_uv = wake_uv_offset * vec2(textureSize(wake_texture, 0)) / scale_size + vec2(0.5, 0.5);

    // Sample the wake texture
    float wake_influence = texture(wake_texture, wake_uv + scroll1).r;

    // Calculate the lower bound of the falloff range
    float falloff_start = wake_clip_threshold - falloff_range;

    // Apply falloff to the wake influence
    wake_influence *= 1.0 - smoothstep(falloff_start, wake_clip_threshold, wake_uv.y);

    // Apply clipping to the wake effect
    if (wake_uv.y < wake_clip_threshold) {
        wake_influence = 0.0; // Reduces the wake effect below the threshold
    }

    // Combine wake influence with noise depth
    float depth = mix(original_depth, .9, wake_influence);

    vec4 screen_col = texture(SCREEN_TEXTURE, SCREEN_UV + distortion_strength * vec2(depth));
    vec4 top_light = smoothstep(light_start, light_end, depth) * top_color;

    COLOR = screen_col * tone_color + top_light;
    COLOR.a = 1.0; // Cap alpha
}


 //WORKING GREAT WITH WAKE
//void fragment() {
//
    //// Depth calculation without wake
    //float original_depth = texture(noise1, UV + scroll1 * TIME).r * texture(noise2, UV + scroll2 * TIME).r;
//
    //// Calculate the UV coordinates for the wake texture
    //vec2 wake_uv = (UV - normalized_player_position) * vec2(textureSize(wake_texture, 0)) / 3.5 + vec2(0.5, 0.5);
//
    //// Sample the wake texture
    //float wake_influence = texture(wake_texture, wake_uv + scroll1).r;
//
    //// Modify depth based on the wake texture
    //float depth = mix(original_depth, .9, wake_influence);
//
		//vec4 screen_col = texture(SCREEN_TEXTURE, SCREEN_UV + distortion_strength * vec2(depth));
//
    //vec4 top_light = smoothstep(light_start, light_end, depth) * top_color;
    //COLOR = screen_col * tone_color + top_light;
    //COLOR.a = 1.0; // Cap alpha
//}

// BASE WORKING W/O Wake stuff
//void fragment() {
	//float depth = texture(noise1, UV + scroll1 * TIME).r * texture(noise2, UV + scroll2 * TIME).r;
	//vec4 screen_col = texture(SCREEN_TEXTURE, SCREEN_UV + distortion_strength * vec2(depth));
	//vec4 top_light = smoothstep(light_start, light_end, depth) * top_color;
	//
	//COLOR = screen_col * tone_color + top_light;
	//COLOR.a = 1.0; // Cap alpha
//}
