/*
Thoughts on creating barriers / walls:

A container that contains:
  Barriers, ie WallList
  Lists of Barriers, ie WallList

What is a barrier?
  A static line
  A list of multiple static lines
  A dynamic line
  A list of multiple dynamic lines
  A list of multiple static and dynamic lines
*/

class BarrierList<Barrier> extends DisplayableList {  
}

abstract class Barrier extends DisplayableBase {
  GLine gl;

  Barrier() {
  }

  Barrier(Barrier b) {
  }
}

class Wall extends Barrier {
  PhysicsFixedLine physicsModel;
  private GLine gl;
  float brightness = 128;
  Wall() {
  }
  
  Wall(GLine gl) {
   this.gl = gl;
  }

  void init() {
    physicsModel = new PhysicsFixedLine(p0, p1);
  }

  void display() {
    pushStyle();
    stroke(brightness);
    line(gl.p0, gl.p1);
    popStyle();
  }
}

class WallList<T> extends BarrierList {
  WallList() {
  }

  WallList(GLines glines) {
    for (GLine gl : glines) {
      add(gl);
    }
  }

  void add(GLine gl) {
    add(new Wall(gl));
  }

  void add(GLines glines) {
    WallList wl = new WallList();
    for (GLine gl : glines) {
      wl.add(gl);
    }
    add(wl);
  }
}

class DynamicWall extends Wall {
  PVector position = new PVector(0, 0);
  float angle = 0;
  float scaleX = 1;
  float scaleY = 1;

  DynamicWall() {
  }

  DynamicWall(GLine gl) {
    super(gl);
  }
  
 void update() {
    angle += 0.01;
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    translate(scaleX, scaleY);
    super.display();
    popMatrix();
  }
}

class DynamicWallList extends WallList<DynamicWall> {
  PVector position = new PVector(0, 0);
  float angle = 0;
  float scaleX = 1;
  float scaleY = 1;
  
  DynamicWallList() {
    super();
  }

  DynamicWallList(GLines glines) {
    super(glines);
  }

 void update() {
    angle += 0.01;
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    translate(scaleX, scaleY);
    super.display();
    popMatrix();
  }
}