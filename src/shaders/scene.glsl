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

  rotateSpace.z += iTime;

  pMod3(rotateSpace, vec3(3.5)); // repeats in 3d

  vec3 box1space = rotateSpace + vec3(2.0, 0.0, 0.0);
  vec3 box2space = rotateSpace + vec3(0.0, 2.0, 0.0);
  vec3 box3space = rotateSpace + vec3(0.0, 0.0, 2.0);
  vec3 box4space = rotateSpace + vec3(-2.0, 0.0, 0.0);
  vec3 box5space = rotateSpace + vec3(0.0, -2.0, 0.0);
  vec3 box6space = rotateSpace + vec3(0.0, 0.0, -2.0);
  vec3 box7space = rotateSpace + vec3(0.0, 0.0, 0.0);

  float cube = fBox(rotateSpace, vec3(0.1));
  float box1 = fBox(box1space, vec3(0.5, 0.5, 0.5));
  float box2 = fBox(box2space, vec3(0.5, 0.5, 0.5));
  float box3 = fBox(box3space, vec3(0.5, 0.5, 0.5));
  float box4 = fBox(box4space, vec3(0.5, 0.5, 0.5));
  float box5 = fBox(box5space, vec3(0.5, 0.5, 0.5));
  float box6 = fBox(box6space, vec3(0.5, 0.5, 0.5));
  float box7 = fBox(box7space, vec3(0.5, 0.5, 0.5));

  // Combine objects
  field = MAX_DIST;
  field = unionSDF(field, box1);
  field = unionSDF(field, box2);
  field = unionSDF(field, box3);
  field = unionSDF(field, box4);
  field = unionSDF(field, box5);
  field = unionSDF(field, box6);
  // field = unionSDF(field, box7);
  
  // Select material based on what we hit
  if (box1 <= field) {
    material = 1.0;
  } else if (box2 <= field) {
    material = 2.0;
  } else if (box3 <= field) {
    material = 3.0;
  } else if (box4 <= field) {
    material = 4.0;
  } else if (box5 <= field) {
    material = 5.0;
  } else if (box6 <= field) {
    material = 6.0;
  } else if (box7 <= field) {
    material = 7.0;
  };


  return vec2(field, material);
}