-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local wk = require("which-key")

-- Nvim
vim.keymap.set("n", "<leader>C", ":NvimTreeOpen ~/.config/nvim/lua<cr>", { desc = "Jump to config" })
vim.keymap.set("n", "<leader>H", ":noh<cr>", { desc = "Clear highlights" })

-- NvimTree
vim.keymap.set("n", "<leader>E", ":NvimTreeToggle<cr>", { desc = "File explorer (at root)" })
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle %<cr>", { desc = "File explorer (at file)" })

-- Nvim DAP
wk.register({
    d = {
        name = "+dap",
        b = { function() require("dap").toggle_breakpoint() end, "Toggle breakpoint" },
        c = { function() require("dap").continue() end, "Continue" },
        n = { function() require("dap").step_over() end, "Step over" },
        i = { function() require("dap").step_into() end, "Step into" },
        o = { function() require("dap").step_out() end, "Step out" },
        t = { function() require("dap").terminate() end, "Terminate session" },
        w = { function() require("dapui").toggle() end, "Toggle UI" },
    }
}, { prefix = "<leader>" })

wk.register({
    ["<F5>"] = { function() require("dap").continue() end, "Continue" },
    ["<F6>"] = { function() require("dap").step_over() end, "Step over" },
    ["<F7>"] = { function() require("dap").step_into() end, "Step into" },
    ["<F8>"] = { function() require("dap").step_out() end, "Step out" },
})

-- Git
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<cr>")
vim.keymap.set("n", "<leader>gs", ":G<cr>", { desc = "Git status" }, { remap = true })
vim.keymap.set("n", "<leader>gd", ":Gdiff<cr>", { desc = "Git diff" })
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

-- fetch and merge main
vim.keymap.set(
    "n",
    "<leader>gZ",
    ":G fetch origin main <bar>:G merge origin/main<cr>",
    { desc = "Git fetch and merge main" }
)

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
    -- FIXME make github URL configurable
    local url = "https://github/"
        .. vim.fn.expand("%:.")
        .. "#L"
        .. vim.fn.line(".")
    vim.fn.setreg("+", url)
    vim.cmd.echo('"' .. url .. '"')
end, { desc = "Yank GitHub URL to clipboard (main)" })

-- yank a shareable github permalink url for the current file + line to clipboard register
vim.keymap.set("n", "<leader>gU", function()
    -- FIXME make github URL configurable
    local url = "https://github/"
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
