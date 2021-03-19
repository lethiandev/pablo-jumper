shader_type canvas_item;

uniform float coverage : hint_range(0.0, 1.0);

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec3 blink = mix(color.rgb, vec3(1.0), coverage);
	
	COLOR = vec4(blink, color.a);
}
