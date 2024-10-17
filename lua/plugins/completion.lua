return {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    dependencies = { 'rafamadriz/friendly-snippets' },

    version = 'v0.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            accept = '<C-CR>',
        },
        highlight = {
            use_nvim_cmp_as_default = true,
        },
        nerd_font_variant = 'normal',

        -- experimental auto-brackets support
        accept = { auto_brackets = { enabled = true } },

        -- experimental signature help support
        trigger = { signature_help = { enabled = true } }
    }
}
