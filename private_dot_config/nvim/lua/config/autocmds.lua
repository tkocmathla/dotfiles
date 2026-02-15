local locals = require("config.locals")

local aug = vim.api.nvim_create_augroup("config_autocmds", { clear = true })

-- Don't continue comments on new lines
vim.api.nvim_create_autocmd("FileType", {
  group = aug,
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "o" })
  end,
})

-- Filetype detection for MLIR and generated C++
vim.filetype.add({
  extension = {
    mlir = "mlir",
  },
  pattern = {
    [".*[.]h[.]inc"] = "cpp",
    [".*[.]cpp[.]inc"] = "cpp",
  },
})

-- Reapply buffer-defined colorcolumn preferences (set in ftplugin/*)
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  group = aug,
  callback = function()
    vim.opt_local.colorcolumn = vim.b.colorcolumn or ""
  end,
})

locals.autocmds()
