// Tiny demo platform by Walther

// Set up canvas to draw on + WebGL context for it
const canvas = document.createElement("canvas");
document.body.appendChild(canvas);
const gl = canvas.getContext("experimental-webgl");

// Wibbly wobbly timey-wimey stuff, also in public scope
const t0 = new Date().getTime(); // absolute starting time
let t = 0; // running time, milliseconds from starting time
let time; // running time, seconds
const demoLength = 10; // demo length in seconds, for cutting rendering of audio+video
const timeLimit = false;
const playSound = true;

// Music stack
const { music } = require("./music");
if (playSound) {
  music(t, demoLength);
}

// Some other initializations to have public scope
let shaderProgram; // shader program object

function main() {
  const vertexCode = require("./vertex.glsl");
  const fragmentCode = require("./fragment.glsl");

  function getShader(gl, id, type) {
    let shader;
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
  const fragmentShader = getShader(gl, fragmentCode, "fragment");
  const vertexShader = getShader(gl, vertexCode, "vertex");

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
  shaderProgram.vertexPositionAttribute = gl.getAttribLocation(
    shaderProgram,
    "aVertexPosition"
  );
  gl.enableVertexAttribArray(shaderProgram.vertexPositionAttribute);

  // All set, start drawing!
  draw();
}

function draw() {
  t = new Date().getTime() - t0; // Update time on every frame
  time = t * 0.001; // ...and normalize it to seconds

  if (!timeLimit || time <= demoLength) {
    // If demo has not ended,
    window.requestAnimationFrame(draw); // for every requested new frame, draw!
  } // This handily stops drawing at last frame, leaving it visible. Neat!

  // clear the screen before drawing the new frame
  gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

  // pass in the time to the shader programs from the canvas context
  gl.uniform1f(gl.getUniformLocation(shaderProgram, "time"), time);

  // set viewport start corner at (0,0), set viewport width+height = w+h of the canvas gl context
  gl.viewportWidth = canvas.width;
  gl.viewportHeight = canvas.height;
  gl.viewport(0, 0, gl.viewportWidth, gl.viewportHeight);

  // pass in the resolution to the shader programs from the canvas context
  gl.uniform2f(
    gl.getUniformLocation(shaderProgram, "resolution"),
    gl.viewportWidth,
    gl.viewportHeight
  );

  // Define some vertices
  let trianglePosBuffer;
  const trianglePos = [
    -1.0,
    -1.0,
    1.0,
    -1.0,
    -1.0,
    1.0,
    -1.0,
    1.0,
    1.0,
    -1.0,
    1.0,
    1.0
  ]; // Two triangles to make up a rectangular screen
  trianglePosBuffer = gl.createBuffer();
  gl.bindBuffer(gl.ARRAY_BUFFER, trianglePosBuffer);
  gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(trianglePos), gl.STATIC_DRAW);
  trianglePosBuffer.itemSize = 2;
  trianglePosBuffer.numItems = 6;

  // Draw the vertices
  gl.vertexAttribPointer(
    shaderProgram.vertexPositionAttribute,
    trianglePosBuffer.itemSize,
    gl.FLOAT,
    false,
    0,
    0
  );
  gl.drawArrays(gl.TRIANGLES, 0, 6);
}

// Helpful little function to enable realtime resize of the browser window
(function() {
  window.addEventListener("resize", resizeCanvas, false);
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
