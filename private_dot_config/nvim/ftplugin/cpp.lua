local opt = vim.opt_local

opt.shiftwidth = 2
opt.tabstop = 2

vim.b.colorcolumn = "100"

vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = 0,
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
