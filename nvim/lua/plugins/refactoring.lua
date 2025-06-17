return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    opts = {},
    keys = {
        {
            "<C-e>",
            ":Refactor extract<CR>",
            desc = "Extract Function",
            mode = { "v" },
        },
    }
}
