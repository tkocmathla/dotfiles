local locals = require("config.locals")

-- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable inlay hints.
        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })

        -- Enable completion triggered by <c-x><c-o>.
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, opts)
    end,
})

return {
  "neovim/nvim-lspconfig",
  config = function()
    local util = require("lspconfig.util")

    vim.lsp.config("gopls", { cmd = { "gopls" } })
    vim.lsp.enable("gopls")

    vim.lsp.config("pylsp", {
      settings = {
        pylsp = {
          plugins = {
            -- Prefer black over yapf or pycodestyle lints.
            black = { enabled = true },
            yapf = { enabled = false },
            pycodestyle = { enabled = false },
          }
        }
      }
    })
    vim.lsp.enable("pylsp")

    -- Global clangd settings are in ~/.config/clangd/config.yaml.
    vim.lsp.config("clangd", {
      cmd = {
        locals.clangd_cmd,
        "-j", "4",
        "--log=info",
        "--compile-commands-dir=" .. locals.repo_root,
        "--completion-style=detailed",
        "--background-index",
        "--query-driver=" .. locals.clangd_query_driver,
      },
    })
    vim.lsp.enable("clangd")
  end,
}
