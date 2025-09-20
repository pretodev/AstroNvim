return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    -- NUI é uma dependência obrigatória para a interface
    "MunifTanjim/nui.nvim",
    -- nvim-notify é uma dependência opcional para ter notificações mais ricas
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      -- Desativa a sobrescrita de `vim.lsp.util.convert_input_to_markdown_lines()`
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- Pré-configurações para obter a experiência semelhante ao LazyVim
    presets = {
      bottom_search = true, -- Barra de pesquisa no fundo
      command_palette = true, -- Paleta de comandos flutuante para ":"
      long_message_to_split = true, -- Mensagens longas abrem em um split
      inc_rename = false, -- Usa o rename nativo do Neovim
      lsp_doc_border = false, -- Adiciona borda a documentação do LSP
    },
  },
}
