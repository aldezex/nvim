return {
    "nvim-treesitter/nvim-treesitter",
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
            -- no "jsonc" parser exists; nvim core already maps the jsonc
            -- filetype onto the json parser, so tsconfig.json and friends
            -- highlight without anything extra here.
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

        -- Incremental selection. v1.x dropped it and core never replaced it,
        -- so the keymaps are reimplemented on top of vim.treesitter: <C-space>
        -- selects the node under the cursor, then grows to its parent; <bs>
        -- steps back down.
        local stack = {}

        local function same_range(a, b)
            local a1, a2, a3, a4 = a:range()
            local b1, b2, b3, b4 = b:range()
            return a1 == b1 and a2 == b2 and a3 == b3 and a4 == b4
        end

        local ESC = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)

        local function select_node(node)
            -- Grow and shrink are invoked from visual mode, where a bare `v`
            -- would LEAVE it and leave the selection off by one node. Drop to
            -- normal first, then place both ends.
            if vim.fn.mode():match("^[vV\22]") then
                vim.cmd("normal! " .. ESC)
            end

            local sr, sc, er, ec = node:range()
            -- treesitter ranges are 0-indexed and end-exclusive; visual mode
            -- wants 1-indexed and inclusive.
            if ec == 0 and er > sr then
                er = er - 1
                ec = #(vim.api.nvim_buf_get_lines(0, er, er + 1, false)[1] or "")
            end
            vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
            vim.cmd("normal! v")
            vim.api.nvim_win_set_cursor(0, { er + 1, math.max(ec - 1, 0) })
        end

        local function buf_stack()
            local b = vim.api.nvim_get_current_buf()
            stack[b] = stack[b] or {}
            return stack[b]
        end

        local function init_selection()
            local ok, node = pcall(vim.treesitter.get_node)
            if not ok or not node then return end
            local s = buf_stack()
            for i = #s, 1, -1 do s[i] = nil end
            s[1] = node
            select_node(node)
        end

        local function grow()
            local s = buf_stack()
            local node = s[#s]
            if not node then return init_selection() end
            local parent = node:parent()
            -- A parent covering exactly the same text is not a step up.
            while parent and same_range(parent, node) do parent = parent:parent() end
            if not parent then return select_node(node) end
            s[#s + 1] = parent
            select_node(parent)
        end

        local function shrink()
            local s = buf_stack()
            if #s > 1 then s[#s] = nil end
            if s[#s] then select_node(s[#s]) end
        end

        vim.keymap.set("n", "<C-space>", init_selection, { desc = "Select node" })
        vim.keymap.set("x", "<C-space>", grow, { desc = "Grow selection to parent node" })
        vim.keymap.set("x", "<bs>", shrink, { desc = "Shrink selection" })

        vim.api.nvim_create_autocmd("BufDelete", {
            callback = function(ev) stack[ev.buf] = nil end,
        })
    end,
}
