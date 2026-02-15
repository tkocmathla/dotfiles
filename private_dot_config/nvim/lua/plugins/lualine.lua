return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("lualine").setup({
            sections = {
                -- git branch and local change summary
                lualine_b = { "branch", "diff" },
                -- show relative file path
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                        symbols = {
                            modified = " ",
                            readonly = " ",
                            unnamed = "󰡯 ",
                            newfile = "󰝒 ",
                        },
                    },
                },
                -- hide file encoding and format
                lualine_x = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        sections = { "error", "warn", "info", "hint" },
                        symbols = {
                          error = " ",
                          warn = " ",
                          info = " ",
                          hint = "󰌵 ",
                        },
                    },
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
