shader_type canvas_item;

uniform float speed;
uniform vec2 direction;

void vertex() {
	vec2 amount = direction * speed * TIME;
	vec2 scrolled_uv = UV + amount;
	VERTEX += scrolled_uv;
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
}

