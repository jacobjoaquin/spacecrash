Vst vst;
Player player;
Enemies enemy;
InputHandler inputHandler;
Level level;
Projectiles projectiles;
PhysicsObjects physicsObjects;

void settings() {
  size(450, 550, P2D);
  pixelDensity(displayDensity());
}

void setup() {
  frameRate(50);
  vst = new Vst(this, createSerial());
  vst.colorStroke = color(220, 220, 255);
  blendMode(ADD);

  physicsObjects = new PhysicsObjects();

  player = new Player();
  enemy = new Enemies();
  player.physicsModel.setPosition(2000, 2000);
  physicsObjects.add(player.physicsModel);
  // enemy
  physicsObjects.add(enemy.physicsModel);
  inputHandler = new InputHandler();
  level = new RandomLevel();
  projectiles = new Projectiles();
}

void draw() {
  background(0);

  // Update world items
  inputHandler.update();
  level.update();
  player.update();
  projectiles.update();
  enemy.update();

  physicsObjects.update();

  // Display world
  pushMatrix();
  if(frameCount % 30 == 0) {
  enemy.display();
  }
  translate(width / 2.0, height / 2.0);
  pushMatrix();
  translate(-player.physicsModel.position.x, -player.physicsModel.position.y); 
  level.display();
  popMatrix();
  projectiles.display();
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