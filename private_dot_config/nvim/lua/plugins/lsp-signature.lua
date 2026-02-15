return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = function()
    require("lsp_signature").on_attach({
      bind = true,
      floating_window = true,
      handler_opts = {
        border = "rounded",
      },
      hint_prefix = {
        above = "↙ ",
        current = "← ",
        below = "↖ "
      },
      transparency = 10,
    })
    vim.keymap.set("n", "K", function()
      require("lsp_signature").toggle_float_win()
    end, { noremap = true, silent = true, desc = "LSP signature help" })
  end,
}
