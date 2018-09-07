import gab.opencv.*;
import processing.video.*;
import java.awt.*;
 
 
Capture video;
OpenCV opencv;
 
void setup() {
 
  size(640, 480);
  video = new Capture(this, 640, 480);
 
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
 
  video.start();
 
}
 
void draw() {
  opencv.loadImage(video);
  //image(video, 0, 0 );
 
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
  
  PImage top = video.get(0, 0, width, faces[0].y + faces[0].height);
  image(top, 0, 0);
  
  int yPos = faces[0].y + faces[0].height;
  
  PImage neck = video.get(0, yPos, width, 1 );
  
  image(neck, 0, yPos, width, height- yPos);
  
  }
}
 
void captureEvent(Capture c) {
  c.read();
}
 
