return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
