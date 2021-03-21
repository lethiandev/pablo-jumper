shader_type canvas_item;

uniform sampler2D texture_mask: hint_white;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec4 mask = texture(texture_mask, UV);
	
	COLOR = color;
	COLOR.a *= mask.a;
}
