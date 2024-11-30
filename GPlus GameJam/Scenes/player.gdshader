shader_type canvas_item;


uniform float speed = 1.;

uniform vec4 hint_color = vec4(1., 1.,1., 1.);

uniform float span : hint_range(0.1, 1.) = .3;

uniform bool enable = false;

float luminance(vec4 colour) {
	if (enable){
		return 1.0 - sqrt(0.299*colour.r*colour.r + 0.587*colour.g*colour.g + 0.114*colour.b*colour.b);
	}
		
}

void fragment() {
	if (enable){
	vec4 colour = texture(TEXTURE, UV);
	float target = abs(sin(TIME * PI * speed) * (1. + span));
	if(colour.a > 0.) {
		float lum = luminance(colour);
		float diff = abs(lum - target);
		float mx = clamp(1. - diff / span, 0., 1.);
		colour = mix(colour, hint_color, mx);
		}
		COLOR = colour;
	}
	
	
}