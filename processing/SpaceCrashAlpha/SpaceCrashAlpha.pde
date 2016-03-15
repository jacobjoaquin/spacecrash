int levelIndex = 1;

Vst vst;
Player player;
InputHandler inputHandler;
Level level;
Projectiles projectiles;
PhysicsObjects physicsObjects;
LevelList levelList;

void settings() {
  // size(450, 550, P2D);
  size(500, 500, P2D);
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
  levelList.add(new LevelGShapeTest());
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
  // Projectiles vs Walls
  float scatter = 0.05;
  for (Projectile p : projectiles) {
    for (Wall wall : level.barrierList) {
      if (line_line(p.physicsModel.position, p.physicsModel.lastPosition, wall.gl.p0, wall.gl.p1)) {
        float[] intersection = line_line_p(p.physicsModel.position, p.physicsModel.lastPosition, wall.gl.p0, wall.gl.p1);
        PVector reflectionVector = getReflectionVector(p.physicsModel, wall);
        p.physicsModel.velocity = reflectionVector.copy().rotate(random(-scatter, scatter));
        p.physicsModel.position.set(intersection[0], intersection[1]);
        p.physicsModel.lastPosition.set(p.physicsModel.position.copy());
        p.physicsModel.position.add(p.physicsModel.velocity);
      }
    }
  }

  // Player vs Walls
  // TODO: Smoother bounce
  PVector playerPosition = player.physicsModel.position.copy();
  for (Wall wall : level.barrierList) {
    for (GLine gl : player.shipBoundaryScreen) {
      PVector p0 = playerPosition.copy().add(gl.p0);
      PVector p1 = playerPosition.copy().add(gl.p1);
      if (line_line(wall.gl.p0, wall.gl.p1, p0, p1)) {
        float[] intersection = line_line_p(wall.gl.p0, wall.gl.p1, p0, p1);
        PVector intersectionPoint = new PVector(intersection[0], intersection[1]);
        float wallAngle = atan2(wall.gl.p1.y - wall.gl.p0.y, wall.gl.p1.x - wall.gl.p0.x);
        PVector reflectionVector = getReflectionVector(player.physicsModel.velocity, PVector.fromAngle(wallAngle + HALF_PI));
        player.physicsModel.velocity = reflectionVector.copy();
        PVector offset = gl.p0;
        if (intersectionPoint.dist(p0) > intersectionPoint.dist(p1)) {
          offset = gl.p1;
        }
        player.physicsModel.position.set(playerPosition.copy().sub(offset.copy().mult(0.5)));
        player.disableThrustersFrames = 5;
        break;
      }      
    }    
  }
}