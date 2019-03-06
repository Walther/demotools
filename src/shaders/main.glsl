// Main drawing loop
void main(){

  // Camera setup
  vec3 cameraOrigin = vec3(2.0, 0.0, 0.0);
  vec3 cameraTarget = vec3(0.0, 0.0, 0.0);
  vec3 upDirection = vec3(0.0, 1.0, 0.0);
  vec3 cameraDir = normalize(cameraTarget - cameraOrigin);
  vec3 cameraRight = normalize(cross(upDirection, cameraOrigin));
  vec3 cameraUp = cross(cameraDir, cameraRight);
  vec2 screenPos = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy; // screenPos can range from -1 to 1
  screenPos.x *= resolution.x / resolution.y;                   // Correct aspect ratio
  vec3 rayDir = normalize(cameraRight * screenPos.x + cameraUp * screenPos.y + cameraDir);

  // Call raymarch from camera origin
  vec3 pos = cameraOrigin;
  vec3 normal;
  vec3 color = vec3(0.0); // default color
  //vec3 color = vec3(0.153, 0.157, 0.133); // dark warm grey

  // Iterate
  for (int i = 0; i < MAX_RECURSE; i++) {
    rayMarch(pos, rayDir, normal);

    float diffuse, specular;

    // Lighting, from camera
    diffuse = max(0.0, dot(-rayDir, normal));
    specular = pow(diffuse, 32.0);
    color += vec3(diffuse + specular - float(i) +0.3);


    // Change direction for re-march.
    pos -= rayDir*0.1;
    // Remember to step out a bit, to not hit the object we bounced off!
    rayDir = reflect(rayDir, normal);
  }

  // Bias the color a bit
  color = 0.1+color*0.7;

  //color = vec3(cos(time),sin(time*0.3),sin(time*0.7));

  // vignette
  vec2 uv = gl_FragCoord.xy / resolution.xy-vec2(.5);

  vec4 src = vec4(1.0,1.0,1.0,1.0);
  gl_FragColor = vec4(color * exp(-4.0*(uv.x*uv.x+uv.y*uv.y)), 1.0);

  //gl_FragColor = vec4(color, 1.0);
}