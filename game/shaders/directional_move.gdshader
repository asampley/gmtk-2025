shader_type canvas_item;

uniform float speed;
uniform vec2 direction;
uniform float time;

void vertex() {
	vec2 amount = direction * speed * time;
	vec2 scrolled_uv = UV + amount;
	VERTEX += scrolled_uv;
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
}

