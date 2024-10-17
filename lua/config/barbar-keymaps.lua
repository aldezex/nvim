local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>sa', '<cmd>BufferPrevious<CR>', opts)
map('n', '<leader>sd', '<cmd>BufferNext<CR>', opts)
map('n', '<leader>sc', '<cmd>BufferClose<CR>', opts)
map('n', '<leader>sq', '<cmd>BufferCloseAllButCurrent<CR>', opts)
map('n', '<leader>sp', '<cmd>BufferPin<CR>', opts)
