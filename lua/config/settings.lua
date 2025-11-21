local set = vim.opt

-- Searching
set.hlsearch = true
set.incsearch = true
set.ignorecase = true
set.smartcase = true

-- directories
set.undodir = vim.fn.stdpath('state') .. '/undo//'
set.backupdir = vim.fn.stdpath('state') .. '/backup//'
set.directory = vim.fn.stdpath('state') .. '/swp//'

set.undofile = true

set.maxmempattern = 10000
set.nu = true
set.encoding = 'utf-8'

-- allow backspacing over everything in insert mode
set.backspace = 'indent,eol,start'

set.modeline = true
set.modelines = 10

set.ruler = true

set.wrap = true

set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.autoindent = true

set.showmode = true
set.showcmd = true

vim.cmd([[
  set list listchars=tab:\ \ ,trail:·
]])
