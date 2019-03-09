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
  // Iterate
  for (int i = 0; i < MAX_RECURSE; i++) {
    rayMarch(pos, rayDir, normal);

    float diffuse, specular;

    // Lighting, from camera
    diffuse = max(0.0, dot(-rayDir, normal));
    specular = pow(diffuse, 32.0);
    color += max(vec3(diffuse + specular - float(i)), 0.0);


    // Change direction for re-march.
    pos -= rayDir*0.1;
    // Remember to step out a bit, to not hit the object we bounced off!
    rayDir = reflect(rayDir, normal);
  }
  return color;
}