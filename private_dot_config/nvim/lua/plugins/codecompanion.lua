return {
  {
    -- AI Coding, Vim Style
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion actions" },
      { "<leader>ac", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion chat" },
      { "<leader>as", "<cmd>CodeCompanionChat<cr>", mode = "v", desc = "CodeCompanion selection to chat" },
      { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion toggle chat" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        acp = {
          codex = function()
            return require("codecompanion.adapters").extend("codex", {
              defaults = {
                auth_method = "chatgpt",
                session_config_options = { model = "gpt-5.4" },
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = { name = "codex", model = "gpt-5.4" },
        },
      },
      rules = {
        opts = {
          chat = {
            enabled = true,
            autoload = function()
              return {}
            end,
          },
        },
      },
      display = {
        chat = {
          window = {
            layout = "vertical",
            position = "right",
            width = 0.40,
            full_height = true,
          },
          show_header_separator = false,
          separator = "─",
        },
      },
    },
  },
}
