return {
  {
    -- Neovim plugin for Github Copilot
    "github/copilot.vim",
    init = function()
      vim.g.copilot_filetypes = {
        codecompanion = false,
      }
    end,
  },
}
