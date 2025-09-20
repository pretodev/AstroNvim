return {
  "AstroNvim/astrocore",

  --@type AstroCoreOpts
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

    mappings = {
      n = {
        ["<Leader><Leader>"] = {
          function() require("telescope.builtin").find_files() end,
          desc = "Find Files",
        },

        ["<Leader>b"] = {
          function()
            require("telescope.builtin").buffers {
              sort_lastused = true,
              ignore_current_buffer = true,
            }
          end,
          desc = "Buffers",
        },

        ["<Leader>Y"] = { 'gg"+yG', desc = "Copy buffer content" },

        ["<C-s>"] = {
          function() vim.lsp.buf.signature_help() end,
          desc = "Open signature modal",
          noremap = true,
          silent = true,
        },

        ["<C-e>"] = {
          function() vim.diagnostic.open_float() end,
          desc = "Open diagnostic modal",
          noremap = true,
          silent = true,
        },

        ["<Leader>o"] = false,
        ["<Leader>/"] = false,
        ["<Leader>h"] = false,
      },

      i = {
        ["<C-s>"] = {
          function() vim.lsp.buf.signature_help() end,
          desc = "Open signature modal",
          noremap = true,
          silent = true,
        },

        ["<C-e>"] = {
          function() vim.diagnostic.open_float() end,
          desc = "Open diagnostic modal",
          noremap = true,
          silent = true,
        },

        ["<C-l>"] = { "<Right>", noremap = true, silent = true },
        ["<C-k>"] = { "<Up>", noremap = true, silent = true },
        ["<C-j>"] = { "<Down>", noremap = true, silent = true },
        ["<C-h>"] = { "<Left>", noremap = true, silent = true },
      },

      v = {
        -- Move selected line(s) down
        ["J"] = { ":m '>+1<CR>gv=gv", noremap = true, silent = true },
      },

      x = {
        -- Move selected line(s) up
        ["K"] = { ":m '<-2<CR>gv=gv", noremap = true, silent = true },
      },
    },
  },
}
