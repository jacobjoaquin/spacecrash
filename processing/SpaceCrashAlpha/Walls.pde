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

class WallList extends DisplayableList<Wall> {
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
  
  void add(WallList WallList) {
    this.addAll(WallList);
  }

}


class Barrier {
/*
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
}