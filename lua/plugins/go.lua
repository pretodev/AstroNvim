return {
  {
    "maxandron/goplements.nvim",
    ft = "go",
  },

  {
    "Jay-Madden/auto-fix-return.nvim",
    ft = "go",
    config = function() require("auto-fix-return").setup {} end,
  },
}
