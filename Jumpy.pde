int punktzahl = 0;
int bgt = 12;
boolean stop = false;
OBSTACLE o = new OBSTACLE();
PLAYER p = new PLAYER();
boolean pause = false;
int framerate = 60;
String multiplier;
STAR[] stars = new STAR[300];
void setup() {
  size(500, 800);
  frameRate(framerate);
  for (int i = 0; i< stars.length; i++) {
    stars [i] = new STAR();
  }
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
    o.update();
  if(p.jump) p.paintJet();
    
    fill(0, 0, 255);
    textSize(50);
    text(p.jumps, width-150, 60);
    fill(255, 0, 0);
    text(p.leben, 10, 60);
    fill(0, 255, 0);
    text(p.points, width/2 -25, 60);
    
    multiplier = "x"+p.streak;
    text(multiplier, width - (textWidth(multiplier)), height/2);
  }
  if (!p.alive) {
    p.update();
  if(p.jump) p.paintJet();
    fill(0, 255, 0);
    text(p.points, width/2 -25, 60);
    text("x"+p.streak, width-60, height/2);
    fill(255, 0, 0, 100);
    rect(0, 0, width, height);
    fill(255, 100, 0);
    textSize(100);
    text("DEAD!", width/2-175, height/2 -50);
    textSize(50);
    text(" press'r' to restart!", width/2-225, height/2 +50);
  }
  
}
void reset() {
  p.points = 0;
  p.streak = 1;
  o.v = 0;
  o.oReset();
  p.pos.y = 100;
  p.leben = 10;
  p.jumps= 100;
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
    o.a = 0.1 ;
  }
  if ( key == 'a') {
    p.left = false;
  }
  if ( key == 'd') {
    p.right = false;
  }
}