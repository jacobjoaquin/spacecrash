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
  GLines shipBoundary = new GLines();
  GLines shipBoundaryScreen = new GLines();
  int disableThrustersFrames = 0;
  int fireRate = 8;
  int nextFireFrames = 0;

  Player() {
    physicsModel = new PointMass(false);
    physicsModel.setDrag(0.05);
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
      shipBoundary.add(gl);
      shipBoundaryScreen.add(gline(0, 0, 0, 0));
    }
  }

  void update() {
    if (inputHandler.isPressed(Keys.ROTATE_LEFT)) {
      angle -= rotateAmount;
    }    
    if (inputHandler.isPressed(Keys.ROTATE_RIGHT)) {
      angle += rotateAmount;
    }
    if (--disableThrustersFrames <= 0) {
      if (inputHandler.isPressed(Keys.FORWARD)) {
        PVector a = PVector.fromAngle(angle);
        physicsModel.applyForce(a);
      }
      if (inputHandler.isPressed(Keys.BACKWARD)) {
        PVector a = PVector.fromAngle(angle - PI);
        physicsModel.applyForce(a);
      }
    }
    if (nextFireFrames-- <= 0) {
      if (inputHandler.isPressed(Keys.FIRE)) {
        fire();
        nextFireFrames = fireRate;
      }
    }

    updateshipBoundaryScreen();
  }

  void updateshipBoundaryScreen() {
    pushMatrix();
    rotate(angle);
    for (int i = 0; i < shipBoundary.size(); i++) {
      GLine source = shipBoundary.get(i);
      GLine dest = shipBoundaryScreen.get(i);
      dest.p0 = PVectorToScreen(source.p0);
      dest.p1 = PVectorToScreen(source.p1);
    }
    popMatrix();
  }

  void fire() {
    // TODO: mult(20) is midpoint to tip of player.
    Projectile p = new PlayerLaser(this, PVector.fromAngle(angle).mult(20).add(physicsModel.position));
    projectiles.add(p);
    soundFire.play();

  }

  void display() {
    // TODO: shipBoundaryScreen is currently the drawn ship, though we
    // can also implement shipCostumeScreen for a more detailed figure
    pushStyle();
    noFill();
    stroke(brightness);
    for (GLine gl : shipBoundaryScreen) {
      line(gl.p0, gl.p1);
    }
    popStyle();
  }
}