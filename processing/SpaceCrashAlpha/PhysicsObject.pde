import java.util.Iterator;

abstract class PhysicsObject {
  PVector acceleration;
  PVector velocity;
  PVector position;
  PVector lastPosition;
  float mass;
  boolean immovable;
  float drag;
  
  void update() {
    if (!immovable) {
      lastPosition = position.copy();
      velocity.add(acceleration);
      velocity.mult(1.0 - drag);
      position.add(velocity);
      acceleration.set(0,0);
    }
  }
}

class PointMass extends PhysicsObject {
  float radius;
  
  PointMass(boolean isImmovable) {   
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    position = new PVector(0,0);
    lastPosition = new PVector(0,0);
    mass = 1.0;
    immovable = isImmovable;
    drag = 0.05;
    
    radius = 1.0;
  }
  
  float getRadius() {
    return radius;
  }
  void setRadius(float newRadius) {
    radius = newRadius;
  }
  
  void setPosition(int newX, int newY) {
    position.set(newX, newY);
  }
  void setPosition(PVector newPosition) {
    position = newPosition;
  }
  
  void setVelocity(int newX, int newY) {
    velocity.set(newX, newY);
  }
  void setVelocity(PVector newVelocity) {
    velocity = newVelocity;
  }
  
  void setDrag(float newDrag) {
    drag = newDrag;
  }
  
  void applyForce(PVector force) {
    PVector accToAdd = PVector.div(force, mass);
    acceleration.add(accToAdd);
  }
  
  void update() {
    super.update();
  }
}