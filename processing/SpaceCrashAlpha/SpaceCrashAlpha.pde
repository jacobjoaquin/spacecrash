Vst vst;
Player player;
InputHandler inputHandler;
Level level;
Projectiles projectiles;

void settings() {
  size(450, 550, P2D);
  pixelDensity(displayDensity());
}

void setup() {
  frameRate(50);
  vst = new Vst(this, createSerial());
  vst.colorStroke = color(220, 220, 255);
  blendMode(ADD);

  player = new Player();
  player.physicsModel.setPosition(2000, 2000);
  inputHandler = new InputHandler();
  level = new RandomLevel();
  projectiles = new Projectiles();
}

void draw() {
  background(0);

  inputHandler.update();

  level.update();
  player.update();
  projectiles.update();

  pushMatrix();
  translate(width / 2.0, height / 2.0);
  translate(-player.physicsModel.position.x, -player.physicsModel.position.y);
  stroke(128);
  rect(0, 0, 4000, 4000);
  level.display();
  projectiles.display();
  
  popMatrix();
  pushMatrix();
  translate(width / 2.0, height / 2.0);
  projectiles.display();
  player.display();
  popMatrix();
  vst.display();

  inputHandler.clearReleased();
}

void keyPressed() {
  inputHandler.add(key);
}

void keyReleased() {
  inputHandler.release(key);
}