// Tiny demo platform by Walther

// Set up canvas to draw on + WebGL context for it
var canvas = document.createElement('canvas');
document.body.appendChild(canvas);
var gl = canvas.getContext("experimental-webgl");

// Wibbly wobbly timey-wimey stuff, also in public scope
var t0 = (new Date()).getTime();  // absolute starting time
var t = 0;                        // running time, milliseconds from starting time
var time;                         // running time, seconds

// Some other initializations to have public scope
var shaderProgram;
var resolution;                   // viewport resolution

function main() {

  // Define shaders. ECMAScript 6 template strings multi-line goodness :)
  // Fragment shader
  var fragmentCode = `
    // define high precision for floats
    precision highp float;
    // time and resolution passed from js side into shader world
    uniform float time;
    uniform vec2 resolution;

    void main(){
      gl_FragColor=vec4(cos(time),sin(time*0.3),sin(time*0.7),1.0); // simple color gradient blink
    }
  `;

  // Vertex shader
  var vertexCode = `
    attribute vec3 aVertexPosition;
    void main(void) {
      gl_Position = vec4(aVertexPosition, 1.0);
    }
  `;

  function getShader(gl, id, type) {
    var shader;
    if (type == "fragment") {
      shader = gl.createShader(gl.FRAGMENT_SHADER);
    } else if (type == "vertex") {
      shader = gl.createShader(gl.VERTEX_SHADER);
    } else {
      return null;
    }

    gl.shaderSource(shader, id);
    gl.compileShader(shader);
    return shader;
  }

  // Compile shaders
  var fragmentShader = getShader(gl, fragmentCode, "fragment");
  var vertexShader = getShader(gl, vertexCode, "vertex");

  shaderProgram = gl.createProgram();
  gl.attachShader(shaderProgram, vertexShader);
  gl.attachShader(shaderProgram, fragmentShader);
  gl.linkProgram(shaderProgram);

  if (!gl.getProgramParameter(shaderProgram, gl.LINK_STATUS)) {
    alert("Could not initialise shaders");
  }

  // Use the shaders
  gl.useProgram(shaderProgram);
  // Pass in the vertex position attributes to the shader program
  shaderProgram.vertexPositionAttribute = gl.getAttribLocation(shaderProgram, "aVertexPosition");
  gl.enableVertexAttribArray(shaderProgram.vertexPositionAttribute);

  // All set, start drawing!
  draw();
}


function draw() {  
  window.requestAnimationFrame(draw); // For every requested new frame, draw!
  // clear the screen before drawing the new frame
  gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

  t = (new Date()).getTime() - t0;    // Update time on every frame
  time = t * 0.001;                   // ...and normalize it to seconds

  // pass in the time to the shader programs from the canvas context
  gl.uniform1f(gl.getUniformLocation(shaderProgram, 'time'), time);

  // set viewport start corner at (0,0), set viewport width+height = w+h of the canvas gl context
  gl.viewportWidth = canvas.width;
  gl.viewportHeight = canvas.height;
  gl.viewport(0, 0, gl.viewportWidth, gl.viewportHeight);
  
  // pass in the resolution to the shader programs from the canvas context
  gl.uniform2f(gl.getUniformLocation(shaderProgram, 'resolution'), gl.viewportWidth, gl.viewportHeight);

  // Define some vertices
  var trianglePosBuffer;
  var trianglePos = [-1.0, -1.0, 1.0, -1.0, -1.0,  1.0, -1.0,  1.0, 1.0, -1.0, 1.0,  1.0 ]; // Two triangles to make up a rectangular screen
  trianglePosBuffer = gl.createBuffer();
  gl.bindBuffer(gl.ARRAY_BUFFER, trianglePosBuffer);
  gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(trianglePos), gl.STATIC_DRAW);
  trianglePosBuffer.itemSize = 2;
  trianglePosBuffer.numItems = 6;

  // Draw the vertices
  gl.vertexAttribPointer(shaderProgram.vertexPositionAttribute, trianglePosBuffer.itemSize, gl.FLOAT, false, 0, 0);
  gl.drawArrays(gl.TRIANGLES, 0, 6);

}

// Helpful little function to enable realtime resize of the browser window
(function() {
  window.addEventListener('resize', resizeCanvas, false);
  function resizeCanvas() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    drawStuff(); 
  }
  resizeCanvas();
  function drawStuff() {
    main();
  }
})();