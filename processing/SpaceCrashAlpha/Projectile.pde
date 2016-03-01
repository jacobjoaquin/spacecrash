// List for storing projectiles
class Projectiles extends DisplayableList<Projectile> {
}

// Base Projectile
abstract class Projectile extends DisplayableBase {
  float velocityMagnitude = 10;
  float brightness = 255;
  int framesLeft = 100;
  PVector position;
  PVector lastPosition;
  float angle;
  PVector velocity;
  Being owner;
  
  Projectile(Being owner, PVector position) {
    this.position = position.copy();
    lastPosition = this.position.copy();
    angle = owner.angle;
    velocity = PVector.fromAngle(angle);
    velocity.mult(velocityMagnitude);
    // TODO: Add partial velocity of owner
  }
  
  Projectile(Being owner) {
    this(owner, owner.position.copy());
  }
  
  void update() {
    if (--framesLeft == 0) {
      complete();
    }
    
    lastPosition = position.copy();
    position.add(velocity);
  }
  
  void display() {
    pushStyle();
    stroke(brightness);
    line(lastPosition.x, lastPosition.y, position.x, position.y);
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