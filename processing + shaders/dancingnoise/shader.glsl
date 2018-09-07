// https://www.shadertoy.com/view/XtcSRs

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif


uniform sampler2D texture;
uniform vec2 mouse;

uniform float time;
uniform float mouseX;
uniform float mouseY;
uniform float getAmpR;
uniform float getAmpG;
uniform float getAmpB;

varying vec4 vertTexCoord;

void main() {
  vec2 uv = vertTexCoord.xy;

  const float max_value = 270.0;
  const float buckets = 512.0;
  float bucket_min = log( max_value * floor(uv.y * buckets) / buckets );
  float bucket_max = log( max_value * floor((uv.y * buckets) + 1.0) / buckets );

  vec4 count = vec4(0.0, 0.0, 0.0, 0.0);
    for( int i=0; i < 512; ++i ) {
        float j = float(i) / buckets;
        vec4 pixel = texture2D(texture, vec2(uv.x, j )) * 512.0 - getAmpR * 2.0;
        
        pixel.a = pixel.r * 0.2126 + pixel.g * 0.7152 + pixel.b * 0.0722;

        vec4 logpixel = log(pixel);
        if( logpixel.r >= bucket_min && logpixel.r < bucket_max) count.r += getAmpR * 0.5;
        if( logpixel.g >= bucket_min && logpixel.g < bucket_max) count.g += 1.0;
        if( logpixel.b >= bucket_min && logpixel.b < bucket_max) count.b += getAmpB * 0.35;
        if( logpixel.a >= bucket_min && logpixel.a < bucket_max) count.a += 1.0;
    }

    const float gain = 0.2;
    const float blend = 0.6;
    count.rgb = log( mix(count.rgb, count.aaa, blend) ) * gain;

  gl_FragColor = count;
}
