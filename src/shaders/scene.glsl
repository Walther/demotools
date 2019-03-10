// Distance field: insert objects here
// returns: distance & materialID
vec2 scene(vec3 pos)
{
  float field;
  float material;

  vec3 rotateSpace = pos;
  rotateSpace *= rotateX(0.1 * iTime);
  rotateSpace *= rotateZ(0.1 * iTime);

  //pMod3(rotateSpace, vec3(4.0)); // repeats in 3d

  float cube = fBox(rotateSpace, vec3(0.8));
  float sphere = fSphere(rotateSpace, (1.1));
  float ico = fIcosahedron(rotateSpace, (1.));

  // Combine objects
  field = MAX_DIST;
  field = unionSDF(field, cube);
  field = unionSDF(field, sphere);
  field = unionSDF(field, ico);
  
  // Select material based on what we hit
  if (field < cube) {
    material = 1.0;
  } else if (field < sphere) {
    material = 2.0;
  } else {
    material = 3.0;
  }

  return vec2(field, material);
}