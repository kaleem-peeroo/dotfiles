return {
    "lervag/vimtex",
    lazy = false,
    init = function()
        vim.g.vimtex_view_method = 'zathura'
    end,
    keys = {
        "<leader>v", "<cmd>VimtexView<cr>", desc = "Vimtex View"
    }
}
