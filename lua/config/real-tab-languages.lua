-- languages that use real tabs
local hardTabLangs = {
  "make",
  "python",
  "go",
}

for _, lang in ipairs(hardTabLangs) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = lang,
    callback = function()
      vim.opt_local.expandtab = false
    end,
  })
end

return {}
