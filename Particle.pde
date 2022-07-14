class Particle {

  PVector position;
  float speed = 1.2;
  PVector velocity = new PVector( random(-speed, speed), random(-speed, speed));
  PVector acceleration = new PVector(0.0, 0.0);
  float diameter;
  float mass;
  float c = 128;
  ;

  Particle (PVector _position, float _mass, float _diameter) {
    position = _position;
    mass = _mass;
    diameter = _diameter;
  }

  void Update() {
    velocity.add(acceleration);
    position.add(velocity); 
    acceleration.mult(0);
  }


  void applyForce(PVector _force) {
    PVector f = PVector.div(_force, mass); 
    acceleration.add(f);
  }

  void Display() {
    if (!gameover) {
      if (c>1) {
        c = lerp(c, 0, 0.07);
        noStroke();
        fill(255, 0, 0, c);
        ellipse( position.x, position.y, diameter, diameter);
      }
    }
  }
}


class Asteroid extends Particle {

  Asteroid(PVector _position, float _mass, float _diameter) {
    super(_position, _mass, _diameter);
  }

  void CheckBorders() {
    if (position.x < 0 ) {
      position.x = width;
    } else if ( position.x > width ) {
      position.x = 0;
    }
    if (position.y < 0 ) {
      position.y = height;
    } else if ( position.y > height ) {
      position.y = 0;
    }
  }

  boolean CheckCollision(Ship p) {
    if (dist(position.x, position.y, p.position.x, p.position.y)<=((diameter + p.diameter)/2.0)) {
      return true;
    }
    return false;
  }

  void Display() {
    if (!gameover) {
      stroke(0);
    } else {
      stroke(211, 211, 211);
    }
    strokeWeight(3);
    fill(255);
    ellipse( position.x, position.y, diameter, diameter);
  }
}
