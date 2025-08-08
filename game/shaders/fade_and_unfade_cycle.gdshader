shader_type canvas_item;

uniform float minimum_alpha: hint_range(0.0, 1.0, 0.001);
uniform float fade_speed: hint_range(0.1, 10, 0.1);

void fragment() {
	if (COLOR.a > 0.0) {
		float fade_amount = sin(TIME * fade_speed) + 0.5;
		COLOR.a = minimum_alpha + ((1.0 - minimum_alpha) * fade_amount);
	}
}
