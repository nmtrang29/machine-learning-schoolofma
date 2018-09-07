//https://www.shadertoy.com/view/MdlGRB

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 mouse;

uniform float time;
uniform float mouseX;
uniform float mouseY;

varying vec4 vertTexCoord;

void main() {
  vec2 uv = vertTexCoord.xy;

	float dispersion = .01;
	float distortion = .04;
	float noisestrength = .2;
	float bendscale = 1.5;

	vec2 disp = uv - vec2(.5, .5);
	disp *= sqrt(length(disp));
	uv += disp * bendscale;
	uv = (uv + .5)/2.0;
	vec2 uvr = uv * (1.0 - dispersion) + vec2(dispersion, dispersion)/2.0;
	vec2 uvg = uv * 1.0;
	vec2 uvb = uv * (1.0 + dispersion) - vec2(dispersion, dispersion)/2.0;

	vec3 offset = texture2D(texture, vec2(0, uv.y + time * 255.0)).xyz;


	float r = mix(texture2D(texture, vec2(1.0 - uvr.x, uvr.y) + offset.x * distortion).xyz,
				   offset, noisestrength).x;
	float g = mix(texture2D(texture, vec2(1.0 - uvg.x, uvg.y) + offset.x * distortion).xyz,
				   offset, noisestrength).y;
	float b = mix(texture2D(texture, vec2(1.0 - uvb.x, uvb.y) + offset.x * distortion).xyz,
				   offset, noisestrength).z;

	if (uv.x > 0.0 && uv.x < 1.0 && uv.y > 0.0 && uv.y < 1.0) {
		float stripes = sin(uv.y * 300.0 + time * 10.0);
		vec3 col = vec3(r, g, b);
		col = mix(col, vec3(.8), stripes / 20.0);
		gl_FragColor = vec4(col, 1.0);
	} else {
		gl_FragColor = vec4(0, 0, 0, 1);	
	}
}