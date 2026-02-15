return {
  "mikavilpas/yazi.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {"<leader>z", "<cmd>Yazi<cr>", desc = "Open Yazi file manager", mode = { "n", "v" }},
    {
      "<leader>C",
      function()
        require("yazi").yazi(nil, vim.fn.stdpath("config"))
      end,
      desc = "Open Neovim config",
      mode = "n",
    },
  },
  opts = {
    integrations = {
      grep_in_directory = "fzf-lua",
      grep_in_selected_files = "fzf-lua",
    },
  },
}
