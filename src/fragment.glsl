precision highp float;
uniform float iTime;
uniform vec2 iResolution;

const int MAX_ITER = 128;
const float MAX_DIST = 32.0;
const float EPSILON = 0.001;
const int MAX_RECURSE = 1; // Reflections

@import ./shaders/utils;
@import ./shaders/sugarcube;
@import ./shaders/filmgrain;
@import ./shaders/vignette;
@import ./shaders/distancefunction;
@import ./shaders/raymarch;
@import ./shaders/main;
