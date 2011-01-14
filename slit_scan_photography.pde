import processing.video.*;
Capture cap;
int RESOLUTION, CHUNKSIZE, start, head, index;
PImage frames[];
void setup() {
  size(320, 240);
  cap = new Capture(this, width, height, 120);
  RESOLUTION = height;
  CHUNKSIZE = width * height / RESOLUTION;
  head = 0;
  frames = new PImage[RESOLUTION];
  for(int i = 0; i < RESOLUTION; i++) {
    frames[i] = createImage(width, height, RGB);
    frames[i].loadPixels();
  }
}
void draw() {
  background(0);
  if(cap.available()) {
    head = (head + 1) % RESOLUTION;
    cap.read();
    frames[head].copy(cap, 0, 0, width, height, 0, 0, width, height);
  }
  loadPixels();
  for(int i = 0; i < RESOLUTION; i++) {
    index = (head + i) % RESOLUTION;
    start = CHUNKSIZE * i;
    for(int j = start; j < start + CHUNKSIZE; j++) {
      pixels[j] = frames[index].pixels[j];
    }
  }
  updatePixels();
}
