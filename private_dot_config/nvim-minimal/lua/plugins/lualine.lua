return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        -- "nvim-lua/lsp-status.nvim",
    },
    config = function()
        require("lualine").setup({
            sections = {
                -- git branch and local change summary
                lualine_b = { "branch", "diff" },
                -- show relative file path
                lualine_c = { { "filename", path = 1 } },
                -- hide file encoding and format
                lualine_x = {
                    -- function() return require("lsp-status").status() end,
                    "filetype",
                    "location",
                    "selectioncount",
                },
                -- hide date and time
                lualine_z = {},
            },
        })
    end,
}
