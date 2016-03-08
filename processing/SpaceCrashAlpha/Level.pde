class LevelList extends DisplayableList<Level> {
}

abstract class Level extends DisplayableBase {
  // Player
  // Enemies
  // Structures
  BarrierList barrierList = new BarrierList();

  void update() {
    barrierList.update();
  }

  void display() {
    barrierList.display();
  }
}

class LevelLineTest extends Level {
  LevelLineTest() {
    // Randomly generate WallList
    int nWallList = 200;
    for (int i = 0; i < nWallList; i++) {
      PVector p0 = new PVector(random(-2000, 2000), random(-2000, 2000));
      PVector p1 = PVector.fromAngle(random(TAU));
      p1.mult(random(25, 300));
      p1.add(p0);
      barrierList.add(new Wall(gline(p0, p1)));
    }
  }
}

class LevelRectangleTest extends Level {
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
        barrierList.add(new WallList(grect(0, 0, 50, 50)));
        popMatrix();
      }
    }
    popStyle();
  }
}

class LevelGShapeTest extends Level {
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
      barrierList.add(new WallList(gs.get()));
      popMatrix();
    }
  }
}

class LevelDynamicTest extends Level {
  LevelDynamicTest() {
    barrierList.add(new DynamicWall(gline(new PVector(0, 0), new PVector(100, 0))));
  }
}