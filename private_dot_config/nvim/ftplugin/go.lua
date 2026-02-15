local opt = vim.opt_local

opt.listchars:append({ tab = "  " })

vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = 0,
  callback = function()
    require("go.format").gofmt()
  end,
})
