shader_type canvas_item;

uniform float speed = 3;
uniform vec4 color1: source_color;
uniform vec4 color2: source_color;
uniform int number_of_stripes = 24;

void fragment() {
	float motion = (speed * TIME);
	vec2 dir = UV - vec2(0.5);
	float angle = atan(dir.y, dir.x) - motion;
	
	if (mod(floor(angle / (TAU / float(number_of_stripes))), 2) == 0.0) {
		COLOR = color1;
	} 

	else {
		COLOR = color2;
	}
	
}
