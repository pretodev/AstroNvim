return {
  "AstroNvim/astrocore",
  opts = {
    autocmds = {
      personal_setup = {
        {
          event = "BufEnter",
          pattern = "*",
          callback = function()
            local filename = vim.fn.expand "%:t"
            local home = vim.fn.expand "$HOME"
            local cwd = vim.fn.getcwd()

            if filename == "" then
              -- Se o nome do arquivo é vazio
              if cwd == home then
                -- Se a pasta raiz é $HOME, mostre "~"
                vim.o.titlestring = "~"
              else
                -- Mostre o nome da pasta raiz
                vim.o.titlestring = vim.fn.fnamemodify(cwd, ":t")
              end
            else
              -- Se o nome do arquivo não é vazio
              local relative_path = vim.fn.expand "%:."
              if cwd == home then
                -- Se a pasta raiz é $HOME, mostre "~/<caminho_relativo>"
                vim.o.titlestring = "~/" .. relative_path
              elseif relative_path == filename then
                -- Se o arquivo está na raiz, mostre "./<filename>"
                vim.o.titlestring = "./" .. filename
              else
                -- Caso contrário, mostre "<dir>/<filename>"
                vim.o.titlestring = relative_path
              end
            end
          end,
        },
      },
    },
  },
}
