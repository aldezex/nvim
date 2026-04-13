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
    end,
}
