class Enemies extends Being {
  private float rotateAmount = 0.1; 
  PVector acceleration = new PVector (0.4, 0.4);
  
  Enemies(PVector enemyStartPosition) {
    physicsModel = new PointMass(false);
    physicsModel.setDrag(0.5);
    physicsModel.setVelocity(2, 2);
    physicsModel.setPosition(enemyStartPosition);
  }
  
 void update() {
   angle -= rotateAmount;
   PVector a = PVector.fromAngle(angle);
   physicsModel.applyForce(a);
   
     // physicsModel.velocity.add(acceleration);
 }
 
 void display() {
   pushMatrix();
   noFill();
   stroke(brightness);
   ellipse(physicsModel.position.x, physicsModel.position.y, 50, 50);

    popMatrix();
 } 
}