# introtool.js

`introtool.js` is a minimalistic tool for making WebGL intros. It aims to have as little javascript as possible, while providing you with a WebGL context to draw your shaders on. It also provides a minimal tracker for creating music.

## Usage

1. Write your intro in the `introtool.js`. Shaders should be easy to write into the `fragmentCode` and `vertexCode` [template strings](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/template_strings). Template strings allow multiline strings, so the shader code can be pretty on many lines and correctly indented.
2. Build the demo with `ruby pnginator.rb introtool.js intro.html`
3. Open `intro.html` in your web browser and enjoy the demo

## Optional optimization

- Use a javascript minifier before using `pnginator.rb`. It can significantly reduce the size of the end product. Many minifiers don't like the backticks though - you might need to pass the shaders as strings instead - sadly, that means you cannot have newlines, but you need to have each shader on one line.
- Use a shader minifier for the shaders before passing them as strings in the javascript. Again, significant reductions.

## Acknowledgements

`pnginator.rb` is included in this repository, as it is helpful for building the final tiny "executable". I don't claim ownership to it though: I modified it from a [gist](https://gist.github.com/gasman/2560551) written by [Gasman](http://matt.west.co.tt), based on an original idea by [Daeken](http://daeken.com/superpacking-js-demos)