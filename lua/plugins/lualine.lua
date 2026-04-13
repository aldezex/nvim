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
                    function() return require("opencode").statusline() end,
                    cond = function()
                        local ok, status = pcall(require, "opencode.status")
                        return ok and status.status ~= nil
                    end,
                },
            },
        },
    },
}
