return {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = {
        { "<leader>tm", "<cmd>ToggleTerm Horizontal<cr>", desc = "Toggle Term Horizontal" },
    },
    config = function()
        require('toggleterm').setup {
            direction = 'horizontal',
        }

        vim.api.nvim_set_keymap('t', '<C-w>j', [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
        vim.api.nvim_set_keymap('t', '<C-w>k', [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
    end,
}
