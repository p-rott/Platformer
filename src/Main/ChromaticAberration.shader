shader_type canvas_item;

uniform float offset = 1f;
uniform float amount : hint_range(0, 1) = 1f;
uniform sampler2D noise : hint_white;
uniform bool ignore_pure_red;
uniform bool ignore_pure_green;
uniform bool ignore_pure_blue;
void fragment()
	{
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);

	vec4 noiseOffset = texture(noise,vec2(SCREEN_UV.x + (offset * SCREEN_PIXEL_SIZE.x * sin(TIME*2f)), SCREEN_UV.y + (offset * SCREEN_PIXEL_SIZE.y * cos(TIME*5f))));
	
	vec3 offsetColorG = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x + (offset * SCREEN_PIXEL_SIZE.x * sin(TIME*2f) * noiseOffset.r * amount), SCREEN_UV.y + (offset * SCREEN_PIXEL_SIZE.y * cos(TIME*3f) * noiseOffset.r * amount)) ).rgb;
	vec3 offsetColorB = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x - (offset * SCREEN_PIXEL_SIZE.x * sin(TIME*3f) * noiseOffset.r * amount), SCREEN_UV.y - (offset * SCREEN_PIXEL_SIZE.y * cos(TIME*2f) * noiseOffset.r * amount))).rgb;
	
	if(!(ignore_pure_red && color.g < 0.01 && color.b < 0.01) && !(ignore_pure_green && color.r < 0.01 && color.b < 0.01) && !(ignore_pure_blue && color.g < 0.01 && color.r < 0.01))
	{
	color.g = offsetColorG.g;
	color.r = color.r;
	color.b = offsetColorB.b;
	}
	COLOR = color;
}