return {
    "lervag/vimtex",
    lazy = false,
    init = function()
        vim.g.vimtex_view_method = 'zathura'
    end,
    keys = {
        {
            "<leader>vc",
            "<cmd>VimtexCompileSS<cr>",
            desc = "Vimtex Compile Single Shot"
        },
        {
            "<leader>vt",
            "<cmd>VimtexTocToggle<cr>",
            desc = "Vimtex Toggle TOC",
        }
    }
}
