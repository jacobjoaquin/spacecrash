class Wall extends DisplayableBase {
  GLine gl;
  float brightness = 128;

  Wall(GLine gl) {
   this.gl = gl;
  }

  void display() {
    pushStyle();
    stroke(brightness);
    line(gl.p0, gl.p1);
    popStyle();
  }
}

class Walls extends DisplayableList<Wall> {
  void add(GLine gl) {
    add(new Wall(gl));
  }
  
  void add(Walls walls) {
    this.addAll(walls);
  }

  void add(GLines glines) {
    for (GLine gl : glines) {
      add(new Wall(gl));
    }
  }
}