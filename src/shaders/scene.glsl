// Distance field: insert objects here
// returns: distance & materialID
vec2 scene(vec3 pos)
{
  float field;
  float material;

  vec3 rotateSpace = pos;
  rotateSpace.x += 1.0;
  rotateSpace.z += 1.0;
  rotateSpace *= rotateX(0.1 * iTime);
  rotateSpace *= rotateZ(0.1 * iTime);

  pMod3(rotateSpace, vec3(3.5)); // repeats in 3d

  vec3 sphere1space = rotateSpace + vec3(2.0, 0.0, 0.0);
  vec3 sphere2space = rotateSpace + vec3(0.0, 2.0, 0.0);
  vec3 sphere3space = rotateSpace + vec3(0.0, 0.0, 2.0);
  vec3 sphere4space = rotateSpace + vec3(-2.0, 0.0, 0.0);
  vec3 sphere5space = rotateSpace + vec3(0.0, -2.0, 0.0);
  vec3 sphere6space = rotateSpace + vec3(0.0, 0.0, -2.0);
  vec3 sphere7space = rotateSpace + vec3(0.0, 0.0, 0.0);

  float cube = fBox(rotateSpace, vec3(0.1));
  float sphere1 = fBox(sphere1space, vec3(0.5, 0.5, 0.5));
  float sphere2 = fBox(sphere2space, vec3(0.5, 0.5, 0.5));
  float sphere3 = fBox(sphere3space, vec3(0.5, 0.5, 0.5));
  float sphere4 = fBox(sphere4space, vec3(0.5, 0.5, 0.5));
  float sphere5 = fBox(sphere5space, vec3(0.5, 0.5, 0.5));
  float sphere6 = fBox(sphere6space, vec3(0.5, 0.5, 0.5));
  float sphere7 = fBox(sphere7space, vec3(0.5, 0.5, 0.5));
  float ico = fIcosahedron(rotateSpace, 1.);

  // Combine objects
  field = MAX_DIST;
  // field = unionSDF(field, cube);
  // field = unionSDF(field, ico);
  // field = fOpUnionStairs(field, sphere1, 0.5, iTime);
  // field = fOpUnionStairs(field, sphere2, 0.5, iTime);
  // field = fOpUnionStairs(field, sphere3, 0.5, iTime);
  // field = fOpUnionStairs(field, sphere4, 0.5, iTime);
  // field = fOpUnionStairs(field, sphere5, 0.5, iTime);
  // field = fOpUnionStairs(field, sphere6, 0.5, iTime);
  // field = fOpUnionStairs(field, sphere7, 0.5, iTime);

  field = unionSDF(field, sphere1);
  field = unionSDF(field, sphere2);
  field = unionSDF(field, sphere3);
  field = unionSDF(field, sphere4);
  field = unionSDF(field, sphere5);
  field = unionSDF(field, sphere6);
  // field = unionSDF(field, sphere7);
  
  // Select material based on what we hit
  if (sphere1 <= field) {
    material = 1.0;
  } else if (sphere2 <= field) {
    material = 2.0;
  } else if (sphere3 <= field) {
    material = 3.0;
  } else if (sphere4 <= field) {
    material = 4.0;
  } else if (sphere5 <= field) {
    material = 5.0;
  } else if (sphere6 <= field) {
    material = 6.0;
  } else if (sphere7 <= field) {
    material = 7.0;
  };


  return vec2(field, material);
}