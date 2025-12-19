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

-- C++: Show vertical bar for line wrap
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.cpp',
    callback = function()
        vim.opt.colorcolumn = "100"
    end,
})

-- Python: Show vertical bar for line wrap
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.py',
    callback = function()
        vim.opt.colorcolumn = "90"
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
