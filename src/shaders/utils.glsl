// Set operations
float intersectSDF(float distA, float distB) {
    return max(distA, distB);
}

float unionSDF(float distA, float distB) {
    return min(distA, distB);
}

float differenceSDF(float distA, float distB) {
    return max(distA, -distB);
}

// Rotations
mat3 rotateX(float v){return mat3(1,0,0,0,cos(v),-sin(v),0,sin(v),cos(v));}
mat3 rotateY(float v){return mat3(cos(v),0,sin(v),0,1,0,-sin(v),0,cos(v));}
mat3 rotateZ(float v){return mat3(cos(v),-sin(v),0,sin(v),cos(v),0,0,0,1);}

