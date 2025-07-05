return {
    "lervag/vimtex",
    lazy = false,
    init = function()
        vim.g.vimtex_view_method = 'zathura'
    end,
    keys = {
        "<leader>lv", "<cmd>VimtexView<cr>", desc = "Vimtex View"
    }
}
