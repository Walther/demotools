// Distance field: insert objects here
float scene(vec3 pos)
{
  float field;

  // Save space for cube
  vec3 cubeSpace = pos;
  // rotate cube space
  cubeSpace *= rotateX(0.1 * iTime);
  cubeSpace *= rotateZ(0.1 * iTime);
  // Insert cube

  //pMod3(cubeSpace, vec3(3.0));
  //float cube = fBox(cubeSpace, vec3(1.0));
  float cube = sugarcube(cubeSpace, 1.0);
  //float cube = mengerSponge(cubeSpace, 1.0, 3);
  //float cube = fIcosahedron(cubeSpace, 1.0);

  // Dodge the camera
  pos += vec3(1.5);

  // Combine objects
  field = 1.0;
  field = unionSDF(field, cube);

  return field;
}