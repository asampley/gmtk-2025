shader_type canvas_item;


uniform sampler2D fogMat;
uniform vec4 visionColor: source_color = vec4(0.0, 0.0, 0.0, 0.0);
uniform vec4 echolocationColor: source_color = vec4(1.0, 1.0, 0.0, 1.0);
uniform vec4 unseenColor: source_color = vec4(0.0, 0.0, 0.0, 0.5);
uniform vec2 fogSpeed = vec2(0.01, 0.0);


void fragment() {
	vec4 currentColor = texture(TEXTURE, UV);
	vec4 fogTex = texture(fogMat, mod(UV + TIME * fogSpeed, 1.0));

	if (currentColor.g > 0.0){
		if (currentColor.r > 0.0){
			COLOR = echolocationColor;
		}
		else{
			COLOR = visionColor;
		}
	}
	else{
		if (currentColor.r > 0.0){
			COLOR = echolocationColor;
		}
		else{
			COLOR.rgb = unseenColor.rgb + (fogTex.rgb / vec3(2.0, 2.0, 2.0));
			COLOR.a = unseenColor.a;
		}
	}
}