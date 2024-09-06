-- https://github.com/rcarriga/nvim-dap-ui?tab=readme-ov-file#configuration
return {
    "rcarriga/nvim-dap-ui",
    config = function()
        require("dapui").setup()
    end
}
