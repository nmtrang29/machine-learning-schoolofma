#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 mouse;

uniform float time;

uniform float neck;

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

  //uv.y += 0.1 * sin(uv.y * 22.0);

  vec3 col;

  if (uv.y < neck) {
    col = texture2D(texture, uv).rgb;
  } else {

    float y = uv.y - neck;
    uv.y = y * y  + neck;
    col = texture2D(texture, uv).rgb;
    //col = vec3(0.5,0.0,0.0);
  }

  gl_FragColor = vec4(col, 1.0);
  // gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
}
