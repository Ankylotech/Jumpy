public class OBSTACLE {

  PVector pos;
  float v = 0, a = 0.05;
  int max = 20;

  OBSTACLE(int y) {
    pos  = new PVector(random(20, width-120), y);
  }

  void update() {

    bewegung();
    paint();
  }
  void bewegung() {
    //reset
    if (pos.y <= -50) {
      oReset(height);
    } 

    //fall
    if (v - a >= -max) v -= a;
    pos.add(0, v);
  }
  void oReset(int y) {
    pos.set(random(50, width-150), y);
    p.hit = false;
    p.wait = false;
  }
  void paint() {

    rect(0, pos.y, pos.x, oHeight);
    rect(pos.x +100, pos.y, width-pos.x-100, oHeight);
    fill(0, 100, 255);
    rect(pos.x-20, pos.y, 20, oHeight);
    rect(pos.x +100, pos.y, 20, oHeight);
  }
}