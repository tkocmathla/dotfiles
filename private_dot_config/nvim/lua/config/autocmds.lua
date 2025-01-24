-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local locals = require("config.locals")

-- MLIR: Set filetype based on extension
vim.filetype.add({
  extension = {
    mlir = 'mlir',
  },
})

-- MLIR: Map TableGen'erated C++ files to the cpp file type
vim.filetype.add({
  pattern = {
    ['.*[.]h[.]inc'] = 'cpp',
    ['.*[.]cpp[.]inc'] = 'cpp',
  },
})

-- C++: Format code on save
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.cpp',
    callback = function()
        vim.lsp.buf.format()
    end,
})

-- Python: Format code on save
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.py',
    callback = function()
        vim.lsp.buf.format()
    end,
})

-- Go: Don't show visible tabs
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.go',
    callback = function()
        vim.opt.listchars:append({ tab = "  " })
    end,
})

-- Go: Format code and imports on save
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.go',
    callback = function()
       require('go.format').gofmt()
    end,
})

locals.autocmds()
