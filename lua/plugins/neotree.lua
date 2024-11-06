return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>e", "<cmd>Neotree reveal<cr>", desc = "Explorer" },
    -- { "<leader>b", "<cmd>Neotree buffers reveal<cr>", desc = "Buffers" },
  },
  opts = function()
    return {
      -- Especifique apenas a fonte que você quer usar
      -- sources = { "filesystem", "buffers" },
      sources = { "filesystem" },
      -- Desativa o seletor de fontes para não exibir opções extras
      source_selector = nil,
      window = {
        position = "float",
        title = "",
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
      },
    }
  end,
}
