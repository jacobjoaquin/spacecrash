class CollisionDetector {
  CollisionDetector() {
  }
  
  float distance(PVector a, PVector b) {
    return sqrt(pow((b.y - a.y), 2.0) + pow((b.x - a.x), 2.0));
  }
  
  void checkCollision(PointMass p, PhysicsFixedLine fl) {
    if (distance(p.getPosition(), fl.getPosition()) < 10) {
      p.collidedWith(fl);
    }
  }
}