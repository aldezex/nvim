return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            theme = 'everforest',
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
