import java.util.Iterator;

class PhysicsObjects<T extends PhysicsObject> extends ArrayList<T> {
  void update() {
    Iterator iter = this.iterator();
    while (iter.hasNext()) {
      T t = (T) iter.next();
      t.update();
    }
  }
}

abstract class PhysicsObject {
  protected PVector acceleration;
  protected PVector velocity;
  protected PVector position;
  protected PVector lastPosition;
  protected float mass;
  protected boolean immovable; // can this thing be moved by collisions?
  protected float drag;
  
  void update() {
    if (!immovable) {
      lastPosition = position.copy();
      velocity.add(acceleration);
      velocity.mult(1.0 - drag);
      position.add(velocity);
      acceleration.set(0,0);
    }
  }
  
  PVector getPosition() {
    return position;
  }
  void setPosition(int newX, int newY) {
    position.set(newX, newY);
  }
  void setPosition(PVector newPosition) {
    position = newPosition;
  }
  
  PVector getLastPosition() {
    return lastPosition;
  }
  void setLastPosition(int newX, int newY) {
    lastPosition.set(newX, newY);
  }
  void setLastPosition(PVector newPosition) {
    lastPosition = newPosition;
  }
  
  PVector getVelocity() {
    return velocity;
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
}