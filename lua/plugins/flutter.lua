return {
  { import = "astrocommunity.pack.yaml" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dartls = {},
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      handlers = { dartls = false },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "dart" })
      end

      local select = vim.tbl_get(opts, "textobjects", "select")
      if select then select.disable = require("astrocore").list_insert_unique(select.disable, { "dart" }) end
    end,
  },
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    opts = function(_, opts)
      local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
      if astrolsp_avail then opts.lsp = astrolsp.lsp_opts "dartls" end

      opts.root_patterns = { ".git", "pubspec.yaml" }
      opts.flutter_lookup_cmd = false
      opts.fvm = true

      opts.ui = {
        border = "rounded",
        notification_style = "native",
      }

      opts.decorations = {
        statusline = {
          app_version = true,
          device = true,
          project_config = true,
        },
      }

      opts.widget_guides = { enabled = true }

      opts.closing_tags = {
        highlight = "Comment",
        prefix = "// ",
        enabled = true,
        priority = 100,
      }

      opts.dev_log = {
        enabled = true,
        notify_errors = true,
        open_cmd = "tabnew",
        focus_on_open = true,
        auto_open = true,
        max_log_lines = 1000,
      }

      opts.dev_tools = {
        autostart = true,
        auto_open_browser = false,
      }

      opts.outline = {
        open_cmd = "30vnew",
        auto_open = false,
      }

      opts.debugger = {
        enabled = true,
        exception_breakpoints = { "all" },
        evaluate_to_string_in_debug_views = true,
        run_via_dap = true,
        register_configurations = function(_)
          local dap = require "dap"
          local launchjs = vim.fn.getcwd() .. "/.vscode/launch.json"
          if vim.fn.filereadable(launchjs) == 1 then
            require("dap.ext.vscode").load_launchjs(launchjs, { dart = { "dart", "flutter" } })
          else
            dap.configurations.dart = {
              {
                type = "dart",
                request = "launch",
                name = "Launch Flutter Program",
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
                args = { "--flavor", "development" },
              },
              {
                type = "dart",
                request = "launch",
                name = "Flutter Profile Mode",
                program = "${workspaceFolder}/lib/main.dart",
                flutterMode = "profile",
              },
              {
                type = "dart",
                request = "attach",
                name = "Attach to Flutter Process",
              },
            }
          end
        end,
      }

      opts.build_runner = {
        enabled = true,
        auto_trigger = true,
        defer_start = false,
        debounce = 100,
      }

      opts.lsp = vim.tbl_deep_extend("force", opts.lsp or {}, {
        auto_attach = true,
        auto_start = true,
        init_options = {
          suggestFromUnimportedLibraries = true,
          closingLabels = true,
          outline = true,
          flutterOutline = true,
        },
        color = {
          enabled = true,
          background = true,
          foreground = false,
          virtual_text = true,
          virtual_text_str = "■",
        },
        settings = {
          showTodos = false,
          renameFilesWithClasses = "always",
          updateImportsOnRename = true,
          completeFunctionCalls = true,
          lineLength = 100,
          analysisExcludedFolders = {
            "${workspaceFolder}/.dart_tool/",
            "${workspaceFolder}/build/",
            "${workspaceFolder}/.fvm/",
          },
          suggestFromUnimportedLibraries = true,
          enableSdkFormatter = true,
        },
        on_attach = function(client, bufnr) require("plugins.lsp.opts").on_attach(client, bufnr) end,
      })
    end,
    config = function(_, opts)
      require("flutter-tools").setup(opts)

      vim.api.nvim_set_hl(0, "FlutterWidgetGuides", { fg = "#38BDAE", bg = "NONE" })
      vim.api.nvim_set_hl(0, "FlutterToolsOutlineIndentGuides", { fg = "#38BDAE", bg = "NONE" })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dart",
        callback = function()
          vim.opt_local.expandtab = true
          vim.opt_local.shiftwidth = 2
          vim.opt_local.softtabstop = 2
          vim.opt_local.tabstop = 2
        end,
      })

      -- Configurar projetos (um exemplo comum)
      if vim.fn.filereadable ".nvim.lua" == 1 then
        vim.notify("Flutter project configuration detected (.nvim.lua)", vim.log.levels.INFO)
      else
        require("flutter-tools").setup_project {
          name = "Debug",
          flutter_mode = "debug",
        }
      end

      vim.api.nvim_create_user_command("FlutterDocs", function(opts)
        local search_term = opts.args
        if search_term == "" then search_term = vim.fn.expand "<cword>" end
        local url = "https://api.flutter.dev/flutter/" .. search_term
        vim.fn.system { "open", url }
      end, { nargs = "?", desc = "Open Flutter documentation" })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>F"] = { desc = "Flutter Tools" },
              ["<leader>Fc"] = { "<cmd>FlutterLogClear<cr>", desc = "Clear Logs" },
              ["<leader>Fd"] = { "<cmd>FlutterDevices<cr>", desc = "List Devices" },
              ["<leader>Fe"] = { "<cmd>FlutterEmulators<cr>", desc = "List Emulators" },
              ["<leader>Fr"] = { "<cmd>FlutterRun<cr>", desc = "Run" },
              ["<leader>Fq"] = { "<cmd>FlutterQuit<cr>", desc = "Quit" },
              ["<leader>FR"] = { "<cmd>FlutterRestart<cr>", desc = "Restart" },
              ["<leader>FD"] = { "<cmd>FlutterDetach<cr>", desc = "Detach" },
              ["<leader>FH"] = { "<cmd>FlutterReload<cr>", desc = "Hot Reload" },
              ["<leader>Fo"] = { "<cmd>FlutterOutlineToggle<cr>", desc = "Toggle Outline" },
              ["<leader>Ft"] = { "<cmd>FlutterDevTools<cr>", desc = "Dev Tools" },
              ["<leader>Fs"] = { "<cmd>FlutterSuper<cr>", desc = "Go to Super" },
              ["<leader>Fa"] = { "<cmd>FlutterReanalyze<cr>", desc = "Reanalyze" },
              ["<leader>Fx"] = {
                function()
                  vim.lsp.buf.code_action {
                    filter = function(action) return action.title == "Fix all issues" end,
                    apply = true,
                  }
                end,
                desc = "Fix All Issues",
              },
              ["<leader>FB"] = {
                "<cmd>lua require('telescope').extensions.flutter.commands()<cr>",
                desc = "Flutter Commands",
              },
              ["<leader>Fg"] = { "<cmd>PubGet<cr>", desc = "Flutter Pub Get" },
              ["<leader>Fb"] = { "<cmd>FlutterRun --flavor development<cr>", desc = "Run Development" },
              ["<leader>Fp"] = { "<cmd>FlutterRun --flavor production<cr>", desc = "Run Production" },
              ["<leader>FG"] = {
                "<cmd>lua require('telescope.builtin').live_grep({search_dirs={'lib/'}})<cr>",
                desc = "Grep in lib",
              },
              ["<leader>FO"] = { "<cmd>FlutterDocs<cr>", desc = "Open Documentation" },
              ["<leader>Fw"] = {
                "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>",
                desc = "Workspace Symbols",
              },
            },
          },
          autocmds = {
            flutter_dart_format = {
              {
                event = { "BufWritePre" },
                desc = "Format Dart files before saving",
                pattern = { "*.dart" },
                callback = function()
                  vim.lsp.buf.code_action {
                    filter = function(action) return action.title == "Fix all issues" end,
                    apply = true,
                  }
                  vim.lsp.buf.format { async = false }
                end,
              },
            },
          },
        },
      },
      {
        "rebelot/heirline.nvim",
        optional = true,
        opts = function(_, opts)
          local status = require "astroui.status"
          local flutter_component = {
            condition = function() return vim.g.flutter_tools_decorations ~= nil end,

            provider = function()
              local result = ""
              -- app version
              if vim.g.flutter_tools_decorations.app_version then
                result = result .. " " .. vim.g.flutter_tools_decorations.app_version
              end
              -- current device
              if vim.g.flutter_tools_decorations.device then
                result = result .. " 📱" .. vim.g.flutter_tools_decorations.device
              end
              -- project configuration
              if vim.g.flutter_tools_decorations.project_config then
                local config = vim.g.flutter_tools_decorations.project_config
                if type(config) == "table" then
                  if config.name then
                    result = result .. " ⚙️ " .. config.name
                  else
                    result = result .. " ⚙️ Config"
                  end
                else
                  result = result .. " ⚙️ " .. config
                end
              end
              return result
            end,

            hl = { fg = "#42A5F5" },
          }

          if opts.statusline then
            local nav_index
            for i, component in ipairs(opts.statusline) do
              if component == status.component.nav then
                nav_index = i
                break
              end
            end

            if nav_index then
              table.insert(opts.statusline, nav_index, flutter_component)
            else
              table.insert(opts.statusline, flutter_component)
            end
          end

          return opts
        end,
      },
      {
        "nvim-telescope/telescope.nvim",
        optional = true,
        opts = function() require("telescope").load_extension "flutter" end,
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(plugin, opts)
      opts.servers = opts.servers or {}
      table.insert(opts.servers, "dartls")

      opts = require("astrocore").extend_tbl(opts, {
        setup_handlers = {
          -- add custom handler
          dartls = function(_, dartls_opts) require("flutter-tools").setup { lsp = dartls_opts } end,
        },
        config = {
          dartls = {
            -- any changes you want to make to the LSP setup, for example
            color = {
              enabled = true,
            },
            settings = {
              showTodos = true,
              completeFunctionCalls = true,
            },
          },
        },
      })
    end,
  },
  {
    "Nash0x7E2/awesome-flutter-snippets",
    event = "BufEnter *.dart",
  },
  {
    "nvim-flutter/pubspec-assist.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function() require("pubspec-assist").setup {} end,
  },
  {
    "sidlatau/dart-lsp-refactorings.nvim",
    event = "VeryLazy",
  },
  {
    "sidlatau/neotest-dart",
    dependencies = {
      "nvim-neotest/neotest",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-dart" {
            command = "fvm flutter", -- opcional, se usar FVM
            use_lsp = true,
            custom_test_method_names = { "testWidgets", "testGoldens" },
          },
        },
      }
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "dart-debug-adapter" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "dart", "dart-debug-adapter" })
    end,
  },
  {
    "AstronNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      commands = {
        PubGet = {
          function()
            local filename = vim.api.nvim_buf_get_name(0)
            if not filename:match "pubspec%.yaml$" then
              require("astrocore").notify("Este comando só pode ser usado em 'pubspec.yaml'", vim.log.levels.WARN)
              return
            end

            local use_fvm = vim.fn.filereadable "fvm_config.json" == 1 or vim.fn.isdirectory ".fvm" == 1
            local command = use_fvm and "fvm flutter pub get" or "flutter pub get"

            vim.cmd "botright split | resize 15"
            local bufnr = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_win_set_buf(0, bufnr)

            vim.fn.termopen(command, {
              on_exit = function(_, code)
                local msg = code == 0 and "✅ flutter pub get completed successfully!" or "❌ flutter pub get failed!"
                vim.schedule(
                  function() require("astrocore").notify(msg, code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR) end
                )
              end,
            })

            vim.cmd "normal! G"
          end,
          desc = "Flutter Pub Get",
        },
        BuildRunner = {
          function()
            local command = vim.fn.filereadable "fvm_config.json" == 1
                and "fvm flutter pub run build_runner build --delete-conflicting-outputs"
              or "flutter pub run build_runner build --delete-conflicting-outputs"

            vim.cmd "botright split | resize 15"
            local bufnr = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_win_set_buf(0, bufnr)

            vim.fn.termopen(command, {
              on_exit = function(_, code)
                local msg = code == 0 and "✅ Build runner completed successfully!" or "❌ Build runner failed!"
                vim.schedule(
                  function() require("astrocore").notify(msg, code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR) end
                )
              end,
            })

            vim.cmd "normal! G"
          end,
          desc = "Run Flutter Build Runner",
        },
        RunTestFile = {
          function()
            local filename = vim.api.nvim_buf_get_name(0)
            if not filename:match "_test%.dart$" then
              require("astrocore").notify("Este comando só pode ser usado em arquivos de teste", vim.log.levels.WARN)
              return
            end

            local use_fvm = vim.fn.filereadable "fvm_config.json" == 1 or vim.fn.isdirectory ".fvm" == 1
            local command = use_fvm and "fvm flutter test " or "flutter test "
            command = command .. filename

            vim.cmd "botright split | resize 15"
            local bufnr = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_win_set_buf(0, bufnr)

            vim.fn.termopen(command, {
              on_exit = function(_, code)
                local msg = code == 0 and "✅ Tests passed!" or "❌ Tests failed!"
                vim.schedule(
                  function() require("astrocore").notify(msg, code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR) end
                )
              end,
            })

            vim.cmd "normal! G"
          end,
          desc = "Run Flutter Test File",
        },
      },
    },
  },
}
