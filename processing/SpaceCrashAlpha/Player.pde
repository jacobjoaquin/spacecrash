// Base class for all beings in game. This includes player and enemies.
abstract class Being extends DisplayableBase {
  float brightness = 128;
  float angle = -HALF_PI;
  PhysicsObject physicsModel;
}

// The player
class Player extends Being {
  boolean showFlame = true;
  private float rotateAmount = 0.1;
  GLines shipShape = new GLines();
  GLines shipShapeScreen = new GLines();

  Player() {
    physicsModel = new PointMass(false);
    physicsModel.setDrag(0.1);
    physicsModel.mass = 1.5;
    init();
  }

  void init() {
    ArrayList<PVector> points = new ArrayList<PVector>();
    PVector v = PVector.fromAngle(0);
    v.mult(20);
    line(0, 0, v.x, v.y);
    for (int i = 0; i < 3; i++) {
      points.add(v.copy());
      v.rotate(TAU / 3);
    }

    for (int i = 0; i < 3; i++) {
      GLine gl = gline(points.get(i), points.get((i + 1) % 3));
      shipShape.add(gl);
      shipShapeScreen.add(gline(0, 0, 0, 0));
    }
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

    updateShipShapeScreen();
  }

  void updateShipShapeScreen() {
    pushMatrix();
    rotate(angle);
    for (int i = 0; i < shipShape.size(); i++) {
      GLine source = shipShape.get(i);
      GLine dest = shipShapeScreen.get(i);
      dest.p0 = PVectorToScreen(source.p0);
      dest.p1 = PVectorToScreen(source.p1);
    }
    popMatrix();
  }


  // TODO: Add this to util.pde
  PVector PVectorToScreen(PVector p) {
    PVector pOut = new PVector();
    pOut.x = screenX(p.x, p.y);
    pOut.y = screenY(p.x, p.y);
    return pOut;
  }

  void fire() {
    // TODO: mult(20) is midpoint to tip of player.
    Projectile p = new PlayerLaser(this, PVector.fromAngle(angle).mult(20).add(physicsModel.position));
    projectiles.add(p);
  }

  void display() {
    // TODO: Design a better looking ship
    // pushMatrix();
    // pushStyle();
    // noFill();
    // stroke(brightness);
    // float a = angle;
    // beginShape();
    // PVector v = PVector.fromAngle(a);
    // v.mult(20);
    // line(0, 0, v.x, v.y);
    // for (int i = 0; i < 3; i++) {
    //   vertex(v.x, v.y);
    //   v.rotate(TAU / 3);
    // }
    // endShape(CLOSE);
    // TODO: Show show thrusters
    // popStyle();
    // popMatrix();


    pushStyle();
    noFill();
    stroke(brightness);
    for (GLine gl : shipShapeScreen) {
      line(gl.p0, gl.p1);
    }
    popStyle();

    
  }
}