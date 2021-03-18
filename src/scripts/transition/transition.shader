shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0);

const float PI = 3.14159265358979323846;
const float TAU = PI * 2.0;

void fragment() {
	vec2 uv = (UV - vec2(0.5, 0.5)) * 2.0;
	float angle = atan(uv.x, uv.y) + PI;
	float value = 1.0 - angle / TAU;
	
	COLOR *= step(value, progress);
}
