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

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

vim.g.mapleader = " "

vim.diagnostic.config({ virtual_text = false })
