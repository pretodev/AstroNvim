return {
  "AstroNvim/astrocore",
  opts = {
    features = {
      inlay_hints = true, -- enable inlay hints globally on startup
    },
    options = {
      opt = {
        scrolloff = 8,
        tabstop = 2,
        softtabstop = 2,
        shiftwidth = 2,
        expandtab = true,
        smartindent = true,
        foldmethod = "expr",
        wrap = true,
      },
    },
  },
}
