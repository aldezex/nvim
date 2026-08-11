return {
    "github/copilot.vim",
    event = "InsertEnter",
    -- `init` runs at startup, before the plugin loads; `config` runs when it
    -- loads, i.e. on first entering insert mode. The variables copilot reads
    -- while initialising, and the toggle keymap, belong in `init`: sitting in
    -- `config` they would not exist until something had been typed.
    init = function()
        vim.g.copilot_no_tab_map = true
        vim.g.copilot_assume_mapped = true
        vim.g.copilot_enabled = false           -- starts off, switched on by hand
        vim.g.copilot_settings = { selectedCompletionModel = "gpt-5" }

        vim.keymap.set("n", "<leader>cc", function()
            vim.g.copilot_enabled = not vim.g.copilot_enabled
            print(vim.g.copilot_enabled and "Copilot enabled" or "Copilot disabled")
        end, { desc = "Toggle Copilot" })
    end,
    config = function()
        -- Needs the plugin loaded: copilot#Accept only exists by then.
        vim.keymap.set("i", "<C-L>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
}
