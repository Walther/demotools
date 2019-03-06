precision highp float;
uniform float time;
uniform vec2 resolution;

const int MAX_ITER = 128;
const float MAX_DIST = 32.0;
const float EPSILON = 0.001;
const int MAX_RECURSE = 1; // Reflections

@import ./shaders/utils;
@import ./shaders/distancefunction;
@import ./shaders/raymarch;
@import ./shaders/main;
