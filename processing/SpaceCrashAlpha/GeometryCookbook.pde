// From Geometry 2D Cookbook @ Quarks Place
// http://lagers.org.uk/how-to/ht-geom-01/index.html

final float ACCY = 1;


/**
 * See if two finite lines intersect.
 * [x0, y0]-[x1, y1] start and end of the first line
 * [x2, y2]-[x3, y3] start and end of the second line
 */
public boolean line_line(float x0, float y0, float x1, float y1, float x2, float y2, float x3, float y3){
  float f1 = (x1 - x0);
  float g1 = (y1 - y0);
  float f2 = (x3 - x2);
  float g2 = (y3 - y2);
  float f1g2 = f1 * g2;
  float f2g1 = f2 * g1;
  float det = f2g1 - f1g2;
  if(abs(det) > ACCY){
    float s = (f2*(y2 - y0) - g2*(x2 - x0))/ det;
    float t = (f1*(y2 - y0) - g1*(x2 - x0))/ det;
    return (s >= 0 && s <= 1 && t >= 0 && t <= 1);
  }
  return false;
}

public boolean line_line(PVector p0, PVector p1, PVector p2, PVector p3) {
  return line_line(p0.x, p0.y, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
}

/**
 * Find the point of intersection between two finite lines.
 * This method uses x,y coordinates to represent the line end points.
 * [x0, y0]-[x1, y1] start and end of the first line
 * [x2, y2]-[x3, y3] start and end of the second line
 * if the two lines are parallel then null is returned, otherwise the intercept 
 * position is returned as an array.
 * If the array is of length:
 * 0 then there is no intersection (i.e. parallel)
 * 2 these are the x/y coordinates of the intersection point.
 */
public float[] line_line_p(float x0, float y0, float x1, float y1, float x2, float y2, float x3, float y3){
  float[] result = null;
  float f1 = (x1 - x0);
  float g1 = (y1 - y0);
  float f2 = (x3 - x2);
  float g2 = (y3 - y2);
  float f1g2 = f1 * g2;
  float f2g1 = f2 * g1;
  float det = f2g1 - f1g2;

  if(abs(det) > ACCY){
    float s = (f2*(y2 - y0) - g2*(x2 - x0))/ det;
    float t = (f1*(y2 - y0) - g1*(x2 - x0))/ det;
    if(s >= 0 && s <= 1 && t >= 0 && t <= 1)
      result = new float[] { x0 + f1 * s, y0 + g1 * s };
  }
  return (result == null) ? new float[0] : result;
}

public float[] line_line_p(PVector p0, PVector p1, PVector p2, PVector p3) {
  return line_line_p(p0.x, p0.y, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
}
