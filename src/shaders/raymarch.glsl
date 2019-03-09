
// Raymarch
// returns pos ended up at + normal
void rayMarch(inout vec3 pos, vec3 rayDir, out vec3 normal) {
  float totalDist = 0.0;
  float dist = EPSILON;
  for (int i = 0; i < MAX_ITER; i++)
  {
    dist = scene(pos);
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
      scene(pos + eps.yxx) - scene(pos - eps.yxx),
      scene(pos + eps.xyx) - scene(pos - eps.xyx),
      scene(pos + eps.xxy) - scene(pos - eps.xxy)));
  }
  else {
    normal = vec3(0.0);
  }

}