/* Monokai */
vec3 MONOKAI_DARKGREY  = vec3(0.153, 0.157, 0.133); // { color: #272822; } 
vec3 MONOKAI_BLACK     = vec3(0.063, 0.063, 0.063); // { color: #101010; } 
vec3 MONOKAI_WHITE     = vec3(1.0,   1.0,   1.0);   // { color: #ffffff; } 
vec3 MONOKAI_GREY      = vec3(0.459, 0.443, 0.369); // { color: #75715e; } 
vec3 MONOKAI_LIGHTGREY = vec3(0.341, 0.345, 0.333); // { color: #575855; } 
vec3 MONOKAI_PINK      = vec3(0.976, 0.149, 0.447); // { color: #f92672; } 
vec3 MONOKAI_ORANGE    = vec3(0.992, 0.592, 0.122); // { color: #fd971f; } 
vec3 MONOKAI_YELLOW    = vec3(0.965, 0.941, 0.502); // { color: #f6f080; } 
vec3 MONOKAI_GREEN     = vec3(0.651, 0.886, 0.18);  // { color: #a6e22e; } 
vec3 MONOKAI_BLUE      = vec3(0.306, 0.706, 0.98);  // { color: #4eb4fa; } 
vec3 MONOKAI_PURPLE    = vec3(0.682, 0.506, 1.0);   // { color: #ae81ff; }

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

