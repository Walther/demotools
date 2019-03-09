float sugarcube(vec3 pos, float radius) {
    float scale_factor = 0.3; // hacky scale! TODO: proper math & scaled final output
    vec3 sugarcubepos = pos * scale_factor;
    float spheresize = 0.72 * radius;
    // float cubesize = 1.0 * radius; // Uncomment this line to see what's going on
    float cubesize = 0.5 * radius; // Comment this line to see what's going on
    vec3 offset = vec3(0.5*radius);
    vec3 spherepos = vec3(sugarcubepos + offset);
    vec3 repeat = vec3(1.0);
    pMod3(spherepos, repeat);
    float sphere = fSphere(spherepos, spheresize);
    float box = fBox(sugarcubepos, vec3(cubesize));
    return intersectSDF(box, -sphere) / scale_factor;
}