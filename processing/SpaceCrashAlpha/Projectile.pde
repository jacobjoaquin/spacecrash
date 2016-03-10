// List for storing projectiles
class Projectiles extends DisplayableList<Projectile> {
}

// Base Projectile
abstract class Projectile extends DisplayableBase {
  float velocityMagnitude = 10;
  float brightness = 255;
  int framesLeft = 50;
  Being owner;
  PointMass physicsModel;
  
  Projectile(Being owner, PVector position) {
    physicsModel = new PointMass(false);
    physicsModel.setDrag(0.0);
    physicsModel.setPosition(position.copy());
    physicsModel.setLastPosition(position.copy());
    float angle = owner.angle;
    PVector velocity = PVector.fromAngle(angle).mult(velocityMagnitude);
    physicsModel.setVelocity(velocity);
    
    // TODO: Add partial velocity of owner
  }
  
  Projectile(Being owner) {
    this(owner, owner.physicsModel.position.copy());
  }
  
  void update() {
    if (--framesLeft == 0) {
      complete();
    }
  }
  
  void display() {
    pushStyle();
    stroke(brightness);
    line(physicsModel.getLastPosition().x, physicsModel.getLastPosition().y, physicsModel.getPosition().x, physicsModel.getPosition().y);
    popStyle();
  }
  
  void complete() {
    super.complete();
    // Code to remove PhysicsObject
  }
}

// Player laser
class PlayerLaser extends Projectile {
  PlayerLaser(Being owner) {
   super(owner);
  }

  PlayerLaser(Being owner, PVector position) {
   super(owner, position);
  }
}