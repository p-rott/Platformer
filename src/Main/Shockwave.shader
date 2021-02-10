shader_type canvas_item;
const vec2 center = vec2(0.5);

uniform float force : hint_range(0.0,0.1, 0.01) = 0.1;
uniform float size : hint_range(0.0,1f, 0.01) = 0.0;
uniform float width : hint_range(0, 0.1, 0.01) = 0.05;
uniform float caFactor : hint_range(0, 0.2, 0.01) =0.1; 
void fragment()
{
	
	float mask = (1f- smoothstep(size - width, size, length(UV-center))) *
	smoothstep(size - 2f*width, size-width, length(UV-center)) * smoothstep(0.5,0.4, length(UV-center));
	vec2 dispR = normalize(UV-center-caFactor) * force * mask;
	vec2 dispG = normalize(UV-center) * force * mask;
	vec2 dispB = normalize(UV-center+caFactor) * force * mask;
	COLOR.r = texture(SCREEN_TEXTURE, SCREEN_UV - dispR).r; 
	COLOR.g = texture(SCREEN_TEXTURE, SCREEN_UV - dispG).g;
	COLOR.b = texture(SCREEN_TEXTURE, SCREEN_UV - dispB).b;
}
void light()
{
	float mask = (1f- smoothstep(size - width, size, length(UV-center))) *
	smoothstep(size - 2f*width, size-width, length(UV-center)) * smoothstep(0.5,0.4, length(UV-center));
	LIGHT = mix(LIGHT, LIGHT_COLOR, 0.5) * mask;
}