# introtool.js

`introtool.js` is a minimalistic tool for making WebGL intros. It aims to have as little javascript as possible, while providing you with a WebGL context to draw your shaders on. It also provides a minimal tracker for creating music.

## Usage

TODO: needs a rewrite

## Optional optimization

- Use a javascript minifier before using `pnginator.rb`. It can significantly reduce the size of the end product. Many minifiers don't like the backticks though - you might need to pass the shaders as strings instead - sadly, that means you cannot have newlines, but you need to have each shader on one line.
- Use a shader minifier for the shaders before passing them as strings in the javascript. Again, significant reductions.

## Acknowledgements

`pnginator.rb` is included in this repository, as it is helpful for building the final tiny "executable". I don't claim ownership to it though: I modified it from a [gist](https://gist.github.com/gasman/2560551) written by [Gasman](http://matt.west.co.tt), based on an original idea by [Daeken](http://daeken.com/superpacking-js-demos)

## Licence

Apart from `pnginator` mentioned above, all my work in this project is published under the MIT licence.

Copyright © 2015 Veeti "Walther" Haapsamo

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
