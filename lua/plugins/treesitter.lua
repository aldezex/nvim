return {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    event = { "VeryLazy" },
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "lua",
            "bash",
            "html",
            "markdown",
            "vim",
            "vimdoc",
            "javascript",
            "css",
            "typescript",
            "json",
            "jsdoc",
            "jsonc",
            "luadoc",
            "luap",
            "tsx",
            "vim",
            "vimdoc",
            "rust"
        },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = "<C-s>",
                node_decremental = "<bs>",
            },
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)

        vim.filetype.add({
            extension = {
                jsx = "javascriptreact",
                tsx = "typescriptreact",
            },
            filename = {
                ["*.jsx"] = "javascriptreact",
                ["*.tsx"] = "typescriptreact",
            },
        })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
            pattern = { "*.tsx", "*.jsx" },
            callback = function()
                vim.cmd("TSBufEnable highlight")
                vim.cmd("TSBufEnable indent")
                vim.cmd("TSBufEnable incremental_selection")
            end
        })
    end,
}
