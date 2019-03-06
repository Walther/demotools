// Distance field: insert objects here
float distfunc(vec3 pos)
{
  float field;

  // Save space for cube
  vec3 cubeSpace = pos;
  // rotate cube space
  cubeSpace *= rotateX(time);
  cubeSpace *= rotateZ(time);
  // Insert cube

  //pMod3(cubeSpace, vec3(3.0));
  //float cube = fBox(cubeSpace, vec3(1.0));
  float cube = sugarcube(cubeSpace, 1.0);

  // Dodge the camera
  pos += vec3(1.5);

  // Combine objects
  field = 1.0;
  field = min(field, cube);

  return field;
}