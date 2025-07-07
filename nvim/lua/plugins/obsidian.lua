return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = false,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        workspaces = {
            {
                name = "vault 2.0",
                path = "~/vault 2.0/"
            }
        },
        new_notes_location = "current_dir",
        use_advanced_uri = true,
        ui = {
            checkboxes = {}
        }
    }
}
