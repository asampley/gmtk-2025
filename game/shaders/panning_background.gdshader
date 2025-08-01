shader_type canvas_item;

uniform vec2 speed = vec2(-0.1, 0.0);
uniform float elapsed;

void fragment() {
	COLOR = texture(TEXTURE, mod(UV + elapsed * speed, 1.0));
}