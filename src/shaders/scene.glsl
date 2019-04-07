// Distance field: insert objects here
// returns: distance & materialID
vec2 scene(vec3 pos)
{
  float field;
  float material;

  // Move a bit forward to dodge a massive hill that the camera would fly through
  pos.z += 25.; 
  // Move forward over time to explore the scene
  pos.z += 2.*iTime;

  // Add in the hills
  float hills = hills(pos);
  field = hills;

  if (hills <= field) {
    // If we hit a hill, make it green
    material = 6.0;
  }
  field = hills;

  return vec2(field, material);
}