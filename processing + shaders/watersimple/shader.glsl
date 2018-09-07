#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 mouse;

uniform float time;
uniform float mouseX;
uniform float mouseY;

// varying vec4 fragColor;
varying vec4 vertColor;
varying vec4 mypos;

// varying vec4 fragTexCoord;
varying vec4 vertTexCoord;
// varying vec4 fragTexCoord;

// float random (vec2 uv) {
//   return fract(sin(dot(uv.xy, vec2(12.9898, 78.233)))*43758.5453123);
//
// }

void main() {
  vec2 uv = vertTexCoord.xy;
  
  float r = length(uv);
  float theta = atan(uv.y, uv.x);

  float pulse = sin(5.0 * r - 8.0 * time);
  vec2 pulse_rect = vec2(pulse * cos(theta), pulse * sin(theta));

  vec3 col = texture2D(texture, uv + 0.02 * pulse_rect).rgb;

  gl_FragColor = vec4(col, 1.0);
}
