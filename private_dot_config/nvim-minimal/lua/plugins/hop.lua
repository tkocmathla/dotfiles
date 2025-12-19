return {
  "smoka7/hop.nvim",
  keys = {
    { "<leader>h", "<cmd>HopWord<cr>", desc = "Hop to word" },
  },
  config = function()
    require("hop").setup()
  end,
}
