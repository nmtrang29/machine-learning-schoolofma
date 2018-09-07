import gab.opencv.*;
import processing.video.*;
import java.awt.*;
 
 
Capture video;
OpenCV opencv;

PShader fx;
 
void setup() {
 
  size(640, 480, P2D);
  fx = loadShader("slitscan.glsl");
  shader(fx);
  video = new Capture(this, 640, 480);
 
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
 
  video.start();
 
}
 
void draw() {
  opencv.loadImage(video);
 
  noFill();
  stroke(255, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  println(faces.length);
 
  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + ", FACE" + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
  
  if ( faces.length >0) {
  
  //PImage top = video.get(0, 0, width, faces[0].y + faces[0].height);
  
  
  float yPos = faces[0].y + faces[0].height*1.2;
  
  float i =  yPos/480;
  println(i);
  

  fx.set("neck", i);
  
    image(video, 0, 0);
  
  //PImage neck = video.get(0, yPos, width, 1 );
  
  //image(neck, 0, yPos, width, height- yPos);
  
  }
}
 
void captureEvent(Capture c) {
  c.read();
}
 
