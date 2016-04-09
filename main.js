// Tiny demo platform by Walther

// Set up canvas to draw on + WebGL context for it
var canvas = document.createElement('canvas');
document.body.appendChild(canvas);
var gl = canvas.getContext("experimental-webgl");

// Wibbly wobbly timey-wimey stuff, also in public scope
var t0 = (new Date()).getTime();  // absolute starting time
var t = 0;                        // running time, milliseconds from starting time
var time;                         // running time, seconds
var demoLength = 10;              // demo length in seconds, for cutting rendering of audio+video

// Some other initializations to have public scope
var shaderProgram;                // shader program object
var resolution;                   // viewport resolution

/* Music stack. Thanks for Xard for helping at Assembly summer 2015 :) */
// create context
window.AudioContext = window.AudioContext || window.webkitAudioContext;
var ctx = new AudioContext();

// how to create an instrument
var kick = function(audiotime, frequency, volume){
  var o = ctx.createOscillator();
  o.type = 'sine';
  o.frequency.exponentialRampToValueAtTime(50.0, audiotime + 1);
  o.frequency.setValueAtTime(frequency, audiotime);

  var gain = ctx.createGain();
  gain.gain.setValueAtTime(volume, audiotime);
  gain.gain.exponentialRampToValueAtTime(0.001, audiotime + 0.5);
  o.connect(gain);
  gain.connect(ctx.destination);

  return o;
};

// How to define notes. Minimal notesheet
var kicknotes = [
  {'f':'100.0','l':1,'v':1.0}
];

function playAll(instrument, notes, repeat) {
    var o, audiotime=t, arrayLength = notes.length, playlength = 0, bpm = 120;

    while(audiotime <= demoLength && repeat == true){
      for (var i = 0; i < arrayLength; i++) {
          playlength = 1/(bpm/60) * notes[i].l;
          var o = instrument(audiotime, notes[i].f, notes[i].v);
          o.start(audiotime);
          o.stop(audiotime + playlength);
          audiotime += playlength;
      }
    }

};

// call playAll with instrument, notesheet, and a boolean for repeat
//playAll(kick, kicknotes, true);

// End music stack

function main() {

  var vertexCode = require('./vertex.glsl');
  var fragmentCode = require('./fragment.glsl');

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
  t = (new Date()).getTime() - t0;    // Update time on every frame
  time = t * 0.001;                   // ...and normalize it to seconds

  if (time <= demoLength) {             // If demo has not ended,
    window.requestAnimationFrame(draw); // for every requested new frame, draw!
  }                                     // This handily stops drawing at last frame, leaving it visible. Neat!

  // clear the screen before drawing the new frame
  gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);


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
