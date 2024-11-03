return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>e", "<cmd>Neotree reveal<cr>", desc = "Explorer" },
  },
  opts = function()
    return {
      -- Especifique apenas a fonte que você quer usar
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
