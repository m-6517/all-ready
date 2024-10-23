module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [require("daisyui")],
  daisyui: {
    darkTheme: false,
    themes: [
      {
        mytheme: {
          "primary": "#0577BE",
          "secondary": "#F3FCFF",
          "accent": "#F06292",
          // "neutral": "#F2F2F2",
          "base-100": "#F8F8F8",
          "base-200": "#F2F2F2",
          "base-300": "#D9D9D9",
        },
      },
    ],
  }
}
