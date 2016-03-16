Vst vst;
Player player;
Enemies enemy;
Enemies enemy2;
InputHandler inputHandler;
Level level;
Projectiles projectiles;
PhysicsObjects physicsObjects;
PVector enemyStart = new PVector(50, 50);
ArrayList<Enemies> enemies = new ArrayList<Enemies> (); 


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
  //enemy = new Enemies(enemyStart);
  //enemy2 = new Enemies(enemyStart2);
  player.physicsModel.setPosition(2000, 2000);
  physicsObjects.add(player.physicsModel);
  // enemy
  //physicsObjects.add(enemy.physicsModel);
  //physicsObjects.add(enemy2.physicsModel);
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
  //enemy.update();
  //enemy2.update();
  if (frameCount % 50 == 0 && enemies.size() < 10) {
    enemies.add(new Enemies(enemyStart));
  }
  
  // address individual enemies
  for (int i = 0; i < enemies.size(); i ++) {
    Enemies enemyBabies = enemies.get(i);
    physicsObjects.add(enemyBabies.physicsModel);
    
    //float playerHit = dist(enemyBabies.newPosition.x, enemyBabies.newPosition.y, player.newPosition.x, player.newPosition.y);
    //if (playerHit < 50) {
    // enemies.remove(enemyBabies);
    //}
    
    enemyBabies.update();
    enemyBabies.display();
   
  }
   
  
  physicsObjects.update();
  

  // Display world
  pushMatrix();
 
  translate(width / 2.0, height / 2.0);
  pushMatrix();
  translate(-player.physicsModel.position.x, -player.physicsModel.position.y); 
  level.display();
  popMatrix();
  projectiles.display();
  player.display();

  popMatrix();
  pushMatrix();
  //translate(-enemy.physicsModel.position.x, -enemy.physicsModel.position.y); 
  //enemy.display();
  //enemy2.display();
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