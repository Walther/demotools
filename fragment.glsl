// define high precision for floats
precision highp float;
// time and resolution passed from js side into shader world
uniform float time;
uniform vec2 resolution;

void main(){
  gl_FragColor=vec4(cos(time),sin(time*0.3),sin(time*0.7),1.0); // simple color gradient blink
}
