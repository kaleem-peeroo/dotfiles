return {
    "linux-cultist/venv-selector.nvim",
    enabled = true,
    dependencies = {
        "neovim/nvim-lspconfig",
        { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    lazy = false,
    ---@type venv-selector.Config
    opts = {
        auto_refresh = true,
        search_workspace = false,
        search = {
            my_venvs = {
                command = "fd python$ ~/venv/"
            }
        }
    },
    keys = {
        { "<leader>vs", ":VenvSelect<CR>", desc = "Select Python Virtual Environment" },
    },
}
