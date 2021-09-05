module.exports = {
  purge: ["./app/**/*.html.erb"],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      fontFamily: {
        ubuntu: ["Ubuntu", "cursive"],
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
};
