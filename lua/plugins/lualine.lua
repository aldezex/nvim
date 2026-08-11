return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            -- Was everforest, which had nothing to do with nanowise.
            -- ayu_mirage is the one that matches the Ghostty theme.
            theme = 'ayu_mirage',
        },
        sections = {
            lualine_y = {
                {
                    function()
                        if require("claudecode").is_claude_connected() then
                            return "[Claude]"
                        else
                            return "[Claude: idle]"
                        end
                    end,
                    cond = function()
                        local ok, claude = pcall(require, "claudecode")
                        return ok and claude.state and claude.state.initialized
                    end,
                },
            },
        },
    },
}
