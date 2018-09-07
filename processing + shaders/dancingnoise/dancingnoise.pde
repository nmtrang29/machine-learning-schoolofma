import oscP5.*;
import netP5.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.video.*;
Capture video;

PShader fx;

Minim minim;
AudioInput in;
FFT fft;

float lerpFactor = 0.05; //Set between 0.0 (full smoothing) and 0.99 (no smoothing)
float getAmpR, rawgetAmpR = 0;
float getAmpG, rawgetAmpG = 0;
float getAmpB, rawgetAmpB = 0;

void setup() {
  size(640, 480, P2D);
  fx = loadShader("shader.glsl");
  shader(fx);
  background(0);
  video = new Capture(this, 640, 480);
  video.start();
  
  minim = new Minim(this);
  in = minim.getLineIn();
  fft = new FFT(in.bufferSize(), in.sampleRate());
} 

void captureEvent(Capture video) {
  video.read();
}

void draw(){
  image(video, 0, 0);
  
  fft.forward(in.mix);
  
  float rawgetAmpR = fft.getBand(4);
  getAmpR = lerp(getAmpR, rawgetAmpR, lerpFactor);
  fx.set("getAmpR", (float)getAmpR);
  
  float rawgetAmpG = fft.getBand(8);
  getAmpG = lerp(getAmpG, rawgetAmpG, lerpFactor);
  fx.set("getAmpG", (float)getAmpG);
  
  float rawgetAmpB = fft.getBand(12);
  getAmpB = lerp(getAmpB, rawgetAmpB, lerpFactor);
  fx.set("getAmpB", (float)getAmpB);
    
  float i = map(mouseX, width/2, width, 0, 1.0);
  float j = map(mouseY, height/2, height, 0, 1.0);
  
  fx.set("time", millis()/1000.0);
  fx.set("mouseX", (float)i);
  fx.set("mouseY", (float)j);

}
