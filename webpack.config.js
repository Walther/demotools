const webpack = require("webpack");

module.exports = {
  mode: "production",
  module: {
    rules: [
      {
        test: /\.glsl$/,
        loader: "webpack-glsl-loader"
      }
    ]
  },
  plugins: [new webpack.optimize.UglifyJsPlugin({ minimize: true })]
};
