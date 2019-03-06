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
  optimization: {
    minimize: true
  }
};
