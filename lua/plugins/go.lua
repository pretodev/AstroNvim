return {
  {
    "maxandron/goplements.nvim",
    ft = "go",
    opts = {},
  },

  {
    "Jay-Madden/auto-fix-return.nvim",
    ft = "go",
    config = function() require("auto-fix-return").setup {} end,
  },
}
