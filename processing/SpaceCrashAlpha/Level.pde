class LevelList extends DisplayableList<Level> {
}

abstract class Level extends DisplayableBase {
}

class LevelLineTest extends Level {
  Walls walls = new Walls();

  LevelLineTest() {
    player.angle = 0;
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

class LevelRectangleTest extends Level {
  Walls walls = new Walls();

  LevelRectangleTest() {
    // Rectangle Pattern    
    pushStyle();
    rectMode(CENTER);
    for (int i = 4; i <= 20; i += 4) {
      for (int j = 0; j < i; j++) {
        float a = j / (float) i * TAU;
        pushMatrix();
        rotate(a);
        translate((i - 2) * 50, 0);
        scale(map(i, 4, 16, 1, 3));
        walls.add(grect(0, 0, 50, 50));
        popMatrix();
      }
    }
    popStyle();

    // Border around whole level
    pushStyle();
    rectMode(CENTER);
    walls.add(grect(0, 0, 2000, 2000));
    popStyle();
  }

  void update() {
    walls.update();
  }

  void display() {
    walls.display();
  }
}

class LevelGShapeTest extends Level {
  Walls walls = new Walls();

  LevelGShapeTest() {
    player.angle = 0;

    // Create GShape
    GShape gs = new GShape();
    int nSides = 5;
    gs.begin();    
    for (int i = 0; i < nSides; i++) {
      float a = i / (float) nSides * TAU + QUARTER_PI;
      PVector p = PVector.fromAngle(a).mult(100);
      gs.vertex(p);
    }
    gs.end(false);

    // Display multiple GShapes after rotating and scaling
    for (int i = 0; i < 6; i++) {
      pushMatrix();
      float a = (i * 2) / (float) nSides * TAU;
      rotate(a);
      scale(1 + i * 2);
      walls.add(gs.get());
      popMatrix();
    }

    // Border around whole level
    pushStyle();
    rectMode(CENTER);
    walls.add(grect(0, 0, 2400, 2400));
    popStyle();
  }

  void update() {
    walls.update();
  }

  void display() {
    walls.display();
  }
}