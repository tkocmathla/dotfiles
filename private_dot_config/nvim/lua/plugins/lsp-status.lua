return {
    "nvim-lua/lsp-status.nvim",
    config = function()
        local lsp_status = require('lsp-status')
        lsp_status.register_progress()

        require('lspconfig').clangd.setup({
            handlers = lsp_status.extensions.clangd.setup(),
            --init_options = {
            --clangdFileStatus = true
            --},
            on_attach = lsp_status.on_attach,
            capabilities = lsp_status.capabilities
        })
    end
}
