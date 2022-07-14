class Ship {
  // posizione del centro della navicella
  PVector position;
  // heading è la direzione in gradi nella navicella, inizialmente a zero (verso l'alto)
  float heading;
  PVector velocity = new PVector(0.0, 0.0);
  PVector acceleration = new PVector(0.0, 0.0);
  float mass = 1.0;
  float diameter = 15;

  // per il fumo di scarico uso le particles 
  Particle[] exhaust = new Particle[1];

  Ship(PVector pos, float h) {
    position = pos.copy(); //copia i pixels
    heading = h;
    exhaust[0] = new Particle(new PVector(width*2, height*2), 1, 10);
  }

  void Turn(float angle) {
    heading += angle;
  }

  void FireEngines() {
    // FACCIAMO MUOVERE LA NAVICELLA
    // creiamo un vettore nella direzione della navicella. Va sottratto PI/2 (90 gradi) perche' 
    // l'angolo 0 corrisponde in realta' a 90 gradi
    PVector force = PVector.fromAngle(heading - PI/2);
    force.mult(0.15);
    applyForce(force);

    // creiamo un vettore forza per i "fumi di scarico" (una particella) con una direzione intorno
    // all'opposto della forza impressa dal motore
    Particle fire = new Particle( new PVector(position.x, position.y), 1, 5);
    // le particelle si dirigono in un angolo compreso tra -PI/8 e PI/8
    float randomAngle = random(-PI/8, PI/8);
    // la forza con cui le particelle vengono sparate
    PVector fireForce = PVector.fromAngle(heading-PI/2+randomAngle);
    // con un velocità moltiplicata per un valore tra -2 e -1
    fireForce.mult(random(-2, -1));
    fire.applyForce(fireForce);
    exhaust = (Particle[]) append(exhaust, fire);
  }


  void applyForce(PVector _force) {
    PVector f = PVector.div(_force, mass); 
    acceleration.add(f);
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

  void Update() {
    velocity.add(acceleration);
    velocity.limit(50.0);
    velocity.mult(0.99);
    position.add(velocity); 
    acceleration.mult(0);
    for (int i=0; i<exhaust.length; i++) {
      exhaust[i].Update();
    }
  }

  void Display() {
    stroke(0);
    for (int i=0; i<exhaust.length; i++) {
      exhaust[i].Display();
    }
    strokeWeight(2);
    pushMatrix();
    translate(position.x, position.y);
    rotate(heading);
    fill(250, 255);
    if (!gameover) {
      stroke(0);
    } else {
      stroke(211, 211, 211);
    }
    triangle(0, -20, -10, 20, 10, 20);
    popMatrix();
  }
} 
