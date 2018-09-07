//From Shadertoy: https://www.shadertoy.com/view/XdBSzW

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 mouse;

uniform float time;
uniform float mouseX;
uniform float mouseY;

uniform float hole;

varying vec4 vertTexCoord;

float rnd(vec2 s)
{
    return 1.-2.*fract(sin(s.x*253.13+s.y*341.41)*589.19);
}

void main() {
  vec2 ij = vertTexCoord.xy;


  vec2 p=ij;
      
      vec2 v=vec2(1E3);
      vec2 v2=vec2(1E4);
      vec2 center=vec2(.5,0.5);
      for(int c=0;c<hole;c++)
      {
          float angle=floor(rnd(vec2(float(c),387.44))*16.)*3.1415*.4-.5;
          float dist=pow(rnd(vec2(float(c),78.21)),2.)*.5;
          vec2 vc=vec2(center.x+cos(angle)*dist+rnd(vec2(float(c),349.3))*7E-3,
                       center.y+sin(angle)*dist+rnd(vec2(float(c),912.7))*7E-3);
          if(length(vc-p)<length(v-p))
          {
  	        v2=v;
  	        v=vc;
          }
          else if(length(vc-p)<length(v2-p))
          {
              v2=vc;
          }
      }
      
      float col=abs(length(dot(p-v,normalize(v-v2)))-length(dot(p-v2,normalize(v-v2))))+.002*length(p-center);
      col=7E-4/col;
      if(length(v-v2)<4E-3)col=0.;
      if(col<.3)col=0.;
      vec4 tex=texture2D(texture,ij+rnd(v)*.02);

      gl_FragColor=col*vec4(vec3(1.-tex.xyz),1.)+(1.-col)*tex;	
}