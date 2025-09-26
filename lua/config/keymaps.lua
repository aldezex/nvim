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

-- Buffers
map('n', '<leader>sa', ':bprevious<CR>')
map('n', '<leader>sd', ':bnext<CR>')
map('n', '<leader>q', ':cprev<CR>')
map('n', '<leader>e', ':cnext<CR>')

-- Folding
--map('n', '<S-a>', 'za')
--map('n', '<S-j>', 'zj')
--map('n', '<S-k>', 'zk')

-- TABS
local opts = { noremap = true, silent = true }

-- Goto buffer in position...
map('n', '<leader>1', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<leader>2', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<leader>3', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<leader>4', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<leader>5', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<leader>6', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<leader>7', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<leader>8', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<leader>9', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<leader>0', '<Cmd>BufferLast<CR>', opts)

-- Close buffer
map('n', '<leader>ct', '<Cmd>BufferClose<CR>', opts)

-- Wipeout buffer
--                 :BufferWipeout

-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- -- END TABS
