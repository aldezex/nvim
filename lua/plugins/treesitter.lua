-- Pinned to `master` on purpose: upstream froze that branch in favour of
-- `main`, which has a different API (no nvim-treesitter.configs). With `branch`
-- set explicitly, lazy cannot jump branches and break this without warning.
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
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
            "rust",
            "go",
            "haskell",
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

        -- `filename` matches exact names, so the "*.jsx" entries that used to
        -- be here matched nothing; `extension` already does the job.
        vim.filetype.add({
            extension = {
                jsx = "javascriptreact",
                tsx = "typescriptreact",
            },
        })
    end,
}
