
// Raymarch
// returns pos ended up at + normal
void rayMarch(inout vec3 pos, vec3 rayDir, out vec3 normal) {
  float totalDist = 0.0;
  float dist = EPSILON;
  for (int i = 0; i < MAX_ITER; i++)
  {
    dist = distfunc(pos);
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
      distfunc(pos + eps.yxx) - distfunc(pos - eps.yxx),
      distfunc(pos + eps.xyx) - distfunc(pos - eps.xyx),
      distfunc(pos + eps.xxy) - distfunc(pos - eps.xxy)));
  }
  else {
    normal = vec3(0.0);
  }

}