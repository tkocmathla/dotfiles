-- Move line up/down
vim.keymap.set("n", "<A-j>", ":m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<cr>==", { desc = "Move line up" })

-- Move selection up/down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Window navigation with ctrl-[hjkl]
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to window right" })

-- Nvim
vim.keymap.set("n", "<leader>H", ":noh<cr>", { desc = "Clear highlights" })
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<leader>yf", ":let @+ = expand('%')<cr>", { desc = "Copy relative path to current file" })
vim.keymap.set("n", "<leader>yF", ":let @+ = expand('%:p')<cr>", { desc = "Copy absolute path to current file" })
