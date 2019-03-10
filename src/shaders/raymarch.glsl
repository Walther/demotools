
// Raymarch
// returns pos ended up at, surface normal at that point, material id
void rayMarch(inout vec3 pos, vec3 rayDir, out vec3 normal, out float material) {
  float totalDist = 0.0;
  float dist = EPSILON;
  for (int i = 0; i < MAX_ITER; i++)
  {
    dist = scene(pos).x;
    totalDist += dist;
    pos += dist * rayDir;

    if (dist < EPSILON || totalDist > MAX_DIST)
    break;
  }

  // Calculate normals
  if (dist < EPSILON)
  {
    vec2 eps = vec2(0.0, EPSILON);
    normal = normalize(vec3(
      scene(pos + eps.yxx).x - scene(pos - eps.yxx).x,
      scene(pos + eps.xyx).x - scene(pos - eps.xyx).x,
      scene(pos + eps.xxy).x - scene(pos - eps.xxy).x));

    material = scene(pos).y;
  }
  else {
    // didn't hit anything
    normal = vec3(0.0);
    material = 0.0;
  }

}