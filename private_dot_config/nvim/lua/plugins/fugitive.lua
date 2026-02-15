return {
  -- A Git wrapper so awesome, it should be illegal
  "tpope/vim-fugitive",
  lazy = false,
  keys = {
    { "<leader>ga", "<cmd>G blame<cr>", mode = "n", desc = "Git blame" },
    { "<leader>gd", "<cmd>Gdiff origin/main<cr>", mode = "n", desc = "Git diff" },
  },
}
