// Base class for all beings in game. This includes player and enemies.
abstract class Being extends DisplayableBase {
  float brightness = 128;
  float angle = -HALF_PI;
  float friction = 0.95;
  PVector acceleration;
  PVector velocity;
  PVector position;
}

// The player
class Player extends Being {
  boolean showFlame = true;
  private float rotateAmount = 0.1;

  Player() {
    super();
    position = new PVector(0, 0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void update() {
    acceleration.set(0, 0);

    if (inputHandler.isPressed(Keys.ROTATE_LEFT)) {
      angle -= rotateAmount;
    }    
    if (inputHandler.isPressed(Keys.ROTATE_RIGHT)) {
      angle += rotateAmount;
    }
    if (inputHandler.isPressed(Keys.FORWARD)) {
      PVector a = PVector.fromAngle(angle);
      acceleration.add(a);
    }
    if (inputHandler.isPressed(Keys.BACKWARD)) {
      PVector a = PVector.fromAngle(angle - PI);
      acceleration.add(a);
    }

    velocity.add(acceleration);
    position.add(velocity);
    velocity.mult(friction);
 
    if (inputHandler.isPressed(Keys.FIRE)) {
      Projectile p = new PlayerLaser(this, PVector.fromAngle(angle).mult(20));
      projectiles.add(p);
    }
  }

  void display() {
    // TODO: Design a better looking ship
    pushMatrix();
    pushStyle();
    noFill();
    stroke(brightness);
    float a = angle;
    beginShape();
    PVector v = PVector.fromAngle(a);
    v.mult(20);
    rectMode(CENTER);
    rect(v.x, v.y, 8, 8);
    for (int i = 0; i < 3; i++) {
      vertex(v.x, v.y);
      v.rotate(TAU / 3);
    }
    endShape(CLOSE);

    // TODO: Show show thrusters
    
    popStyle();
    popMatrix();
  }
}