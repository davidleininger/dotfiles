module.exports = {
  config: {
    // set to false for no bell
    bell: "SOUND",

    // if true, selected text will automatically be copied to the clipboard
    copyOnSelect: false,

    // The text color under BLOCK cursor
    cursorAccentColor: "#d8dee9",

    // set to true for blinking cursor
    cursorBlink: false,

    // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorShape: "BLOCK",

    // default font size in pixels for all tabs
    fontSize: 18,

    // font family with optional fallbacks
    fontFamily: '"Inconsolata NF", monospace',

    // Clicking on them Links
    hyperlinks: {
      clickAction: "open",
      defaultBrowser: true,
    },

    // custom padding (css format, i.e.: `top right bottom left`)
    padding: "12px 14px",

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    shell: "/bin/zsh",

    // for setting shell arguments (i.e. for using interactive shellArgs: ['-i'])
    // by default ['--login'] will be used
    shellArgs: ["--login"],

    // The update channel to receive updates from
    updateChannel: "canary",
    webGLRenderer: false,
  },

  // a list of plugins to fetch and install from npm
  plugins: [
    "hyperterm-lastpass",
    "hypercwd",
    "hyperlinks",
    "hyper-alt-click",
    "hyperterm-paste",
    "hyperline",
    "hyper-cobalt-next-dark",
  ],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],
};
