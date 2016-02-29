
class Wall extends DisplayableBase {
  float brightness = 128;
  PVector p0;
  PVector p1;

  Wall(PVector p0, PVector p1) {
    this.p0 = p0;
    this.p1 = p1;
  }

  void display() {
    pushStyle();
    stroke(brightness);
    line(p0, p1);
    popStyle();
  }
}

class Walls extends DisplayableList<Wall> {
}

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
    }
  }

  void update() {
    walls.update();
  }

  void display() {
    walls.display();
  }
}