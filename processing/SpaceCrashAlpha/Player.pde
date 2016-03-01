abstract class Being extends DisplayableBase {
  float brightness = 128;
  float angle = -HALF_PI;
  PointMass physicsModel;
}

// Comment to get the PR started

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

    physicsModel.update();
 
    if (inputHandler.isPressed(Keys.FIRE)) {
      //Projectile p = new PlayerLaser(this, velocity.copy().normalize().mult(20));
      Projectile p = new PlayerLaser(this, PVector.fromAngle(angle).mult(20));
      projectiles.add(p);
    }
  }

  void display() {
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

    //if (showFlame) {
    //  v.mult(-1);
    //  ellipse(20, 0, 10, 10);
    //}
    popStyle();
    popMatrix();
  }
}