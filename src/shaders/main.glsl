// Main drawing loop
void main(){

  // Initialize hg_sdf
  hg_sdf_init();

  // Run the camera
  vec3 color = camera();

  // Post processing
  color = filmgrain(color, gl_FragCoord.xy, 0.001*iTime);
  color = vignette(color, 1.0);

  // output with full alpha
  gl_FragColor = vec4(color, 1.0);
}
