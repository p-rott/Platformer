shader_type canvas_item;
uniform sampler2D normalMap : hint_normal;
uniform float scale : hint_range(0f, 5f, 0.1) = 1f;
uniform float intensety : hint_range(0f, 1f, 0.01) = 1f;

void fragment(){
	vec3 pointNormal =  texture(normalMap, fract(UV * scale)).rgb;
	
	pointNormal -= 0.5;
	pointNormal.rg *=intensety;
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV - pointNormal.rg );
	COLOR = vec4(SCREEN_PIXEL_SIZE*SCREEN_UV, 0,1);
}
