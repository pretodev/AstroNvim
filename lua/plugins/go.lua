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

  {
    "mrcjkb/neotest-go",
    optional = true, -- Garante que só carregue se neotest estiver presente
    opts = {
      -- Remove a flag "-race" para evitar o erro com CGO_ENABLED=0
      go_test_args = { "-v", "-count=1" },
    },
  },
}
