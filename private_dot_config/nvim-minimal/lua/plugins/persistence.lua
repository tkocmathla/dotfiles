return {
  "folke/persistence.nvim",
  lazy = false,
  opts = {
    dir = vim.fn.stdpath("state") .. "/sessions/",
    options = { "buffers", "curdir", "tabpages", "winsize" },
  },
}
