shader_type canvas_item;

uniform float dissolveAmount = 1.0;

float random_coord(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898,96.233))) * 43758.5453);
}

void fragment() {
	vec2 texture_resolution = 1.0 / TEXTURE_PIXEL_SIZE;
	vec2 pixel_within_texture = floor(UV * texture_resolution);
	vec4 texture_color = texture(TEXTURE, UV);

	if (dissolveAmount < random_coord(pixel_within_texture)) {
		COLOR = texture_color;
	}
	else {
		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	}
}