PrintWriter output;
int lightX;
int lightY;
BufferedReader input;
int punktzahl = 0;
int oHeight = 30;
int bgt = 12;
int highscore;
int gapSize = 100;
boolean stop = false;
OBSTACLE[] o = new OBSTACLE[3];
PLAYER p;
boolean pause = false;
int framerate = 60;
int Tsize = 1;
STAR[] stars = new STAR[300];
void setup() {
  p =new PLAYER();
  size(500, 800);
  frameRate(framerate);
  for (int i = 0; i< stars.length; i++) {
    stars [i] = new STAR();
  }
  if (!fileExists(sketchPath("highscore.dat"))) {
    byte[] b = {0};
    saveBytes("highscore.dat", b);
  } else {
    highscore = bytesToInt(loadBytes("highscore.dat"));
  }
  for (int i = 0; i < o.length; i++) {
    o[i] = new OBSTACLE(height + i*height/o.length);
  }
  lightX = width/2;
  lightY = 150;
}

void draw() {
  if (!p.alive)background(51);
  //hit
  if (!pause && p.alive) {
    background(51);
    if (bgt<=10) {
      fill(255, 0, 0, 100);
      rect(0, 0, width, height);
      bgt++;
    }
    for (STAR s : stars) {
      s.update();
    }
    noStroke();

    fill(255, 0, 100);
    p.update();
    for (OBSTACLE oi : o) {
      oi.update();
    }
    if (p.jump) p.paintJet();

    fill(0, 0, 255);
    textSize(50);
    text(p.jumps, width-150, 60);
    fill(255, 0, 0);
    text(p.leben, 10, 60);
    fill(0, 255, 0);
    Tsize = intLaenge(p.streak);
    text(p.points, width/2 -(intLaenge(p.points)*15), 60);
    text("highscore:" + highscore, width/2 -((9+intLaenge(highscore))*14.5), height-60);
    text("x"+p.streak, width - (30 +Tsize*30), height/2);
  }
  if (!p.alive) {
    p.update();
    if (p.jump) p.paintJet();

    if (p.points > highscore) { 
      highscore = p.points;
      saveBytes("highscore.dat", intToBytes(highscore));
    }

    fill(0, 255, 0);
    text(p.points, width/2 -(intLaenge(p.points)*15), 60);
    text("highscore:" + highscore, width/2 -((9+intLaenge(highscore))*14.5), height-60);
    text("x"+p.streak, width-(30 +Tsize*30), height/2);
    fill(255, 0, 0, 100);
    rect(0, 0, width, height);
    fill(255, 100, 0);
    textSize(100);
    text("DEAD!", width/2-175, height/2 -50);
    textSize(50);
    text(" press'r' to restart!", width/2-225, height/2 +50);
  }
  lightX =(int) p.pos.x;
  lightY = (int) p.pos.y;
}
void reset() {
  p.h = p.size;
  p.w = p.size;
  p.points = 0;
  p.streak = 1;
  for (int i = 0; i < o.length; i++) {
    o[i].v = 0;
    o[i].oReset(height + i*height/o.length);
  }
  p.pos.y = 100;
  p.leben = 1;
  p.jumps= 20;
  p.alive = true;
}

void keyPressed() {
  //pause
  if (key == 'p' && !pause) pause = true;
  else if (key == 'p' && pause) pause = false;
  //resetw
  if (key == 'r' && !p.alive) {
    reset();
  }
  // Jump
  if (key == '+') p.jumps++;
  if (key == 'w' && p.jumps > 0) {

    p.jump = true ;
    p.paintJet();
  } else
    //neuStart
    if (key == 'g' && !stop) {
      reset();
    }
  // links / rechts
  if ( key == 'a') {
    p.left = true;
  }
  if ( key == 'd') {
    p.right = true;
  }
}
void keyReleased() {
  if (key == 'w') {
    p.jump= false;
    p.a = 0.02 ;
    for (OBSTACLE oi : o) {
      oi.a = 0.1;
    }
  }
  if ( key == 'a') {
    p.left = false;
  }
  if ( key == 'd') {
    p.right = false;
  }
}

boolean fileExists(String path) {
  File file=new File(path);
  boolean exists = file.exists();
  if (exists) {
    return true;
  } else {
    return false;
  }
}
byte[] intToBytes(int x) {
  int bLength = floor(x/255);
  byte[] returnValue = new byte[bLength+1];
  for (int y = 0; y < bLength; y++) {
    returnValue[y] = byte(255);
  }
  returnValue[bLength] = byte(x%255);
  return returnValue;
}
int bytesToInt(byte[] b) {
  int returnValue = 0;
  for (byte by : b) {
    returnValue += int(by);
  }
  return returnValue;
}
int intLaenge(int x) {
  int returnValue = 1;
  while ((pow(10, returnValue))<=x) {
    returnValue++;
  }
  return returnValue;
}