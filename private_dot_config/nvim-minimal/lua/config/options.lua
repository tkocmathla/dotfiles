local locals = require("config.locals")
local opt = vim.opt

-- Set default shell to zsh
opt.shell = "zsh"

-- Disable mouse support
opt.mouse = ""
opt.updatetime = 1000

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.numberwidth = 5
opt.cursorline = true

-- Number of spaces that a tab in the file counts for
opt.tabstop = 4
-- Number of spaces to use for each step of indent
opt.shiftwidth = 4
-- Use spaces to insert a tab
opt.expandtab = true
-- Copy indent from current line when starting a new line
opt.autoindent = true
-- Don't insert the current comment leader when inserting a new line (:h fo-table)
opt.formatoptions:remove { "o" }

-- TODO document
opt.completeopt = { "menu", "menuone", "noinsert", "noselect", "popup" }

-- Don't show (partial) command in the last line of the screen
opt.showcmd = false
-- List mode shows visible characters for whitespace, configured by opt.listchars
opt.list = true
opt.listchars = { tab = "» ", nbsp = "␣", trail = "•", extends = "⟩", precedes = "⟨" }
-- Wrap long lines on word boundaries
opt.wrap = true
-- Wrap long lines at any opt.breakat char
opt.linebreak = true

-- Open new vertical splits right of the current window
opt.splitright = true
-- Open new horizontal splits below the current window
opt.splitbelow = true

-- Highlight all search results
opt.hlsearch = true
-- Ignore case in search patterns
opt.ignorecase = true
-- Highlight incremental search matches
opt.incsearch = true
-- Override ignorecase if the search pattern contains uppercase characters
opt.smartcase = true

locals.options()
