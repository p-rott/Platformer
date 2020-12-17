shader_type canvas_item;

uniform vec3 gray_ratio = vec3(0.21, 0.72,0.07);

uniform bool ignore_pure_red;
uniform bool ignore_pure_green;
uniform bool ignore_pure_blue;
void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, UV);
	
	if(ignore_pure_red && color.g < 0.01 && color.b < 0.01)
	{
		 COLOR = color;
	}
	else if(ignore_pure_green && color.r < 0.01 && color.b < 0.01)
	{
		 COLOR = color;
	}
	else if(ignore_pure_blue && color.g < 0.01 && color.r < 0.01)
	{
		 COLOR = color;
	}
	else
	{
		
		color.rgb *= gray_ratio;
	    float avg = (color.r + color.g + color.b);
	    COLOR.rgb = vec3(avg);
	}

}

vec4 sample_glow_pixel(sampler2D tex, vec2 uv) {
    float hdr_threshold = 1.0; // Pixels with higher color than 1 will glow
    return max(texture(tex, uv) - hdr_threshold, vec4(0.0));
}