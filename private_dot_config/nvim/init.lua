-- Set leaders before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.diagnostics")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
