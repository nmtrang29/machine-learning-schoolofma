import oscP5.*;
import netP5.*;
import processing.video.*;
Capture video;

OscP5 oscP5Receiver;
String receivedMessage=""; 

PShader fx;

float hole = 0;
float x, y, z = 0;


void setup() {
  size(640, 480, P2D);
  fx = loadShader("shader.glsl");
  shader(fx);
  
  oscP5Receiver = new OscP5(this, 8000);
  
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
  fx.set("hole", (float)hole);
  
  //println(receivedMessage);
}

void oscEvent(OscMessage message) {
  if (message.checkAddrPattern("/classification") == true) {
    hole = 0;
    
    for (int i = 0; i < message.arguments().length; i++) {
      receivedMessage = message.get(i).stringValue();
      
      if (receivedMessage.equals("tape")) {
        hole += -10;
      } else if (receivedMessage.equals("bigrock")) {
        hole += 20;
      } else if (receivedMessage.equals("smallrock")) {
        hole += 10;
      }     
    }
    
    // println(message.arguments().length);
    println(hole);
  }
}
