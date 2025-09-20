return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>e", "<cmd>Neotree reveal<cr>", desc = "Explorer" },
  },
  opts = {
    sources = { "filesystem" },
    buffers = {},
    git_status = {},
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
  },
}
