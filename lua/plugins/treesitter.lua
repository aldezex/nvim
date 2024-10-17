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
            "vimdoc"
        },
        highlight = {
            enable = true,
            use_languagetree = true
        },
        indent = {
            enable = true
        }
    }
}
