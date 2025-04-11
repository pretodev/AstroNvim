local M = {}
local keymap = vim.keymap.set

M.lsp_keymaps = function(bufnr)
  -- keymap("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, silent = true })
  keymap("n", "gD", "<cmd>Lspsaga finder<cr>", { buffer = bufnr, silent = true })
  keymap("n", "gd", "<cmd>Lspsaga goto_definition<cr>", { buffer = bufnr, silent = true })
  keymap("n", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP | Code Action", silent = true })
  -- keymap("n", "gd", vim.lsp.buf.definition, {buffer = bufnr, silent = true})
  keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>", { buffer = bufnr, silent = true })
  keymap("n", "gp", "<cmd>Lspsaga peek_definition<cr>", { buffer = bufnr, silent = true })
  -- keymap("n", "K", vim.lsp.buf.hover, {buffer = bufnr, silent = true})
  keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", { buffer = bufnr, silent = true })
  keymap("n", "gI", "<cmd>Telescope lsp_implementations<cr>", { buffer = bufnr, silent = true })
  keymap("v", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP | Code Action", silent = true })
end

M.fix_all = function(bufnr)
  local params = vim.lsp.util.make_range_params()
  params.context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }

  vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(err, result, _, _)
    if err or not result or vim.tbl_isempty(result) then return end

    for _, action in ipairs(result) do
      if action.title == "Fix all issues" or action.title:match "^Fix " then
        if action.edit then vim.lsp.util.apply_workspace_edit(action.edit, "UTF-8") end
        if action.command then vim.lsp.buf.execute_command(action.command) end
        return
      end
    end
  end)
end

-- Highlight symbol under cursor
M.lsp_highlight = function(client, bufnr)
  if client.supports_method "textDocument/documentHighlight" then
    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })
    vim.api.nvim_clear_autocmds {
      buffer = bufnr,
      group = "lsp_document_highlight",
    }
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

M.on_attach = function(client, bufnr)
  M.lsp_keymaps(bufnr)

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      M.fix_all(bufnr)
      vim.lsp.buf.format { async = false }
    end,
  })
  M.lsp_highlight(client, bufnr)
end

M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

return M
