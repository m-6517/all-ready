module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  darkMode: 'class',
  theme: {
    extend: {
      fontFamily: {
        'zen-kaku-gothic-new': ['"Zen Kaku Gothic New"', 'sans-serif'],
      },
    },
  },
  plugins: [require("daisyui")],
  daisyui: {
    darkTheme: "dark",
    themes: [
      {
        mytheme: {
          "primary": "#0577BE",
          "secondary": "#F3FCFF",
          "accent": "#F06292",
          "base-100": "#F8F8F8",
          "base-200": "#F2F2F2",
          "base-300": "#D9D9D9",
        },
        dark: {
          "primary": "#0577BE",
          "secondary": "#F3FCFF",
          "accent": "#F06292",
          "base-100": "#1E293B",
          "base-200": "#334155",
          "base-300": "#475569",
          "neutral": "#FFFFFF",
        },
      }
    ]
  }
}
