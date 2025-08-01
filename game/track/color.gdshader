shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0, 0.0, 0.0, 0.0);
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 screen_color = texture(screen_texture, UV);
	COLOR.rgba = screen_color == color ? vec4(0.0, 0.0, 0.0, 1.0) : screen_color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
