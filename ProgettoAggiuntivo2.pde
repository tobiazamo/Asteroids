Ship s;
Asteroid[] asteroids = new Asteroid[10];
PFont uncle;
boolean gameover = false;
int points = 0;

void setup() {
  size(600, 400, P2D);
  reset();
}


void draw() {
  if (!gameover) {
    background(255);
    if (keyPressed) {
      if (key == CODED && keyCode == LEFT) {
        s.Turn(-0.05);
      } else if (key == CODED && keyCode == RIGHT) {
        s.Turn(0.05);
      }
      if (key == CODED && keyCode == SHIFT) {
        s.FireEngines();
      }
    }
    s.Update();
    s.CheckBorders();
    s.Display();
    points++;

    for (int i=0; i<asteroids.length; i++) {
      asteroids[i].CheckBorders();
      if (asteroids[i].CheckCollision(s)) {
        gameover = true;
      }
      asteroids[i].Update();
      asteroids[i].Display();
    }
    uncle = createFont("unclbm.ttf", 12);
    textFont(uncle);
    textAlign(CENTER);
    fill(0);
    text("Score: "+points, width/8, height/8);
    
  } else if (gameover) {
    gameOverScreen();
    if ( key == 'r' || key == 'R') {
      reset();
    }
  }
}

void gameOverScreen() {
  s.Display();
  for (int i=0; i<asteroids.length; i++) {
    asteroids[i].Display();
  }
  fill(0);
  uncle = createFont("unclbm.ttf", 86);
  textFont(uncle);
  textAlign(CENTER, BOTTOM);
  text("Game Over", width/2, height/2);
  uncle = createFont("unclbm.ttf", 23);
  textFont(uncle);
  textAlign(CENTER, CENTER);
  text("Score: " + points, width/2, height/2);
  textAlign(CENTER, TOP);
  text("Press R to restart", width/2, height/1.5);
}

void reset() {
  gameover = false;
  s = new Ship(new PVector(width/2, height/2), 0);
  for (int i=0; i<asteroids.length; i++) {
    asteroids[i] = new Asteroid(new PVector( width, random(height)), 4, random(24, 128));
  }
  points = 0;
}

void keyPressed() {
}
