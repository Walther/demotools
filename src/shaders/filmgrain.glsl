
// A hash function for some noise
float hash12(vec2 p)
{
  vec3 p3  = fract(vec3(p.xyx) * .1031);
  p3 += dot(p3, p3.yzx + 19.19);
  return fract((p3.x + p3.y) * p3.z);
}

// Some magic values for a pretty filmic grain
vec3 filmgrain(vec3 color) {
    float noise = (hash12(gl_FragCoord.xy + 0.001*iTime) / 3.0 + 0.85);
    return color * noise;
}
