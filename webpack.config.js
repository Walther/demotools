var webpack = require('webpack');

module.exports = {
    entry:  './main.js',
    output: {
        path:     './',
        filename: 'bundle.js',
    },
    module: {
      loaders: [
        {
          test: /\.glsl$/,
          loader: 'webpack-glsl'
        }
      ]
    },
    plugins: [
        new webpack.optimize.UglifyJsPlugin({minimize: true})
      ]
};
