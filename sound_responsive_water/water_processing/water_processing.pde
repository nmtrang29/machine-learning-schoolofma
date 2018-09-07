import oscP5.*;
OscP5 oscP5;
float regressionValue;
float lerpedValue1 = 0.5;
float lerpFactor1 = 0.008;

float lerpedValue2 = 0.5;
float lerpFactor2 = 0.02;

float sz, sw, theta;
int slow = 120;
float factor = 1;
float delta = 1;

int repetitions = 1000;
int currentRepetition = 0;
float currentColor;

void setup() {
  size(660, 660);
  smooth(8);
  strokeWeight(2);
  oscP5 = new OscP5(this, 12000);
  currentColor = 255;
}

void draw() {

  lerpedValue1 = lerp(lerpedValue1, regressionValue, lerpFactor1);
  lerpedValue2 = lerp(lerpedValue2, regressionValue, lerpFactor2);

  drawTheThing();
  currentRepetition++;
  currentColor = lerpedValue2 * 100;

  if (currentRepetition > repetitions) {
    //update the value you wants
    slow *= 0.999;
    currentRepetition = 0;
    currentColor = 255;
  }

  //update the slow value

  //slow = int(240 * lerpedValue);
}


void drawTheThing() {
  background(0);
  sz = 10;
  sw = 1;
  //float scal = map(pow(sin(theta), 2), 0, 1, 2, 1);
  float scal = 2;
  float w = width*.4*scal;
  while (sz<w) {
    float offSet = map(sz, 0, w, 0, TWO_PI);
    noFill();
    strokeWeight(2);
    stroke(currentColor);
    float dx = map(pow(sin(theta+offSet*scal), 2), 0, 1, -10*scal/2, 10*scal/2);
    //float dx = 0;
    ellipse(width/2+dx, height/2, sz*factor, sz*factor);
    factor = factor * delta;
    sz += 12;
    sw += 0.04;
  }
  theta += PI/slow*lerpedValue1*4;
}
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
    regressionValue = theOscMessage.get(0).floatValue();
  }
}
