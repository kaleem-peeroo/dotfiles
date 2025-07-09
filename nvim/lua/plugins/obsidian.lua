return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = false,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "hrsh7th/nvim-cmp",
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
            enable = false,
            checkboxes = {}
        }
    },
    keys = {
        vim.keymap.set("n", "<C-x>", function()
            local line = vim.api.nvim_get_current_line()
            if line:match("%[ %]") then
                vim.cmd("s/\\[ \\]/[x]/")
            elseif line:match("%[x%]") then
                vim.cmd("s/\\[x\\]/[ ]/")
            end
        end, { desc = "Toggle Markdown checkbox [ ] <-> [x]" })
    }
}
