return {
  {
    "neovim/nvim-lspconfig",
    opts = {},
    config = function (_, opts)
      vim.lsp.config("denols", {
        root_markers = { "deno.json", "deno.jsonc" },
        workspace_required = true,
      })

      vim.lsp.config("ts_ls", {
        root_markers = { "package.json" },
        single_file_support = false,
        cache = true,
        workspace_required = true,
      })

      vim.g.markdown_fenced_languages = {
        "ts=typescript",
        "js=javascript",
        "typescript=typescript",
        "javascript=javascript",
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
    end,
  }
}
