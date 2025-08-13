return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    -- Estendemos a configuração existente
    opts = opts or {}

    -- Histórico de buffers global
    if not vim.g.buffer_history then vim.g.buffer_history = {} end

    -- Função para atualizar o histórico de buffers
    local function update_buffer_history()
      local current_buf = vim.api.nvim_get_current_buf()
      local buffer_utils = require "astrocore.buffer"

      -- Verifica se é um buffer válido para adicionar ao histórico
      if not buffer_utils.is_valid(current_buf) then return end

      -- Remove o buffer atual do histórico se já existir
      local history = vim.g.buffer_history
      for i, buf in ipairs(history) do
        if buf == current_buf then
          table.remove(history, i)
          break
        end
      end

      -- Adiciona o buffer no início do histórico
      table.insert(history, 1, current_buf)

      -- Limita o tamanho do histórico para evitar crescimento excessivo
      if #history > 100 then table.remove(history) end
    end

    -- Função para navegar para trás no histórico (Tab)
    local function navigate_back()
      local history = vim.g.buffer_history
      if #history <= 1 then return end

      local current_buf = vim.api.nvim_get_current_buf()
      local current_pos = 0

      -- Encontra a posição do buffer atual no histórico
      for i, buf in ipairs(history) do
        if buf == current_buf then
          current_pos = i
          break
        end
      end

      -- Se não encontrou ou estamos no último buffer, não faz nada
      if current_pos == 0 or current_pos >= #history then return end

      -- Navega para o próximo buffer no histórico
      local next_buf = history[current_pos + 1]
      local buffer_utils = require "astrocore.buffer"
      if buffer_utils.is_valid(next_buf) then vim.api.nvim_set_current_buf(next_buf) end
    end

    -- Função para navegar para frente no histórico (Shift+Tab)
    local function navigate_forward()
      local history = vim.g.buffer_history
      if #history <= 1 then return end

      local current_buf = vim.api.nvim_get_current_buf()
      local current_pos = 0

      -- Encontra a posição do buffer atual no histórico
      for i, buf in ipairs(history) do
        if buf == current_buf then
          current_pos = i
          break
        end
      end

      -- Se não encontrou ou estamos no primeiro buffer, não faz nada
      if current_pos <= 1 then return end

      -- Navega para o buffer anterior no histórico
      local prev_buf = history[current_pos - 1]
      local buffer_utils = require "astrocore.buffer"
      if buffer_utils.is_valid(prev_buf) then vim.api.nvim_set_current_buf(prev_buf) end
    end

    -- Adiciona os autocmds à configuração
    opts.autocmds = opts.autocmds or {}
    opts.autocmds.buffer_history = {
      {
        event = "BufEnter",
        desc = "Update buffer history",
        callback = update_buffer_history,
      },
    }

    -- Adiciona os mapeamentos de tecla
    opts.mappings = vim.tbl_deep_extend("force", opts.mappings or {}, {
      n = {
        ["<Tab>"] = { navigate_back, desc = "Navigate to previous buffer in history" },
        ["<S-Tab>"] = { navigate_forward, desc = "Navigate to next buffer in history" },
      },
    })

    return opts
  end,
}
