public class PLAYER {
  PVector pos = new PVector();
  float fv = 0, a = 0.01;
  int max = 1;
  int v = 5;
  int w = 25, h = 25;
  int jumps = 3;
  int leben = 3;
  int streak = 0;
  boolean hit = false, alive = true;
  boolean right = false;
  boolean left  = false;
  boolean wait = false;
  int points = 0;

  PLAYER() {

    pos.set(width/2 -25, 100);
  }
  void update() {
    bewegung();
    collision();
    setPoints();
    rect(pos.x, pos.y, w, h);
  }
  void bewegung() {
    if(pos.y <= 0) fv = 1;
    if(fv < max)fv += a;
   
    pos.y += fv;
    if(pos.y>= height/2)fv = -0.1;
    
    //rechts
    if (pos.x < width-w && right) pos.x += v;

    // links
    if (pos.x > 0 && left) pos.x -= v;
  }
  void collision() {
    if (!hit) {
      if (pos.x < o.pos.x && pos.y > o.pos.y-h && pos.y < o.pos.y+50 ||pos.x + w > o.pos.x+100 && pos.y > o.pos.y-h && pos.y < o.pos.y+50  ) {
        if (leben > 0) leben--;
        if (leben <= 0) alive = false;
        hit = true;
        streak = 0;
        bgt = 0;
      }
    }
  }
  void setPoints() {
    
    if (pos.y -100 > o.pos.y && !hit && !wait) {
      streak ++; 
      points += streak;
      if(streak >= 5)jumps++; 
      wait =true;
      if(streak >= 7)leben++; 
      wait =true;
    }
  }
}