precision highp float;
uniform float iTime;
uniform vec2 iResolution;

const int MAX_ITER = 128;
const float MAX_DIST = 32.0;
const float EPSILON = 0.001;
const int MAX_RECURSE = 1; // Reflections
const vec3 BASE_COLOR = vec3(0.153, 0.157, 0.133); // don't use pure black

// Note: import order matters:
// any functions used in files have to have been defined in earlier files
@import ./shaders/hg_sdf;
@import ./shaders/utils;
@import ./shaders/sugarcube;
@import ./shaders/menger_sponge;
@import ./shaders/filmgrain;
@import ./shaders/vignette;
@import ./shaders/scene;
@import ./shaders/raymarch;
@import ./shaders/camera;
@import ./shaders/main;
