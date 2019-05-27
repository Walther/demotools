// Hash without Sine
// Creative Commons Attribution-ShareAlike 4.0 International Public License
// Created by David Hoskins.

// https://www.shadertoy.com/view/4djSRW
float hash12(vec2 p)
{
  vec3 p3  = fract(vec3(p.xyx) * .1031);
  p3 += dot(p3, p3.yzx + 19.19);
  return fract((p3.x + p3.y) * p3.z);
}

// End Hash without Sine

// Some magic values for a pretty filmic grain
vec3 filmgrain(vec3 color, vec2 coords, float time) {
    float noise = (hash12(coords + time) / 3.0 + 0.85);
    return color * noise;
}
