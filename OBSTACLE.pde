public class OBSTACLE {

  PVector pos;
  float v = 0, a = 0.05;
  int max = 20;
  float rPosX, lowerPosY;

  OBSTACLE(int y) {
    pos  = new PVector(random(20, width-120), y);
    rPosX = pos.x+gapSize;
    lowerPosY = pos.y+oHeight;
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
    lowerPosY = pos.y+oHeight;
    rPosX = pos.x+gapSize;
  }
  void oReset(int y) {
    pos.set(random(50, width-150), y);
    rPosX = pos.x+gapSize;
    p.hit = false;
    p.wait = false;
  }
  void paint() {
    fill(255, 0, 100);
    rect(0, pos.y, pos.x, oHeight);
    rect(rPosX, pos.y, width-rPosX, oHeight);
    fill(0, 100, 255);
    rect(pos.x-20, pos.y, 20, oHeight);
    rect(rPosX, pos.y, 20, oHeight);

    //shadow
    fill(0, 80);
    float factor = 0.1;    
    int rShadowWidth =(int)(rPosX + (factor*(rPosX-lightX)));
    int lShadowWidth =(int)(pos.x - (factor*(lightX-pos.x)));
    if (lowerPosY>lightY) {
      float shadowHeight = ((lowerPosY - lightY)*factor);
      quad(rPosX, lowerPosY, width, lowerPosY, width, lowerPosY+shadowHeight, rShadowWidth, lowerPosY+shadowHeight);
      quad(0, lowerPosY, pos.x, lowerPosY, lShadowWidth, lowerPosY+shadowHeight, 0, lowerPosY+shadowHeight);
    }
    if (pos.y<lightY) {      
      float shadowHeight = ((pos.y - lightY)*factor);
      quad(rPosX, pos.y, width, pos.y, width, pos.y+shadowHeight, rShadowWidth, pos.y+shadowHeight);
      quad(0, pos.y, pos.x, pos.y, lShadowWidth, pos.y+shadowHeight, 0, pos.y+shadowHeight);
    }
  }
}