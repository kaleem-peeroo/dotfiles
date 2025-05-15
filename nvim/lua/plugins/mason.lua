return {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    opts = {
        ensure_installed = {
            "black",
            "debugpy",
            "mypy"
        },
    },
    config = function(opts)
        require("mason").setup()
    end
}
