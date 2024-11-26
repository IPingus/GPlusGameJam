/*
Earthbound battle backgrounds shader with scrolling effect and palette cycling like in the original game.
@retr0_dev

Apply the shader to a TextureRect or a Sprite. Use a texture with some shapes in a transparent background for best results.
You can then use a ColorRect or another method to paint the background.
You can use the shader on multiple TextureRects and obtain a double-buffer effect tweaking the values for each one, remember to Make Unique the shader material.
*/
shader_type canvas_item;

uniform float screen_height = 640.0;
uniform float amplitude = 0.075;
uniform float frequency = 10.0;
uniform float speed = 2.0;
uniform float amplitude_vertical = 0.0;
uniform float frequency_vertical = 0.0;
uniform float speed_vertical = 0.0;
uniform vec2 scroll_direction = vec2(0.0, 0.0);
uniform float scrolling_speed = 0.08;
uniform bool enable_palette_cycling = false;
uniform sampler2D palette;
uniform float palette_speed = 0.1;

/**
Color to use for the shock.
*/
uniform vec3 shock_color : source_color = vec3(1.0, 0.0, 0.0);
/**
Initial amplitude of the shock. This will start at this amplitude and
gradually attenuate.
*/
uniform float amplitudes = 30.0;
/**
How fast shold it move side to side, more frequency means it'll move more quickly
side to side.
*/
uniform float frequecy = 10.0;
uniform bool damaged = false;

void vertex() {
	float exponent = mod(TIME, 3.0);
	VERTEX.x += amplitudes * exp(-3.0*exponent) * sin(frequecy*exponent);
}

void fragment()
{
	float diff_x = amplitude * sin((frequency * UV.y) + (speed * TIME));
	float diff_y = amplitude_vertical * sin((frequency_vertical * UV.y)  + (speed_vertical * TIME));
	vec2 scroll = scroll_direction * TIME * scrolling_speed;
	vec4 tex = texture(TEXTURE, vec2(UV.x + diff_x, UV.y + diff_y) + scroll);
	float palette_swap = mod(tex.r - TIME * palette_speed, 1.0);

	if (enable_palette_cycling)
	{
		COLOR = vec4(texture(palette, vec2(palette_swap, 0)).rgb, tex.a);
	}
	else COLOR = tex;
	COLOR = mix(vec4(0.0), COLOR, float(int(UV.y * screen_height) % 2));
	if(damaged){
		float exponent = mod(TIME, 3.0);
		vec3 normal_color = texture(TEXTURE, UV).rgb;
		COLOR.rgb = normal_color + shock_color * exp(-3.0*exponent);
	}

}
