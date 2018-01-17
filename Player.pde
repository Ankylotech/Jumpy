public class PLAYER {
  PVector pos = new PVector();
  float fv = 0, a = 0.01;
  int max = 1;
  int v = 5;
  int size = 25;
  int w = 25, h = 25;
  float jumps = 100;
  int leben = 1;
  int streak = 1;
  boolean hit = false, alive = true;
  boolean right = false;
  boolean left  = false;
  boolean wait = false, jump = false;
  int points = 0;

  PLAYER() {

    pos.set(width/2 -25, 100);
  }
  void update() {
    bewegung();
    collision();
    setPoints();
    paintP();
    if (!jump && jumps <100) jumps += 0.02;
  }
  void bewegung() {
    if (pos.y <= 0) fv = 1;
    if (fv + a < max)fv += a;

    pos.add(0, fv);
    if (pos.y>= height/2)fv = -0.1;

    //rechts
    if (right) pos.add(v, 0);

    // links
    if (left) pos.add(-v, 0);
  }
  void paintJet() {
    if (jumps >= 0.2 ) {
      noStroke();
      fill(255, 155, 0);
      rect(pos.x, pos.y + h, w, h/2);
      rect(pos.x + w/4, pos.y+1.5* h - 1, w/2, h/2);
      rect(pos.x + 7*w/16, pos.y+2*h, w/8, h/2);


      if (alive)jumps -= 0.2;
      a = -0.1;
      o.a = - 0.05 + (o.v/10);
    } else {
      jump= false;
      a = 0.02;
      o.a = 0.05;
    }
  }
  void collision() {
    if (!hit) {
      if (pos.x < o.pos.x && pos.y > o.pos.y-h && pos.y < o.pos.y+50 ||pos.x + w > o.pos.x+100 && pos.y > o.pos.y-h && pos.y < o.pos.y+50  ) {
        if (leben > 0) leben--;
        if (leben <= 0) alive = false;
        hit = true;
        streak = 1;
        bgt = 0;
        w = size  + (size*streak /50);
        h =w;
      }
    }
  }
  void setPoints() {

    if (pos.y -100 > o.pos.y && !hit && !wait) {
      streak ++; 
      points += streak;
      w = size  + (size*streak /50);
      h =w;
      if (streak %5 == 0)leben++; 
      wait =true;
    }
  }
  void paintP() {

    if (pos.x> width)pos.set(1, pos.y);
    if (pos.x <= 0)pos.set(width, pos.y);
    if (pos.x + w <= width && pos.x>= 0) {
      rect(pos.x, pos.y, w, h);
    } else {
      if ((pos.x + w >= width)) {
        rect(pos.x, pos.y, w, h);
        rect(0, pos.y, w -(width-(pos.x)), h);
      } else if ( pos.x - w>= 0) {
        rect(pos.x, pos.y, w, h);
        rect(width-pos.x, pos.y, w, h);
      }
    }
  }
}