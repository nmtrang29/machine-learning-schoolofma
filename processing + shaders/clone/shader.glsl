
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


void main() {
    vec2 uv = vertTexCoord.xy;
    vec4 c  = texture2D(texture,uv);
    float t = time;

    float d = .01+sin(t)*.01+1+mouseX/2 ;
    for(float i = 0.; i<tau;i+=tau/taps){
        float a = i+t*.5;
        vec4 c2 = texture2D(texture,vec2(uv.x+cos(a)*d,uv.y+sin(a)*d));
        #ifdef light
            c = max(c,c2);
        #else
            c = min(c,c2);
        #endif
    }


    gl_FragColor = c;
}
