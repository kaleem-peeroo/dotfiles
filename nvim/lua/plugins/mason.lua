return {
    "williamboman/mason.nvim",
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
