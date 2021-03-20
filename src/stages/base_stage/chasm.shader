shader_type canvas_item;
render_mode unshaded;

void fragment() {
	COLOR.a = exp(UV.y) - 1.0;
}
