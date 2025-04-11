return {
  {
    "AstroNvim/astrolsp",
    opts = {
      autocmds = {
        no_show_diagnostic = {
          {
            event = "InsertEnter",
            desc = "disable diagnostic on insert",
            callback = function(args)
              vim.diagnostic.enable(false)
              vim.api.nvim_create_autocmd("InsertLeave", {
                buffer = args.buf,
                once = true,
                callback = function() vim.diagnostic.enable(true) end,
              })
            end,
          },
        },
      },
    },
  },
}
