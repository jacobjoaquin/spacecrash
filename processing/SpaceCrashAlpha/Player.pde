// Base class for all beings in game. This includes player and enemies.
abstract class Being extends DisplayableBase {
  float brightness = 128;
  float angle = -HALF_PI;
  PointMass physicsModel;
}

// The player
class Player extends Being {
  boolean showFlame = true;
  private float rotateAmount = 0.1;

  Player() {
    super();
    physicsModel = new PointMass(false);
    physicsModel.setDrag(0.05);
  }

  void update() {
    if (inputHandler.isPressed(Keys.ROTATE_LEFT)) {
      angle -= rotateAmount;
    }    
    if (inputHandler.isPressed(Keys.ROTATE_RIGHT)) {
      angle += rotateAmount;
    }
    if (inputHandler.isPressed(Keys.FORWARD)) {
      PVector a = PVector.fromAngle(angle);
      physicsModel.applyForce(a);
    }
    if (inputHandler.isPressed(Keys.BACKWARD)) {
      PVector a = PVector.fromAngle(angle - PI);
      physicsModel.applyForce(a);
    }
 
    if (inputHandler.isPressed(Keys.FIRE)) {
      fire();
    }
  }
  
  void fire() {
    Projectile p = new PlayerLaser(this, PVector.fromAngle(angle).mult(20));
    projectiles.add(p);
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
    line(0, 0, v.x, v.y);
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