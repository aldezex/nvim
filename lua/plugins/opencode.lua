return {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
        {
            -- `snacks.nvim` integration is recommended, but optional
            ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
            "folke/snacks.nvim",
            opts = {
                input = { enabled = true }, -- Enhances `ask()`
                picker = { -- Enhances `select()`
                    actions = {
                        opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
                    },
                    win = {
                        input = {
                            keys = {
                                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                            },
                        },
                    },
                },
            },
        },
    },
    config = function()
        local port = 41234

        -- Kill any orphaned opencode process left on our port from a
        -- previous Neovim session that didn't clean up properly.
        local function kill_orphan_on_port()
            local handle = io.popen("lsof -ti :" .. port .. " 2>/dev/null")
            if handle then
                local pids = handle:read("*a")
                handle:close()
                for pid in pids:gmatch("%S+") do
                    os.execute("kill -TERM " .. pid .. " 2>/dev/null")
                end
            end
        end

        local cmd = "opencode --port " .. port
        local win_opts = {
            split = "right",
            width = math.floor(vim.o.columns * 0.35),
        }

        ---@type opencode.Opts
        vim.g.opencode_opts = {
            server = {
                port = port,
                start = function()
                    kill_orphan_on_port()
                    require("opencode.terminal").open(cmd, win_opts)
                end,
                stop = function()
                    require("opencode.terminal").close()
                end,
                toggle = function()
                    kill_orphan_on_port()
                    require("opencode.terminal").toggle(cmd, win_opts)
                end,
            },
        }

        vim.o.autoread = true -- Required for `opts.events.reload`

        -- Recommended/example keymaps
        vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end,
            { desc = "Ask opencode…" })
        vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,
            { desc = "Execute opencode action…" })
        vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
        vim.keymap.set("n", "<leader>op", function() require("opencode").start() end, { desc = "Open opencode" })
        vim.keymap.set("n", "<leader>po", function() require("opencode").toggle() end, { desc = "Toggle opencode off" })

        vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
            { desc = "Add range to opencode", expr = true })
        vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
            { desc = "Add line to opencode", expr = true })

        vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
            { desc = "Scroll opencode up" })
        vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
            { desc = "Scroll opencode down" })

        -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
        vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
        vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
    end,
}
