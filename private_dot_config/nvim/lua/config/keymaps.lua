-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local wk = require("which-key")
local locals = require("config.locals")

-- Nvim
vim.keymap.set("n", "<leader>C", ":NvimTreeOpen ~/.config/nvim/lua<cr>", { desc = "Jump to config" })
vim.keymap.set("n", "<leader>H", ":noh<cr>", { desc = "Clear highlights" })
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<leader>yf", ":let @+ = expand('%')<cr>", { desc = "Copy relative path to current file" })
vim.keymap.set("n", "<leader>yF", ":let @+ = expand('%:p')<cr>", { desc = "Copy absolute path to current file" })

-- NvimTree
vim.keymap.set("n", "<leader>E", ":NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle! %<cr>", { desc = "Open file explorer at current file" })

-- Nvim DAP
wk.add({
    { "<leader>d", group = "dap" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>dn", function() require("dap").step_over() end, desc = "Step over" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step out" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate session" },
    { "<leader>dw", function() require("dapui").toggle() end, desc = "Toggle UI" },
})

wk.add({
    {"<F5>", function() require("dap").continue() end, desc = "Continue" },
    {"<F6>", function() require("dap").step_over() end, desc = "Step over" },
    {"<F7>", function() require("dap").step_into() end, desc = "Step into" },
    {"<F8>", function() require("dap").step_out() end, desc = "Step out" },
})

-- Go
wk.add({
    { "<leader>G", group = "go" },
    { "<leader>Gf", ":GoFmt<cr>", { desc = "Go format" }},
    { "<leader>Gr", ":GoRun<cr>", { desc = "Go run" }},
    { "<leader>Gb", ":GoBuild<cr>", { desc = "Go build" }},
})

-- Git
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<cr>")
vim.keymap.set("n", "<leader>gs", ":G<cr>", { desc = "Git status", remap = true })
vim.keymap.set("n", "<leader>gd", ":Gdiff<cr>", { desc = "Git diff" })
vim.keymap.set("n", "<leader>gD",
               function()
                 res = vim.api.nvim_exec2("G merge-base origin/main HEAD", { output = true })
                 vim.cmd("DiffviewOpen " .. res["output"])
               end, { desc = "Git diff branch changes" })
vim.keymap.set("n", "<leader>gm", ":Gvdiffsplit!<cr>", { desc = "Git 3-way merge" })
vim.keymap.set("n", "<leader>gM", ":G mergetool<cr>", { desc = "Git merge-tool" })
vim.keymap.set("n", "<leader>ga", ":G blame<cr>", { desc = "Git blame" })

-- fetch current branch from origin
vim.keymap.set("n", "<leader>gf", ":execute 'G fetch origin ' . FugitiveHead()<cr>", { desc = "Git fetch (branch)" })

-- fetch everything from origin
vim.keymap.set("n", "<leader>gF", ":G fetch<cr>", { desc = "Git fetch (all)" })

-- pull current branch from origin
vim.keymap.set("n", "<leader>gl", ":execute 'G pull origin ' . FugitiveHead()<cr>", { desc = "Git pull (branch)" })

-- pull everything from origin
vim.keymap.set("n", "<leader>gL", ":G pull<cr>", { desc = "Git pull (all)" })

-- push to origin
vim.keymap.set("n", "<leader>gp", ":G push -u origin HEAD<cr>", { desc = "Git push" })

-- commit with hooks
vim.keymap.set("n", "<leader>gc", ":G commit<cr>", { desc = "Git commit" })

-- commit without running hooks
vim.keymap.set("n", "<leader>gC", ":G commit --no-verify<cr>", { desc = "Git commit (skip hooks)" })

-- fetch and rebase on main
vim.keymap.set(
    "n",
    "<leader>gZ",
    ":G fetch origin main <bar>:G rebase origin/main<cr>",
    { desc = "Git fetch and merge main" }
)

-- log of current file
--   - ! means do not automatically jump to the first result
--   - -p means show diffs for each commit
vim.keymap.set("n", "<leader>go", ":Gclog! -- % -p<cr>", { desc = "Git log (current file)" })

-- show stash log
vim.keymap.set("n", "<leader>gSl", ":Telescope git_stash<cr>", { desc = "Git stash list" })

-- push to stash
vim.keymap.set("n", "<leader>gS-", ":Git stash<cr>:e<cr>", { desc = "Git stash push" })

-- pop from stash
vim.keymap.set("n", "<leader>gS+", ":Git stash pop<cr>:e<cr>", { desc = "Git stash pop" })

-- git-grep for word under cursor
--   - ! means do not automatically jump to the first result
--   - --quiet means open results directly in quickfix list
vim.keymap.set(
    "n",
    "<leader>gG",
    function()
        local word = vim.fn.expand("<cword>")
        vim.cmd("Ggrep! --quiet --word-regexp " .. word .. "<cr>")
    end,
    { desc = "Git grep for word" }
)

-- git-grep for visual selection
--   - uses g register (qgq clears it first)
--   - getreg(...)[0] means use only first line of visual selection (as a safeguard)
--   - highlights pattern in results
--   - ! means do not automatically jump to the first result
--   - --quiet means open results directly in quickfix list
--vmap <Leader>gG qgq
--\ "gy <bar>
--\ :execute ':Ggrep! --quiet ' . escape(getreg('g', 1, 1)[0], ' "')<cr>
--\ /<c-r>=getreg('g', 1, 1)[0]<cr><cr>
--\ ^

-- yank a shareable github url for the current file + line to clipboard register
vim.keymap.set("n", "<leader>gu", function()
    local url = locals.github_base_url
        .. vim.fn.expand("%:.")
        .. "#L"
        .. vim.fn.line(".")
    vim.fn.setreg("+", url)
    vim.cmd.echo('"' .. url .. '"')
end, { desc = "Yank GitHub URL to clipboard (main)" })

-- yank a shareable github permalink url for the current file + line to clipboard register
vim.keymap.set("n", "<leader>gU", function()
    local url = locals.github_base_url
        .. vim.fn["fugitive#RevParse"]("HEAD")
        .. "/"
        .. vim.fn.expand("%:.")
        .. "#L"
        .. vim.fn.line(".")
    vim.fn.setreg("+", url)
    vim.cmd.echo('"' .. url .. '"')
end, { desc = "Yank GitHub URL to clipboard (permalink)" })

-- HopWord
vim.keymap.set("n", "<leader>h", ":HopWord<cr>", { desc = "HopWord" })
