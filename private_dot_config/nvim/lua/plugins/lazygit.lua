return {
  "kdheepak/lazygit.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "LazyGit",
  keys = {
    {
      "<leader>l",
      "<cmd>LazyGit<cr>",
      desc = "Open LazyGit",
    },
  },
}
