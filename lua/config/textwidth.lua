local set = vim.opt
local set_local = vim.opt_local
set.textwidth = 80
set.colorcolumn = "+1"
vim.api.nvim_set_hl(0, "ColorColumn", {
  bg = "darkred",
})
local au = vim.api.nvim_create_autocmd

local proseLangs = {
  "text",
  "markdown",
  "markdown.mdx",
}

vim.api.nvim_create_augroup("ProseTextWidth", { clear = true })
local au = vim.api.nvim_create_autocmd
for _, lang in ipairs(proseLangs) do
  au("FileType", {
    group = "ProseTextWidth",
    pattern = lang,
    callback = function()
      set_local.textwidth = 65
    end,
  })
end
