public class PLAYER {
  PVector pos = new PVector();
  float fv = 0, a = 0.01;
  int max = 1;
  int hMax = 5;
  float v = 0;
  int size = 25;
  int w = 25, h = 25;
  float jumps = 20;
  int leben = 1;
  int streak = 1;
  float ha = 0.3;
  boolean hit = false, alive = true;
  boolean right = false;
  boolean left  = false;
  boolean wait = false, jump = false;
  int points = 0;
  PImage flame;

  PLAYER() {
    flame = loadImage("Flame.png");

    pos.set(width/2 -25, 100);
  }
  void update() {
    bewegung();
    collision();
    setPoints();
    paintS();
    paintP();
    if (!jump && jumps <100) jumps += 0.02;
  }
  void bewegung() {
    if (pos.y <= 0) fv = 1;
    if (fv + a < max)fv += a;

    pos.add(0, fv);

    if (pos.y>= height/2)fv = -0.1;

    if (v + ha < hMax && (right||left))v += ha;
    if (!(right||left)) {
      v = 0;
    }
    //rechts
    if (right) pos.add(v, 0);

    // links
    if (left) pos.add(-v, 0);
  }
  void paintJet() {
    if (jumps >= 0.2 ) {
      noStroke();
      fill(255, 155, 0);
      image(flame, pos.x, pos.y + h, w, h*3/2);



      if (alive)jumps -= 0.2;
      a = -0.1;
      for (OBSTACLE oi : o) {
        oi.a = - 0.05 + (oi.v/10);
      }
    } else {
      jump= false;
      a = 0.02;
      for (OBSTACLE oi : o) {
        oi.a = 0.05;
      }
    }
  }
  void collision() {
    if (!hit) {
      for (OBSTACLE oi : o) {
        if ((pos.x < oi.pos.x && pos.y > oi.pos.y-h && pos.y < oi.pos.y+oHeight) ||(pos.x + w > oi.pos.x+100 && pos.y > oi.pos.y-h && pos.y < oi.pos.y+oHeight)  ) {
          if (leben > 0) leben--;
          if (leben <= 0) alive = false;
          hit = true;
          bgt = 0;
          w = size  + (size*streak /50);
          h =w;
        }
      }
    }
  }
  void setPoints() {
    for (OBSTACLE oi : o) {
      if (pos.y -oHeight+h > oi.pos.y && !hit && !wait) {
        streak ++; 
        points += streak-1;
        w = size  + (size*streak /50);
        h =w;
        if (streak %5 == 0) {
          jumps+=(streak/5);
        }
        wait =true;
      }
    }
  }
  void paintP() {
    fill(255, 0, 100);
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
  void paintS() {
    float shadowLength = 0.00035;
    float TRD = sqrt(sq(pos.x+w-lightX)+sq(pos.y-lightY));
    float factor = (TRD*shadowLength);
    float sTRX = (pos.x+w+factor*(pos.x+w-lightX));
    float sTRY = (pos.y+factor*(pos.y-lightY));
    TRD = sqrt(sq(pos.x+w-lightX)+sq(pos.y+h-lightY));
    factor = (TRD*shadowLength);
    float sBRX = (pos.x+w+factor*(pos.x+w-lightX));
    float sBRY = (pos.y+h+factor*(pos.y+h-lightY));
    TRD = sqrt((pos.x-lightX)*(pos.x-lightX)+(pos.y-lightY)*(pos.y-lightY));
    factor = (TRD*shadowLength);
    float sTLX = (pos.x+factor*(pos.x-lightX));
    float sTLY = (pos.y+factor*(pos.y-lightY));
    TRD = sqrt(sq(pos.x-lightX)+sq(pos.y+h-lightY));
    factor = (TRD*shadowLength);
    float sBLX = (pos.x+factor*(pos.x-lightX));
    float sBLY = (pos.y+h+factor*(pos.y+h-lightY));

    fill(0, 60);
    quad(pos.x+w, pos.y, pos.x+w, pos.y+h, sBRX, sBRY, sTRX, sTRY);
    quad(pos.x, pos.y+h, pos.x+w, pos.y+h, sBRX, sBRY, sBLX, sBLY);
    quad(pos.x, pos.y, pos.x, pos.y+h, sBLX, sBLY, sTLX, sTLY);
    quad(pos.x, pos.y, pos.x+w, pos.y, sTRX, sTRY, sTLX, sTLY);
    quad(sBRX, sBRY, sTRX, sTRY, sTLX, sTLY, sBLX, sBLY);
  }
}