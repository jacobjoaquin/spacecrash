int levelIndex = 1;

Vst vst;
Player player;
InputHandler inputHandler;
Level level;
Projectiles projectiles;
PhysicsObjects physicsObjects;
LevelList levelList;

void settings() {
  size(450, 550, P2D);
  pixelDensity(displayDensity());
}

void setup() {
  frameRate(50);
  vst = new Vst(this, createSerial());
  vst.colorStroke = color(220, 220, 255);
  // vst.displayTransit = true;
  blendMode(ADD);

  physicsObjects = new PhysicsObjects();

  player = new Player();
  player.physicsModel.setPosition(0, 0);
  physicsObjects.add(player.physicsModel);
  inputHandler = new InputHandler();
  projectiles = new Projectiles();
  levelList = new LevelList();
  levelList.add(new LevelLineTest());
  levelList.add(new LevelRectangleTest());
  // levelList.add(new LevelGShapeTest());
  // levelList.add(new LevelDynamicTest());
  level = levelList.get(levelIndex);
}

void draw() {
  background(0);

  // Update world items
  inputHandler.update();
  level.update();
  player.update();
  projectiles.update();

  // Handle physicsObjects  
  // physicsObjects.checkCollisions();
  physicsObjects.update();


  // Manually do physics
  updatePhysics();

  // Display world
  pushMatrix();
  translate(width / 2.0, height / 2.0);
  pushMatrix();
  translate(-player.physicsModel.position.x, -player.physicsModel.position.y); 
  level.display();
  projectiles.display();
  popMatrix();
  // projectiles.display();
  player.display();
  popMatrix();
  
  // Show on screen and handle input releases
  vst.display();
  inputHandler.clearReleased();
}

void keyPressed() {
  inputHandler.add(key);
}

void keyReleased() {
  inputHandler.release(key);
}

void updatePhysics() {
  // Projectiles
  for (Projectile p : projectiles) {
    for (Wall b : level.barrierList) {
      if (line_line(p.physicsModel.position, p.physicsModel.lastPosition, b.gl.p0, b.gl.p1)) {
        float [] v = line_line_p(p.physicsModel.position, p.physicsModel.lastPosition, b.gl.p0, b.gl.p1);
        p.physicsModel.velocity.mult(-1);
        p.physicsModel.position.set(v[0], v[1]);
        p.physicsModel.lastPosition.set(p.physicsModel.position.copy());
        p.physicsModel.position.add(p.physicsModel.velocity);
      }
    }
  }  
}
