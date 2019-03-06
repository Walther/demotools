// intensity 0 through 4 is pretty nice
vec3 vignette(vec3 color, float intensity) {
    vec2 uv = gl_FragCoord.xy / resolution.xy-vec2(.5);
    return color * exp(-intensity*(uv.x*uv.x+uv.y*uv.y));
}