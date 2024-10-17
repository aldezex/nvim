return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    cmd = "Telescope",
    lazy = false,
    dependencies = {"nvim-lua/plenary.nvim"},
    keys = {
        {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files"},
        {"<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep (RG)"},
        {"<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find in buffers"}
    }
}

