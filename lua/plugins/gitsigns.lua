-- Already on disk as a barbar dependency, but with nobody calling setup() it
-- drew nothing. With its own spec it does: gutter signs, ]c/[c to jump between
-- hunks, and blame for the line under the cursor.
return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        current_line_blame = true,
        current_line_blame_opts = {
            delay = 400,
            virt_text_pos = "eol",
        },
        on_attach = function(bufnr)
            local gs = require("gitsigns")
            local function map(mode, lhs, rhs, desc, extra)
                local o = vim.tbl_extend("force", { buffer = bufnr, desc = desc }, extra or {})
                vim.keymap.set(mode, lhs, rhs, o)
            end

            -- These return a key, so they need expr: inside a :diffthis the
            -- native ]c/[c pass through instead of jumping hunks.
            map("n", "]c", function()
                if vim.wo.diff then return "]c" end
                vim.schedule(function() gs.nav_hunk("next") end)
                return "<Ignore>"
            end, "Next hunk", { expr = true })

            map("n", "[c", function()
                if vim.wo.diff then return "[c" end
                vim.schedule(function() gs.nav_hunk("prev") end)
                return "<Ignore>"
            end, "Previous hunk", { expr = true })

            map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
            map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
            map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
            map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
        end,
    },
}
