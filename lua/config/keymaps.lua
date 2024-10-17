local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- General mappings
map('n', '<leader>pv', ':Explore<CR>')
map('n', '<leader><CR>', ':so ~/.config/nvim/init.lua<CR>')
map('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')

-- Key remaps
map('n', 'b', 'q')
map('x', 'b', 'q')
map('n', 'q', 'b')
map('x', 'q', 'b')
map('n', 'B', 'Q')
map('x', 'B', 'Q')
map('n', 'Q', 'B')
map('x', 'Q', 'B')

map('n', '<leader>y', '"+y')
map('v', '<leader>y', '"+y')
map('n', '<leader>uc', 'gUU')
map('n', '<leader>lc', 'guu')
map('n', '<leader>gg', ':LazyGit<CR>')
map('n', '<leader>cp', ':let @*=expand("%:p")<CR>')

-- LSP mappings
map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
map('n', 'K', ':lua vim.lsp.buf.hover()<CR>')

require('config/barbar-keymaps')
