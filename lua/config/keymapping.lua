local map = vim.keymap.set

local all = { "n", "v", "s", "i", "o", "x", "c" }
local notins = { "n", "v", "s", "o", "x" }

map(notins, "J", "<C-e>", { noremap = true })
map(notins, "K", "<C-y>", { noremap = true })
map(notins, "H", "zhzh", { noremap = true })
map(notins, "L", "zlzh", { noremap = true })

map(notins, "<leader><leader>", function()
  return vim.lsp.buf.hover()
end, { desc = "Hover", noremap = true })

map(notins, "<leader>gy", function()
  return vim.lsp.buf.type_definition()
end, { desc = "go to type definition", noremap = true })

map(notins, "<leader>gi", function()
  return vim.lsp.buf.implementation()
end, { desc = "go to implementation", noremap = true })

map(notins, "<leader>gr", function()
  return vim.lsp.buf.references()
end, { desc = "show references", noremap = true })

map(notins, "<leader>ca", function()
  return vim.lsp.buf.code_action()
end, { desc = "Code Actions", noremap = true })

map(all, '<leader>.', ':%s/\\v +$//g<cr>', { noremap = true })

map("i", "JJJJ", "<Esc><C-e><C-e><C-e>", { noremap = true })
map("i", "KKKK", "<Esc><C-y><C-y><C-y>", { noremap = true })
map("i", "HHHH", "<Esc>zhzhzhzhzhzh", { noremap = true })
map("i", "LLLL", "<Esc>zhzhzhzhzhzh", { noremap = true })

map(notins, "j", "gj", { noremap = true })
map(notins, "k", "gk", { noremap = true })

-- make xX use the "x" register, rather than the default register
-- d already deletes and yanks to the default register
map(notins, "x", '"xx', { noremap = true })
map(notins, "X", '"xX', { noremap = true })

map(notins, "<leader><space>", function()
  vim.cmd([[
    :noh
    :call clearmatches()
    :syntax sync fromstart
  ]])
end, { noremap = true })

-- make cC yank to the "c" register.
-- it's rare that you want to correct and then re-paste, but possible.
map(notins, "c", '"cc', { noremap = true })
map(notins, "C", '"cC', { noremap = true })

-- right-handed escape from insert mode
map(all, "<leader>m", "<Esc>", { noremap = true })

map(notins, "/", "/\\v", { noremap = true })

-- window switching
map(all, '<C-j>', '<C-w>j', { noremap = true })
map(all, '<C-k>', '<C-w>k', { noremap = true })
map(all, '<C-h>', '<C-w>h', { noremap = true })
map(all, '<C-l>', '<C-w>l', { noremap = true })

-- this bt makes Q, W and WQ work just like their lowercase counterparts
vim.cmd([[
  com -bang Q q<bang>
  com -bang W w<bang> <args>
  com -bang WQ wq<bang> <args>
  com -bang Wq wq<bang> <args>
  com -bang WQa wqa<bang> <args>
  com -bang Wqa wqa<bang> <args>
  com -bang WQA wqa<bang> <args>
]])
