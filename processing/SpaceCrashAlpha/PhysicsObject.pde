import java.util.Iterator;

class PhysicsObjects<T extends PhysicsObject> extends ArrayList<T> {
  void update() {
    Iterator iter = this.iterator();
    while (iter.hasNext()) {
      T t = (T) iter.next();
      t.update();
    }
  }
  
  void checkCollisions() {
    // for (Collision current : this) {
    //   for (Collision other : this) {
    //     current.checkCollision(other);
    //   }
    // }
  }
}

interface Collision {
  void checkCollision(PointMass pm);
  void checkCollision(PhysicsFixedLine fl);
}

abstract class PhysicsObject implements Collision {
  protected PVector acceleration;
  protected PVector velocity;
  protected PVector position;
  protected PVector lastPosition;
  protected float mass;
  protected boolean immovable; // can this thing be moved by collisions?
  protected float drag;
  
  PhysicsObject() {
    physicsObjects.add(this);
  }
  
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
    super(); 
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
  
  void collidedWith(PhysicsFixedLine fl) {
    velocity.set(0,1);
  }
  float distance(PVector a, PVector b) {
    return sqrt(pow((b.y - a.y), 2.0) + pow((b.x - a.x), 2.0));
  }
  void checkCollision(PointMass p) {
  }
  void checkCollision(PhysicsFixedLine fl) {
    if (distance(position, fl.getPosition()) < 10) {
      collidedWith(fl);
    }
  }
}

class PhysicsFixedLine extends PhysicsObject {
  private PVector startPoint;
  private PVector endPoint;
    
  PhysicsFixedLine(PVector myStartPoint, PVector myEndPoint) {
    super();
    startPoint = myStartPoint;
    endPoint = myEndPoint;
    
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    position = new PVector(0,0);
    lastPosition = new PVector(0,0);
    mass = 1.0;
    immovable = true;
    drag = 0.0;
  }
  
  PVector getStartPoint() {
    return startPoint;
  }
  PVector getEndPoint() {
    return endPoint;
  }
  void checkCollision(PhysicsFixedLine foo) {
    
  }
}