return {
  {
    "neovim/nvim-lspconfig",
    opts = {},
    config = function (_, opts)

      local nvim_lsp = require("lspconfig")
      local lsp_util = require("lspconfig.util")
      vim.lsp.config("denols", {
        root_markers = { "deno.json", "deno.jsonc" },
        workspace_required = true,
        on_attach = function()
          -- https://github.com/denoland/deno/issues/28794
          -- https://github.com/onion108/onion27-nvim-config/blob/main/lua/terminal/tweaks/deno-lsp-correction.lua
          vim.api.nvim_create_autocmd({ "BufReadCmd" }, {
            pattern = { "deno:/*", "asset://*" },
            callback = function(params)
              --vim.notify("attempt to read: " .. vim.inspect(params.match))
              local bufnr = params.buf
              local actual_path = params.match:sub(1)

              local clients = vim.lsp.get_clients({ name = "denols" })
              if #clients == 0 then
                vim.notify("cannot find denols", vim.log.levels.WARN)
                return
              end

              local client = clients[1]
              local method = "deno/virtualTextDocument"
              local req_params = { textDocument = { uri = actual_path } }
              local response = client:request_sync(method, req_params, 2000, 0)
              if not response or type(response.result) ~= "string" then
                vim.notify("failed to get virtual document's content", vim.log.levels.WARN)
                return
              end

              local lines = vim.split(response.result, "\n")
              vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
              vim.api.nvim_set_option_value("readonly", true, { buf = bufnr })
              vim.api.nvim_set_option_value("modified", false, { buf = bufnr })
              vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
              vim.api.nvim_buf_set_name(bufnr, actual_path)
              vim.lsp.buf_attach_client(bufnr, client.id)

              local filetype = "typescript"
              if actual_path:sub(-3) == ".md" then
                filetype = "markdown"
              end
              vim.api.nvim_set_option_value("filetype", filetype, { buf = bufnr })
            end,
          })
        end,
      })

      vim.lsp.config("ts_ls", {
        root_markers = { "package.json" },
        single_file_support = false,
        cache = true,
        workspace_required = true,
      })

      vim.g.markdown_fenced_languages = {
        "ts=typescript",
      }

      vim.lsp.enable({
        --markdown
        --"ltex_plus",
        "ts_ls",
        "denols",
        "yamlls",
        "bashls",
        "rust_analyzer",
        "lua_ls",
      })

      -- https://github.com/denoland/deno/issues/28794
      -- https://github.com/onion108/onion27-nvim-config/blob/main/lua/terminal/tweaks/deno-lsp-correction.lua
      vim.api.nvim_create_autocmd({ "BufReadCmd" }, {
        pattern = { "deno:/*", "asset://*" },
        callback = function(params)
          --vim.notify("attempt to read: " .. vim.inspect(params.match))
          local bufnr = params.buf
          local actual_path = params.match:sub(1)

          local clients = vim.lsp.get_clients({ name = "denols" })
          if #clients == 0 then
            vim.notify("cannot find denols", vim.log.levels.WARN)
            return
          end

          local client = clients[1]
          local method = "deno/virtualTextDocument"
          local req_params = { textDocument = { uri = actual_path } }
          local response = client:request_sync(method, req_params, 2000, 0)
          if not response or type(response.result) ~= "string" then
            vim.notify("failed to get virtual document's content", vim.log.levels.WARN)
            return
          end

          local lines = vim.split(response.result, "\n")
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
          vim.api.nvim_set_option_value("readonly", true, { buf = bufnr })
          vim.api.nvim_set_option_value("modified", false, { buf = bufnr })
          vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
          vim.api.nvim_buf_set_name(bufnr, actual_path)
          vim.lsp.buf_attach_client(bufnr, client.id)

          local filetype = "typescript"
          if actual_path:sub(-3) == ".md" then
            filetype = "markdown"
          end
          vim.api.nvim_set_option_value("filetype", filetype, { buf = bufnr })
        end,
      })
    end,
  }
}
