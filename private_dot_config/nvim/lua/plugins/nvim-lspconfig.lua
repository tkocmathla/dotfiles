local locals = require("config.locals")

-- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
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
    require("lspconfig").gopls.setup{ cmd = {"gopls"} }
    require("lspconfig").clangd.setup{
      cmd = {
        "clangd",
        "-j", "8",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        -- Clangd queries the compiler for its system include paths, but only if
        -- the compiler executable is explicitly named--using a fully-qualified
        -- path--in this option.
        "--query-driver=" .. locals.repo_root .. "/external/toolchains_llvm~~llvm~llvm_toolchain/bin/cc_wrapper.sh",
      },
    }
  end,
}
