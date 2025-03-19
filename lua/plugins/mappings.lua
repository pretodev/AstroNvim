return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      n = {
        ["<tab>"] = { function() require("astrocore.buffer").prev() end, desc = "Next buffer" },

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

        ["<C-k>"] = { "<Up>", noremap = true, silent = true },
        ["<C-j>"] = { "<Down>", noremap = true, silent = true },
        ["<C-h>"] = { "<Left>", noremap = true, silent = true },
        ["<C-l>"] = { "<Right>", noremap = true, silent = true },
      },

      v = {
        ["J"] = { ":m '>+1<CR>gv=gv", noremap = true, silent = true },
      },

      x = {
        ["K"] = { ":m '<-2<CR>gv=gv", noremap = true, silent = true },
      },
    },
  },
}
