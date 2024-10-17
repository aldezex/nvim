return {
    "saghen/blink.cmp",
    lazy = true,
    event = 'InsertEnter',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = 'v0.*',
    opts = {
        hightlight = {
            -- use_nvim_cmp_as_default = true,
        },
        nerd_font_variant = 'normal',
        keymap = {
            accept = '<C-CR>',
        },
    },
}
