import java.io.File;
import gab.opencv.*;
import java.awt.*;
OpenCV opencv;

PImage[] imgs;
PGraphics pg;
PImage faceToSave;

float minFaceW = 45; 
float maxFaceW = 850; 

int outputW = 512;
int outputH = 512;

Rectangle[] faces;

void setup()
{
  size(1080, 720);
  pg = createGraphics(outputW, outputH);

  // we'll have a look in the data folder
  java.io.File folder = new java.io.File(dataPath(""));

  // list the files in the data folder
  String[] filenames = folder.list();

  // get and display the number of jpg files
  println(filenames.length + " jpg files in specified directory");

  imgs = new PImage[filenames.length];

  // display the filenames
  for (int i = 0; i < filenames.length; i++) {
    opencv = new OpenCV(this, filenames[i]);
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);


    //println(filenames[i]);
    imgs[i] = loadImage(filenames[i]);
    faces = opencv.detect();
    println(faces.length);

    for (int j = 0; j<faces.length; j++) {
      if (faces[j].width >= minFaceW && faces[j].width <= maxFaceW) { //Filter: Faces need to have a width between minFaceW & maxFaceW
        faceToSave = imgs[i].get(faces[j].x, faces[j].y, faces[j].width, faces[j].height);

        pg.beginDraw();
        pg.image(faceToSave, 0, 0, pg.width, pg.height);
        pg.endDraw();
        pg.save("exports/face" + i + "_" + j + ".jpg");
      }
    }
  }
}
