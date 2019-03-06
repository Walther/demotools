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
  float cube = fBox(cubeSpace, vec3(0.2));

  // Dodge the camera
  pos += vec3(1.5);

  // Combine objects
  field = 1.0;
  field = min(field, cube);

  return field;
}