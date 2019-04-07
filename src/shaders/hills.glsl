// perlin from branch

vec2 hash( vec2 p )
{
	p = vec2( dot(p,vec2(127.1,311.7)),
			  dot(p,vec2(269.5,183.3)) );

	return -1.0 + 2.0*fract(sin(p)*43758.5453123);
}

float perlin( in vec2 p )
{
    const float K1 = 0.366025404; // (sqrt(3)-1)/2;
    const float K2 = 0.211324865; // (3-sqrt(3))/6;

	vec2 i = floor( p + (p.x+p.y)*K1 );
	
    vec2 a = p - i + (i.x+i.y)*K2;
    vec2 o = (a.x>a.y) ? vec2(1.0,0.0) : vec2(0.0,1.0); //vec2 of = 0.5 + 0.5*vec2(sign(a.x-a.y), sign(a.y-a.x));
    vec2 b = a - o + K2;
	vec2 c = a - 1.0 + 2.0*K2;

    vec3 h = max( 0.5-vec3(dot(a,a), dot(b,b), dot(c,c) ), 0.0 );

	vec3 n = h*h*h*h*vec3( dot(a,hash(i+0.0)), dot(b,hash(i+o)), dot(c,hash(i+1.0)));

    return dot( n, vec3(70.0) );
}

// end perlin from branch

// TODO: proper parametrization etc
// Too many magic variables within the function itself
float hills(vec3 p)
{
    float field;
    vec3 fieldpos = p - vec3(0.0, 4.0, 0.0); // Move the field down a bit
    field = fPlane(fieldpos, vec3(0.0, -1.0, 0.0), 0.0);

    float hills;

    // Combine from components
    float hill_1 = 20.0 * perlin(0.02 * fieldpos.xz); // High amplitude, very low frequency
    float hill_2 = 6.0 * perlin(0.1 * fieldpos.xz); // Medium amplitude, low frequency
    float hill_3 = 0.2 * perlin(1.0 * fieldpos.xz); // Small amplitude, high frequency
    float hill_4 = 0.05 * perlin(4.0 * fieldpos.xz); // Tiny amplitude, very high frequency
    
    hills += hill_1;
    hills += hill_2;
    hills += hill_3;
    hills += hill_4; // Optional, if performance hit is too large

    field += 0.5*hills;    

  return field;
  
}
