return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            panel = {
                keymap = {
                    accept = "<S-CR>"
                }
            },
            suggestion = {
                auto_trigger = true,
            },
        })
    end,
}
