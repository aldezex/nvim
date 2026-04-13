return {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = {
        { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    },
    config = function()
        require('toggleterm').setup {
            direction = 'horizontal',
        }
    end,
}
