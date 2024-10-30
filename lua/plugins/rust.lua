return {
    'mrcjkb/rustaceanvim',
    version = '^5',
    ft = { "rust" },
    config = function()
        vim.lsp.inlay_hint.enable(true)

        vim.keymap.set('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "Toggle Inlay Hints" })
    end,
}
