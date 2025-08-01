shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0, 0.0, 0.0, 0.0);
uniform float threshold = 0.1;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable;


void fragment() {
	// Called for every pixel the material is visible on.
	vec4 screen_color = textureLod(screen_texture, SCREEN_UV, 0.0);
	vec4 replacement_color = texture(TEXTURE, UV);
	
	float color_distance = length(screen_color.rgb - color.rgb);
	COLOR.rgb = color_distance <= threshold ? replacement_color.rgb : screen_color.rgb;
}

