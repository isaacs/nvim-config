return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        -- make comments readable
        comments = {
          fg = "#dd66ff",
          italic = true,
        },
      },
      style = "night",
    },
    config = function(opt)
      -- vim.print("tokyonightopts", opt.opts)
      require("tokyonight").setup(opt.opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  }
}
