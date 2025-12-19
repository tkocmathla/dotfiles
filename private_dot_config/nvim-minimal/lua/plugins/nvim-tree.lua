return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>C", "<cmd>NvimTreeOpen ~/.config/nvim/lua<cr>", desc = "Jump to config" },
    { "<leader>E", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
    { "<leader>e", "<cmd>NvimTreeFindFileToggle! %<cr>", desc = "Open file explorer at current file" },
  },
  opts = {},
}
