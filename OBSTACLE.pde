public class OBSTACLE {

  PVector pos = new PVector(random(20, width-120), 1000);
  float v = 0, a = 0.05;
  int max = 20;



  void update() {

    bewegung();
    paint();
  }
  void bewegung() {
    //reset
    if (pos.y <= -50) {
      oReset();
    } 

    //fall
    if (v - a >= -max) v -= a;
    pos.add(0, v);
  }
  void oReset() {
    pos.set(random(50, width-150), height +100);
    p.hit = false;
    p.wait = false;
  }
  void paint() {

    rect(0, pos.y, pos.x, 30);
    rect(pos.x +100, pos.y, width-pos.x-100, 30);
    fill(0, 100, 255);
    rect(pos.x-20, pos.y, 20, 30);
    rect(pos.x +100, pos.y, 20, 30);
  }
}