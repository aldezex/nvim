return {
    "coder/claudecode.nvim",
    dependencies = {
        {
            "folke/snacks.nvim",
            opts = {
                input = { enabled = true }, -- Enhances the floating "Ask Claude" input
                picker = {
                    actions = {
                        claude_send = function(picker)
                            local sel = picker:selected({ fallback = true })
                            picker:close()
                            for _, item in ipairs(sel) do
                                local file = item.file or item.filename or item.path
                                if file then
                                    vim.cmd("ClaudeCodeAdd " .. vim.fn.fnameescape(file))
                                end
                            end
                        end,
                    },
                    win = {
                        input = {
                            keys = {
                                ["<a-a>"] = { "claude_send", mode = { "n", "i" } },
                            },
                        },
                    },
                },
            },
        },
    },
    config = function()
        require("claudecode").setup({
            terminal = {
                split_side = "right",
                split_width_percentage = 0.35,
            },
        })

        vim.o.autoread = true

        -- Helper: send text to the Claude Code terminal
        local function send_to_terminal(text)
            local bufnr = require("claudecode.terminal").get_active_terminal_bufnr()
            if not bufnr then return false end
            local chan = vim.b[bufnr].terminal_job_id
            if not chan then return false end
            vim.api.nvim_chan_send(chan, text .. "\n")
            return true
        end

        -- Helper: ensure terminal is open and send text
        local function ensure_terminal_and_send(text)
            if not send_to_terminal(text) then
                vim.cmd("ClaudeCodeOpen")
                vim.defer_fn(function()
                    send_to_terminal(text)
                end, 1000)
            else
                vim.cmd("ClaudeCodeFocus")
            end
        end

        -- Ask Claude with inline Snacks input below the selection
        local function ask_claude()
            local mode = vim.fn.mode()
            local is_visual = mode == "v" or mode == "V" or mode == "\22"
            local anchor_line = vim.fn.line(".")

            if is_visual then
                local start_line = vim.fn.line("v")
                local end_line = vim.fn.line(".")
                anchor_line = math.max(start_line, end_line)
                local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
                vim.api.nvim_feedkeys(esc, "x", false)
            end

            vim.schedule(function()
                if is_visual then
                    vim.cmd("'<,'>ClaudeCodeSend")
                end

                -- Place the input inline, right below the last selected line
                local win_top = vim.fn.line("w0")
                local row = anchor_line - win_top + 1

                Snacks.input({
                    prompt = "@ask claude: ",
                    win = {
                        relative = "win",
                        row = row,
                        col = 0,
                        width = 20,
                    },
                }, function(input)
                    if not input or input == "" then return end
                    ensure_terminal_and_send(input)
                end)
            end)
        end

        -- Execute Claude action (context-aware action picker)
        local function claude_select()
            local mode = vim.fn.mode()
            local is_visual = mode == "v" or mode == "V" or mode == "\22"

            if is_visual then
                local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
                vim.api.nvim_feedkeys(esc, "x", false)
            end

            vim.schedule(function()
                local actions = {
                    { text = "Explain this code", prompt = "Explain this code" },
                    { text = "Refactor this code", prompt = "Refactor this code for better readability and maintainability" },
                    { text = "Fix this code", prompt = "Fix the bugs in this code" },
                    { text = "Write tests", prompt = "Write tests for this code" },
                    { text = "Add documentation", prompt = "Add documentation to this code" },
                    { text = "Review this code", prompt = "Review this code for issues and improvements" },
                    { text = "Optimize", prompt = "Optimize this code for performance" },
                }

                vim.ui.select(actions, {
                    prompt = "Claude Action:",
                    format_item = function(item) return item.text end,
                }, function(choice)
                    if not choice then return end
                    if is_visual then
                        vim.cmd("'<,'>ClaudeCodeSend")
                    end
                    ensure_terminal_and_send(choice.prompt)
                end)
            end)
        end

        -- Operator function: add a motion range to Claude context
        _G._claude_operator = function()
            local start_line = vim.fn.line("'[")
            local end_line = vim.fn.line("']")
            local file = vim.fn.expand("%:p")
            vim.cmd(string.format("ClaudeCodeAdd %s %d %d", vim.fn.fnameescape(file), start_line, end_line))
        end

        -- Scroll Claude terminal from outside
        local function scroll_claude(direction)
            local bufnr = require("claudecode.terminal").get_active_terminal_bufnr()
            if not bufnr then return end
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                if vim.api.nvim_win_get_buf(win) == bufnr then
                    vim.api.nvim_win_call(win, function()
                        local key = direction == "up" and "\\<C-u>" or "\\<C-d>"
                        pcall(vim.cmd, "normal! " .. key)
                    end)
                    break
                end
            end
        end

        -- Keymaps (1:1 with opencode)
        vim.keymap.set({ "n", "x" }, "<C-a>", ask_claude, { desc = "Ask Claude..." })
        vim.keymap.set({ "n", "x" }, "<C-x>", claude_select, { desc = "Execute Claude action..." })
        vim.keymap.set({ "n", "t" }, "<C-.>", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
        vim.keymap.set("n", "<leader>op", "<cmd>ClaudeCodeOpen<cr>", { desc = "Open Claude" })
        vim.keymap.set("n", "<leader>po", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })

        vim.keymap.set({ "n", "x" }, "go", function()
            vim.o.operatorfunc = "v:lua._claude_operator"
            return "g@"
        end, { desc = "Add range to Claude", expr = true })
        vim.keymap.set("n", "goo", function()
            vim.o.operatorfunc = "v:lua._claude_operator"
            return "g@_"
        end, { desc = "Add line to Claude", expr = true })

        vim.keymap.set("n", "<S-C-u>", function() scroll_claude("up") end, { desc = "Scroll Claude up" })
        vim.keymap.set("n", "<S-C-d>", function() scroll_claude("down") end, { desc = "Scroll Claude down" })

        -- Remap increment/decrement since we use <C-a> and <C-x> for Claude
        vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
        vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
    end,
}
