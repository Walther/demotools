# demotool

`demotool` is a minimalistic tool for making WebGL intros. It aims to have as little javascript as possible, while providing you with a WebGL context to draw your shaders on. It also provides a minimal tracker for creating music.

## Usage

- `yarn`
- `webpack --watch`
- open `./dist/index.html` in your favourite browser

## Optional optimization

- Use a javascript minifier before using `pnginator.rb`. It can significantly reduce the size of the end product. Many minifiers don't like the backticks though - you might need to pass the shaders as strings instead - sadly, that means you cannot have newlines, but you need to have each shader on one line.
- Use a shader minifier for the shaders before passing them as strings in the javascript. Again, significant reductions.

## Acknowledgements

`pnginator.rb` is included in this repository, as it is helpful for building the final tiny "executable". I don't claim ownership to it though: I modified it from a [gist](https://gist.github.com/gasman/2560551) written by [Gasman](http://matt.west.co.tt), based on an original idea by [Daeken](http://daeken.com/superpacking-js-demos)

## Licence

`pnginator` copyright original authors & my minor edits.

Everything else in this repository: dual licensed with CC-0 and the MIT License (because some jurisdictions apparently don't accept public domain)
