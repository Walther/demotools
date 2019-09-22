vec3 camera() {
  vec3 color = BASE_COLOR;
  // Camera setup
  vec3 cameraOrigin = vec3(0.0, 0.0, -2.0);
  vec3 cameraTarget = vec3(0.0, 0.0, 0.0);
  vec3 upDirection = vec3(0.0, 1.0, 0.0);
  vec3 cameraDir = normalize(cameraTarget - cameraOrigin);
  vec3 cameraRight = normalize(cross(upDirection, cameraOrigin));
  vec3 cameraUp = cross(cameraDir, cameraRight);
  vec2 screenPos = -1.0 + 2.0 * gl_FragCoord.xy / iResolution.xy; // screenPos can range from -1 to 1
  screenPos.x *= iResolution.x / iResolution.y;                   // Correct aspect ratio
  vec3 rayDir = normalize(cameraRight * screenPos.x + cameraUp * screenPos.y + cameraDir);

  // Call raymarch from camera origin
  vec3 pos = cameraOrigin;
  vec3 normal;
  float material;
  // Iterate
  for (int i = 0; i < MAX_RECURSE; i++) {
    rayMarch(pos, rayDir, normal, material);

    // Lighting, from camera
    float diffuse, specular;
    float dist = distance(cameraOrigin, pos);
    float distanceFalloff = 1.0 - 0.002 * pow(dist, 2.0);

    diffuse = max(0.0, dot(-rayDir, normal));
    specular = pow(diffuse, 32.0);
    color /= max(
      vec3(
        diffuse*distanceFalloff +
        specular*distanceFalloff
      ),
      0.0
    );


    // Object colors
    if (material == 1.0) {
      color *= MONOKAI_ORANGE;
    } else if (material == 2.0) {
      color *= MONOKAI_BLUE;
    } else if (material == 3.0) {
      color *= MONOKAI_PINK;
    } else if (material == 4.0) {
      color *= MONOKAI_YELLOW;
    } else if (material == 5.0) {
      color *= MONOKAI_PURPLE;
    } else if (material == 6.0) {
      color *= MONOKAI_GREEN;
    }
    

    // Change direction for re-march.
    pos -= rayDir*0.1;
    // Remember to step out a bit, to not hit the object we bounced off!
    rayDir = reflect(rayDir, normal);
  }
  return color;
}