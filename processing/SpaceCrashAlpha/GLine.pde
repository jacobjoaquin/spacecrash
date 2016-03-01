class GLines extends DisplayableList<GLine> {}

class GLine extends DisplayableBase {
  PVector p0;
  PVector p1;
  
  GLine(PVector p0, PVector p1) {
    this.p0 = new PVector(screenX(p0.x, p0.y), screenY(p0.x, p0.y));
    this.p1 = new PVector(screenX(p1.x, p1.y), screenY(p1.x, p1.y));
  }
}

GLine gline(PVector p0, PVector p1) {
  return new GLine(p0, p1);
}

GLine gline(float x0, float y0, float x1, float y1) {
  return new GLine(new PVector(x0, y0), new PVector(x1, y1));
}

GLines grect(float x, float y, float w, float h) {
  GLines glines = new GLines();
  pushStyle();
  // Default is CORNER mode
  if (g.rectMode == CENTER) {
    w *= 0.5;
    h *= 0.5;
    glines.add(gline(x - w, y - h, x + w, y - h));
    glines.add(gline(x + w, y - h, x + w, y + h));
    glines.add(gline(x + w, y + h, x - w, y + h));
    glines.add(gline(x - w, y + h, x - w, y - h));
  } else {
    glines.add(gline(x, y, x + w, y));
    glines.add(gline(x + w, y, x + w, y + h));
    glines.add(gline(x + w, y + h, x, y + h));
    glines.add(gline(x, y + h, x, y));
  }
  popStyle();
  return glines;
}