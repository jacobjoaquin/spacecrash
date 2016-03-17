import java.util.Iterator;

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

class Wall extends DisplayableBase {
  PhysicsFixedLine physicsModel;
  GLine gl;
  float brightness = 128;
  Wall() {
  }
  
  Wall(GLine gl) {
   this.gl = gl;
   init();
  }

  void init() {
    // physicsModel = new PhysicsFixedLine(p0, p1);
  }

  void display() {
    pushStyle();
    stroke(brightness);
    line(gl.p0, gl.p1);
    popStyle();
  }
}

class WallList extends DisplayableList<Wall> {
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
    addAll(wl);
  }
}

class MovingWall extends Wall {
  GLine glineBase;

  MovingWall(GLine gl) {
    super(gl);
  }

  void init() {
    glineBase = gl.copy();
  }

  void update() {
    // gl = glineBase.copy();
    PVector p0 =  PVector.fromAngle(atan2(glineBase.p1.y - glineBase.p0.y, glineBase.p1.x - glineBase.p0.x)
      + frameCount / 300.0 * TAU);
    PVector p1 = p0.copy();
    p1.mult(glineBase.p0.dist(glineBase.p1));
    p0.add(glineBase.p0);
    p1.add(glineBase.p0);
    gl.p0 = p0;
    gl.p1 = p1;
  }
}