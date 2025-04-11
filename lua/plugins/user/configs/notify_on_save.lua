return {
  "AstroNvim/astrocore",
  opts = {
    autocmds = {
      notify_on_save = {
        {
          event = "BufWritePost",
          desc = "Show notification when file is saved",
          callback = function()
            local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
            if filename ~= "" then
              require("astrocore").notify(filename .. " saved", vim.log.levels.INFO, {
                title = "File Saved",
                timeout = 1000, -- Shorter timeout (1 second)
                icon = "💾",
              })
            end
          end,
        },
      },
    },
  },
}
