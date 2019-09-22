window.AudioContext = window.AudioContext || window.webkitAudioContext;
const ctx = new AudioContext();

// how to create an instrument
const kick = function(audiotime, frequency, volume) {
  let o = ctx.createOscillator();
  o.type = "sine";
  o.frequency.exponentialRampToValueAtTime(1.0, audiotime + 0.9);
  o.frequency.setValueAtTime(frequency, audiotime);

  let gain = ctx.createGain();
  gain.gain.setValueAtTime(volume, audiotime);
  gain.gain.exponentialRampToValueAtTime(0.5, audiotime + 0.5);
  o.connect(gain);
  gain.connect(ctx.destination);

  return o;
};

const kicknotes = [{ f: "80.0", l: 1, v: 0.8 }];

function playAll(instrument, notes, repeat, t, demoLength) {
  let audiotime = t,
    arrayLength = notes.length,
    playlength = 0,
    bpm = 120;

  while (audiotime <= demoLength && repeat === true) {
    for (let i = 0; i < arrayLength; i++) {
      playlength = (1 / (bpm / 60)) * notes[i].l;
      const o = instrument(audiotime, notes[i].f, notes[i].v);
      o.start(audiotime);
      o.stop(audiotime + playlength);
      audiotime += playlength;
    }
  }
}
export function music(t, demoLength) {
  playAll(kick, kicknotes, true, t, demoLength);
}
