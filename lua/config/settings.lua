local opt = vim.opt

vim.g.mapleader = " "

-- Interface
opt.number = true
opt.relativenumber = true
opt.scrolloff = 20
opt.signcolumn = 'yes'
opt.termguicolors = true
opt.updatetime = 300

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search: case-insensitive unless the pattern contains an uppercase letter.
opt.ignorecase = true
opt.smartcase = true
-- Preview :%s/… substitutions in a split while typing them.
opt.inccommand = 'split'

-- New splits open where they are expected.
opt.splitright = true
opt.splitbelow = true

-- Persistent undo: survives closing the buffer and quitting nvim.
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.undolevels = 10000

-- Treesitter folds. The native API does not depend on the plugin and is faster
-- than the old nvim_treesitter#foldexpr().
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevel = 20

-- Diagnostics are drawn by tiny-inline-diagnostic, not by native virtual text.
vim.diagnostic.config({ virtual_text = false })
