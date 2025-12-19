return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader><space>",
      function()
        require("fzf-lua").files({ cwd = vim.loop.cwd() })
      end,
      desc = "Find files (cwd)",
    },
    {
      "<leader>ff",
      function()
        local fzf = require("fzf-lua")
        local ok, git_root = pcall(fzf.path.git_root, { throw = false })
        fzf.files({ cwd = ok and git_root or vim.loop.cwd() })
      end,
      desc = "Find files (repo root or cwd)",
    },
    { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers" },
    { "<leader>fr", function() require("fzf-lua").oldfiles() end, desc = "Recent files" },
    { "<leader>fg", function() require("fzf-lua").live_grep() end, desc = "Live grep" },
    { "<leader>fw", function() require("fzf-lua").grep_cword() end, desc = "Grep word under cursor" },
    {
      "<leader>fW",
      function()
        require("fzf-lua").grep_visual()
      end,
      mode = { "v", "n" },
      desc = "Grep visual selection",
    },
  },
  opts = function()
    local actions = require("fzf-lua.actions")
    return {
      defaults = {
        actions = {
          ["ctrl-x"] = actions.file_split,
        },
      },
    }
  end,
}
