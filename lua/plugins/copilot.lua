return {
    "github/copilot.vim",
    event = "InsertEnter",
    lazy = false,
    autoStart = true,
    config = function()
        vim.g.copilot_assume_mapped = true
        vim.g.copilot_enabled = false
        vim.keymap.set("n", "<leader>cc", function()
            vim.g.copilot_enabled = not vim.g.copilot_enabled
            if vim.g.copilot_enabled then
                print("Copilot enabled")
            else
                print("Copilot disabled")
            end
        end, { desc = "Toggle Copilot" })
        vim.api.nvim_set_keymap("i", "<C-L>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
        vim.g.copilot_no_tab_map = true
    end,
}
