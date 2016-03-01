
class Wall extends DisplayableBase {
  float brightness = 128;
  PVector p0;
  PVector p1;

  Wall(PVector p0, PVector p1) {
    this.p0 = p0;
    this.p1 = p1;
  }
  
  Wall(float x0, float y0, float x1, float y1) {
    this(new PVector(x0, y0), new PVector(x1, y1));
  }

  void display() {
    pushStyle();
    stroke(brightness);
    line(p0, p1);
    popStyle();
  }
}

class Walls extends DisplayableList<Wall> {
  void add(Walls w) {
    this.addAll(w);
  }
}


Walls createWallRect(float x, float y, float w, float h) {
  Walls walls = new Walls();
  pushStyle();
  // Default is CORNER mode
  if (g.rectMode == CENTER) {
    w *= 0.5;
    h *= 0.5;
    walls.add(new Wall(x - w, y - h, x + w, y - h));
    walls.add(new Wall(x + w, y - h, x + w, y + h));
    walls.add(new Wall(x + w, y + h, x - w, y + h));
    walls.add(new Wall(x - w, y + h, x - w, y - h));
  } else {
    walls.add(new Wall(x, y, x + w, y));
    walls.add(new Wall(x + w, y, x + w, y + h));
    walls.add(new Wall(x + w, y + h, x, y + h));
    walls.add(new Wall(x, y + h, x, y));
  }
  popStyle();
  return walls;
}