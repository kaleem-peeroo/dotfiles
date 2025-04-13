return {
    "zbirenbaum/neodim",
    event = "LspAttach",
    config = function()
        require("neodim").setup({
            alpha = 0.1
        })
    end
}
