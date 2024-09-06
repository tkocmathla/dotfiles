return {
    "mbbill/undotree",
    config = function(opts)
        vim.keymap.set('n', '<leader><F4>', vim.cmd.UndotreeToggle)
    end
}
