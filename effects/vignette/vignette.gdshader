shader_type canvas_item;

uniform float amount : hint_range(0.0, 1.0) = 0.2; 

void fragment() {
	float x = sin(PI * UV.x);
	float y = sin(PI * UV.y);
	
	COLOR.a = (1.0 - (x * y)) * amount;
}
