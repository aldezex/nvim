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
            -- no "jsonc": it is not a parser in nvim-treesitter v1.x. The jsonc
            -- filetype is mapped onto the json parser in plugin/filetypes.lua.
            "luadoc",
            "luap",
            "tsx",
            "rust",
            "go",
            "haskell",
        },
        -- nvim-treesitter v1.x: highlight and indent are enabled via native APIs in config()
        highlight = { enable = true },
        indent = { enable = true },
    },
    config = function(_, opts)
        -- On Windows, tree-sitter defaults to cl.exe (MSVC). Force gcc instead.
        if vim.fn.has("win32") == 1 and vim.fn.executable("cl") == 0 then
            vim.env.CC = "gcc"
        end

        -- nvim-treesitter v1.x: configs module removed, use the main module
        require("nvim-treesitter").setup({ install_dir = opts.install_dir })

        -- ensure_installed via TSInstall
        if opts.ensure_installed and #opts.ensure_installed > 0 then
            require("nvim-treesitter.install").install(opts.ensure_installed)
        end

        -- highlight, indent and incremental_selection are now native nvim APIs.
        -- Both attach per buffer, so they must be applied to future FileType
        -- events *and* to buffers that were already loaded: this plugin loads on
        -- VeryLazy, which fires after the FileType of the file nvim was opened
        -- with, leaving that first buffer unhighlighted.
        local function attach(buf)
            if not vim.api.nvim_buf_is_valid(buf) then
                return
            end

            if opts.highlight and opts.highlight.enable then
                -- fails when no parser is installed for the filetype; skip silently
                pcall(vim.treesitter.start, buf)
            end

            if opts.indent and opts.indent.enable then
                local ok, parser = pcall(vim.treesitter.get_parser, buf)
                if ok and parser then
                    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end
        end

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(ev)
                attach(ev.buf)
            end,
        })

        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) then
                attach(buf)
            end
        end

        vim.filetype.add({
            extension = {
                jsx = "javascriptreact",
                tsx = "typescriptreact",
            },
        })
    end,
}
