return {
  {
    dir = vim.fn.stdpath("config") .. "/colors",
    name = "nanowise",
    opts = {},
    config = function()
      vim.cmd.colorscheme("nanowise")
    end,
  }
}
