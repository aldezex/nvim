return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    lazy = true,
    opts = {
        fomatters_by_ft = {
            javascript = { 'prettierd', 'prettier', stop_after_first = true },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    },
}
