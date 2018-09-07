
https://www.shadertoy.com/view/4djGzz

#define taps 8.0

#define tau 6.28

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

vec2 params = vec2(2.5, 10.0);

float wave(vec2 pos, float t, float freq, float numWaves, vec2 center) {
    float d = length(pos - center);
    d = log(1.0 + exp(d));
    return 1.0/(1.0+20.0*d*d) *
           sin(2.0*3.1415*(-numWaves*d + t*freq));
}

float height(vec2 pos, float t) {
    float w;
    w =  wave(pos, t, params.x, params.y, vec2(0.5, -0.5));
    w += wave(pos, t, params.x, params.y, -vec2(0.5, -0.5));
    return w;
}

vec2 normal(vec2 pos, float t) {
    return  vec2(height(pos - vec2(0.01, 0), t) - height(pos, t), 
                 height(pos - vec2(0, 0.01), t) - height(pos, t));
}

void main() {
    vec2 uv = vertTexCoord.xy;
    
    if (mouseX > 0.0) params =2.0*params*mouseX;
    else params = vec2(2.5, 10.0);
    
    vec2 uvn = 2.0*uv - vec2(1.0);  
    uv += normal(uvn, time);


    gl_FragColor = texture2D(texture, vec2(1.0-uv.x, uv.y));
}
