shader_type canvas_item;
uniform sampler2D rainNoise : hint_black;
uniform float scale: hint_range(0f, 5f, 0.01)  = 1f ;
uniform float rainAlpha : hint_range(0f, 1f, 0.01) = 1f;
uniform float intensety :hint_range(0f,1f, 0.05);
uniform float speed : hint_range(0f, 5f, 0.1);
uniform float threshold : hint_range(0, 1f, 0.1);
uniform vec2 direction = vec2(0, 1f);
uniform vec4 colortilt : hint_color = vec4(1f,1f,1f, 1f);

uniform bool debug = false;
uniform bool lightON = true;

void fragment(){
	vec2 movement = direction * speed * TIME;
	vec3 noisePoint = texture(rainNoise, fract(SCREEN_UV/scale+movement)).rgb;
	
	vec2 displacement = vec2(normalize(noisePoint).r *0.05 * intensety);
	
	vec2 uv = SCREEN_UV + displacement;
	if(uv.x < 0f){uv.x=0f;}else if(uv.x>1f){uv.x = 1f;}
	if(uv.y < 0f){uv.y=0f;}else if(uv.y>1f){uv.y = 1f;}
	if(noisePoint.r >=  threshold)
	{
		if(debug)
		{
			COLOR = vec4(noisePoint,1 );
		}
		else
			COLOR = vec4(texture(SCREEN_TEXTURE, uv).rgb * colortilt.rgb, rainAlpha) ;
		//COLOR = vec4(noisePoint,rainAlpha)
	}
	else
	{
		if(debug)
		{
			COLOR = vec4(noisePoint,1 );
		}
		else
			COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
		
	}
}
