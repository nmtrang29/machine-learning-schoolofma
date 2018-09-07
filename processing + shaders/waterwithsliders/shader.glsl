#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

uniform float time;
uniform float mouseX;
uniform float mouseY;
uniform float waveStrength;
uniform float frequency;
uniform  float waveSpeed;

varying vec4 vertTexCoord;

void main() {
  vec2 uv = vertTexCoord.xy;

	// vec4 sunlightColor = vec4(1.0,0.91,0.75, 1.0);
	// float sunlightStrength = 4.0;
  
  vec2 tapPoint = vec2(mouseX, mouseY);

  float modifiedTime = time * waveSpeed;
  float aspectRatio = 2;
  vec2 distVec = uv - tapPoint;
  distVec.x *= aspectRatio;
  float distance = length(distVec);
  vec2 newTexCoord = uv;
  
  float multiplier = (distance < 1.0) ? ((distance-1.0)*(distance-1.0)) : 0.0;
  float addend = (sin(frequency*distance-modifiedTime)+1.0) * waveStrength * multiplier;
  newTexCoord += addend;    
  
  // float colorToAdd = sunlightColor * sunlightStrength * addend;
    
	vec3 col = texture2D(texture, newTexCoord).rgb;

  gl_FragColor = vec4(col, 1.0);
}
