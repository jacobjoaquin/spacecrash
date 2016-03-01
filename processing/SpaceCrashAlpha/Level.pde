abstract class Level extends DisplayableBase {
}

class RandomLevel extends Level {
  Walls walls = new Walls();

  RandomLevel() {
    int nWalls = 200;
    for (int i = 0; i < nWalls; i++) {
      PVector p0 = new PVector(random(4000), random(4000));
      PVector p1 = PVector.fromAngle(random(TAU));
      p1.mult(random(25, 300));
      p1.add(p0);
      walls.add(new Wall(p0, p1));
      walls.add(createWallRect(random(4000), random(4000), random(50, 200), random(50, 200)));
    }
    
    walls.add(createWallRect(0, 0, 4000, 4000));
  }

  void update() {
    walls.update();
  }

  void display() {
    walls.display();
  }
}