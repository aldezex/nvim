-- Must run before netrw loads; nvim-tree replaces it.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

opt.scrolloff = 20
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.backup = false
opt.writebackup = false
opt.encoding = 'utf-8'
opt.compatible = false
opt.updatetime = 300
opt.signcolumn = 'yes'
opt.termguicolors = true

opt.foldmethod = 'expr'
-- nvim-treesitter v1.x (main branch) dropped autoload/, so nvim_treesitter#foldexpr()
-- no longer exists. Folding is a native Neovim API now; it returns 0 for buffers
-- without a parser instead of erroring.
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevel = 20

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

vim.g.mapleader = " "

vim.diagnostic.config({ virtual_text = false })
