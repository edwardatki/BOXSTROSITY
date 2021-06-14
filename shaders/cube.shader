shader_type canvas_item;

uniform sampler2D palette : hint_albedo;
uniform float color_scaler;

void fragment () {
	vec4 sample = texture(TEXTURE, UV);
	if ((sample.g > 0.8) && (sample.r < 0.2)  && (sample.b < 0.2)) discard;
	
	float brightness = length(ceil(sample.rgb * 4f) / 4f);
	
	vec2 coords = vec2(clamp(brightness*color_scaler, 0f, 1f), 0);
	if ((sample.r > sample.g)  && (sample.r > sample.b)) coords = vec2(1);
	COLOR.rgb = texture(palette, coords).rgb;
}