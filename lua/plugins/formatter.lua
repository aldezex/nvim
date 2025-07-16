return {
    'stevearc/conform.nvim',
    cmd = "ConformInfo",
    lazy = true,
    keys = {
        {
            "<leader>cF",
            function()
                require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
            end,
            mode = { "n", "v" },
            desc = "Format Injected Langs",
        },
    },
    opts = function()
        local opts = {
            default_format_opts = {
                timeout_ms = 3000,
                async = false,           -- not recommended to change
                quiet = false,           -- not recommended to change
                lsp_format = "fallback", -- not recommended to change
            },
            formatters_by_ft = {
                lua = { "stylua" },
                fish = { "fish_indent" },
                sh = { "shfmt" },
                javascript = { "biome-check" },
                typescript = { "biome-check" },
                typescriptreact = { "biome-check" },
                javascriptreact = { "biome-check" },
                rust = { "rustfmt" },
                haskell = { "ormolu" },
                go = { "gofmt", "goimports" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            formatters = {
                injected = { options = { ignore_errors = true } },
                -- dprint = {
                --   condition = function(ctx)
                --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
                --   end,
                -- },
                --
                -- # Example of using shfmt with extra args
                -- shfmt = {
                --   prepend_args = { "-i", "2", "-ci" },
                -- },
            },
        }
        return opts
    end,
}
