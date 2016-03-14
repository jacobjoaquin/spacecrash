// Utility functions

/**
 * Creates and returns a copy of the passed PVector with screen transforms applied.
 *
 * param p The PVector to copy and apply transforms to.
 */
PVector PVectorToScreen(PVector p) {
	return new PVector(screenX(p.x, p.y), screenY(p.x, p.y));
}

PVector getReflectionVector(PVector v, PVector n) {
  PVector u = n.copy().mult(2 * PVector.dot(v, n));
  return v.copy().sub(u);
}

PVector getReflectionVector(PointMass pm, Wall wall) {
  float wallAngle = atan2(wall.gl.p1.y - wall.gl.p0.y, wall.gl.p1.x - wall.gl.p0.x);
  return(getReflectionVector(pm.velocity, PVector.fromAngle(wallAngle + HALF_PI)));
}