return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      n = {
        -- navigate buffer tabs
        ["<tab>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["<S-tab>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

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
