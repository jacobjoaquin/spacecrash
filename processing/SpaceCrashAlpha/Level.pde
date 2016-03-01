abstract class Level extends DisplayableBase {
}

class RandomLevel extends Level {
  Walls walls = new Walls();

  RandomLevel() {
    // Rectangle Pattern
    pushStyle();
    rectMode(CENTER);
    for (int i = 4; i < 16; i += 4) {
      for (int j = 0; j < i; j++) {
        float a = j / (float) i * TAU;
        pushMatrix();
        rotate(a);
        translate((i - 2) * 50, 0);
        walls.add(grect(0, 0, 50, 50));
        popMatrix();
      }
    }
    popStyle();

    // Randomly generate walls
    int nWalls = 200;
    for (int i = 0; i < nWalls; i++) {
     PVector p0 = new PVector(random(-2000, 2000), random(-2000, 2000));
     PVector p1 = PVector.fromAngle(random(TAU));
     p1.mult(random(25, 300));
     p1.add(p0);
     walls.add(gline(p0, p1));
    }
    
    // Border around whole level
    pushStyle();
    rectMode(CENTER);
    walls.add(grect(0, 0, 4000, 4000));
    popStyle();
  }

  void update() {
    walls.update();
  }

  void display() {
    walls.display();
  }
}