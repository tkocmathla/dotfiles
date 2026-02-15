return {
  -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev
  "sindrets/diffview.nvim",
  keys = {
    { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Git file history" },
    { "<leader>gD",
      function()
        res = vim.api.nvim_exec2("G merge-base origin/main HEAD", { output = true })
        vim.cmd("DiffviewOpen " .. res["output"])
      end,
      desc = "Git diff branch changes",
    },
  },
}
