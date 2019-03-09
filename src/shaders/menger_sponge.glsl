float fCross(vec3 pos, float size) {
    float tube1 = fBox2(pos.xy, vec2(size));
    float tube2 = fBox2(pos.xz, vec2(size));
    float tube3 = fBox2(pos.yz, vec2(size));

    float fCross = unionSDF(tube1, tube2);
    fCross = unionSDF(fCross, tube3);
    return fCross;
}

float sdCross( in vec3 p )
{
  float da = vmax(abs(p.xy));
  float db = vmax(abs(p.yz));
  float dc = vmax(abs(p.zx));
  return min(da,min(db,dc))-1.0;
}

// Inspired by http://iquilezles.org/www/articles/menger/menger.htm
float mengerSponge(vec3 pos, float size, int iter) { 
    // needs to be a compile-time constant
    const int sponge_iter = 6;

    vec3 cubePos = pos;
    float cube = fBox(cubePos, vec3(1.0));
    float menger = cube;
    vec3 crossSpace;
    float cross1;
    float pow_3 = 1.0;

    for (int i = 0; i < sponge_iter; i++) {
        crossSpace = mod( pos * pow_3, 2.0 ) -1.0;
        pow_3 *= 3.0; // increase power of three
        crossSpace = 1.0 - 3.0*abs(crossSpace);

        //cross1 = fCross(crossSpace, 1.0)/pow_3;
        cross1 = sdCross(crossSpace)/pow_3;
        menger = max(menger, cross1);
    }

    return menger;
}