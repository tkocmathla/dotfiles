-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Map TableGen'erated files to the MLIR file type
vim.filetype.add({
  extension = {
    mlir = 'mlir',
  },
  pattern = {
    ['.*[.]h[.]inc'] = 'cpp',
    ['.*[.]cpp[.]inc'] = 'cpp',
  },
})
