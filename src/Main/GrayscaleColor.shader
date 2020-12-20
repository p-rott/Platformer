shader_type canvas_item;

uniform vec3 gray_ratio = vec3(0.21, 0.72,0.07);

uniform bool ignore_pure_red;
uniform bool ignore_pure_green;
uniform bool ignore_pure_blue;

uniform float threshold  : hint_range(0, 0.2, 0.01) = 0.5;

void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	if(!(ignore_pure_red && color.g < threshold && color.b < threshold) && !(ignore_pure_green && color.r < 0.01 && color.b < 0.01) && !(ignore_pure_blue && color.g < 0.01 && color.r < 0.01))
	{

		color.rgb *= gray_ratio;
	    float avg = (color.r + color.g + color.b);
	    color.rgb = vec3(avg);
	}
	COLOR = color;
}
