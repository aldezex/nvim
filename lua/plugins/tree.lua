return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = false,
    },
    -- Windows ships no `trash` binary, so nvim-tree's default fails the
    -- executable check in actions/fs/trash.lua. Point it at our own script,
    -- which appends the path as the last argument, as nvim-tree expects.
    trash = {
      cmd = string.format(
        "powershell -NoProfile -ExecutionPolicy Bypass -File %s",
        vim.fs.joinpath(vim.fn.stdpath("config"), "scripts", "trash.ps1")
      ),
    },
  },
}
