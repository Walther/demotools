// Maximum/minumum elements of a vector
float vmax(vec3 v) {
  return max(max(v.x, v.y), v.z);
}

// Repeat in three dimensions
vec3 pMod3(inout vec3 p, vec3 size) {
  vec3 c = floor((p + size*0.5)/size);
  p = mod(p + size*0.5, size) - size*0.5;
  return c;
}

// Repeat the domain only in positive direction. Everything in the negative half-space is unchanged.
float pModSingle1(inout float p, float size) {
  float halfsize = size*0.5;
  float c = floor((p + halfsize)/size);
  if (p >= 0.0) {
    p = mod(p + halfsize, size) - halfsize;
  }
  return c;
}

// Primitives

float fSphere(vec3 p, float r) {
  return length(p) - r;
}

// Box: correct distance to corners
float fBox(vec3 p, vec3 b) {
  vec3 d = abs(p) - b;
  return length(max(d, vec3(0))) + vmax(min(d, vec3(0)));
}


// Rotations

mat3 rotateX(float v){return mat3(1,0,0,0,cos(v),-sin(v),0,sin(v),cos(v));}
mat3 rotateY(float v){return mat3(cos(v),0,sin(v),0,1,0,-sin(v),0,cos(v));}
mat3 rotateZ(float v){return mat3(cos(v),-sin(v),0,sin(v),cos(v),0,0,0,1);}

