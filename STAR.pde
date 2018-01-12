public class STAR {
  PVector pos = new PVector(random(0, width), random(0, height));
  float r = random(2, 5);
  float v = r/10;
  color c = color(random(155, 255), random(155, 255), random(155, 255));
  void update() {
    pos.y -= v;
    fill(c);
    ellipse(pos.x, pos.y, r, r);
    reset();
  }
  void reset() {
    if (pos.y < 0) { 
      pos.set(random(0, width), height+10);
      c = color(random(100, 255), random(100, 255), random(100, 255));
      r = random(1, 4);
      v = r/10;
    }
  }
}