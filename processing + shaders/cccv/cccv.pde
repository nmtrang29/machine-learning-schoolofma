import oscP5.*;
import netP5.*;
import processing.video.*;
Capture video;

PShader fx;


void setup() {
  size(640, 480, P2D);
  fx = loadShader("shader.glsl");
  shader(fx);
  
  video = new Capture(this, 640, 480);
  video.start();
} 

void captureEvent(Capture video) {
  video.read();
}

void draw(){
  background(215, 10, 30);
  image(video, 0, 0);
    
  float i = map(mouseX, width/2, width, 0, 1.0);
  float j = map(mouseY, height/2, height, 0, 1.0);
  
  fx.set("time", millis()/1000.0);
  fx.set("mouseX", (float)i);
  fx.set("mouseY", (float)j);

}
