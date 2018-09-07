import oscP5.*;
import netP5.*;
import processing.video.*;
import controlP5.*;

ControlP5 cp5;
Capture video;

PShader fx;

float speed = 20.0;
float frequency = 50.0;
float strength = 0.02;

void setup() {
  size(640, 480, P2D);
  fx = loadShader("shader.glsl");
  
  
  video = new Capture(this, 640, 480);
  video.start();
  
  cp5 = new ControlP5(this);
  cp5.addSlider("Speed").setPosition(20,20).setSize(150,15).setRange(10.0, 50.0).setValue(20.0).setColorCaptionLabel(color(0));
  cp5.addSlider("Frequency").setPosition(20,40).setSize(150,15).setRange(20.0, 100.0).setValue(50.0).setColorCaptionLabel(color(0));
  cp5.addSlider("Strength").setPosition(20,60).setSize(150,15).setRange(0.01, 0.08).setValue(0.02).setColorCaptionLabel(color(0));
} 

void captureEvent(Capture video) {
  video.read();
}

void draw(){
  
  shader(fx);
    
  float i = map(mouseX, 0, width, 1.0, 0.0);
  float j = map(mouseY, 0, height, 0.0, 1.0);
  float waveStrength = strength;
  float waveFrequency = frequency;
  float waveSpeed = speed;
  
  fx.set("time", millis()/1000.0);
  fx.set("waveStrength", (float)waveStrength);
  fx.set("frequency", (float)waveFrequency);
  fx.set("waveSpeed", (float)waveSpeed);
  fx.set("mouseX", (float)i);
  fx.set("mouseY", (float)j);
  
  image(video,0,0);
  
  pushMatrix();
  translate(video.width,0);
  scale(-1,1); // You had it right!
  image(video,0,0);
  popMatrix();
  
  resetShader();
  
  Controller c = cp5.getController("Speed");
  println(c.getValue());

  Slider sliderc = cp5.get(Slider.class, "Speed");
  println(sliderc.getMin(), sliderc.getMax());
  
  Controller b = cp5.getController("Frequency");
  println(b.getValue());

  Slider sliderb = cp5.get(Slider.class, "Frequency");
  println(sliderb.getMin(), sliderb.getMax());
  
  Controller a = cp5.getController("Strength");
  println(a.getValue());

  Slider slidera = cp5.get(Slider.class, "Strength");
  println(slidera.getMin(), slidera.getMax());
  
  speed = c.getValue();
  frequency = b.getValue();
  strength = a.getValue();
}
