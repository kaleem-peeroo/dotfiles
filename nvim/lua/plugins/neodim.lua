return {
    -- dims out unused functions, variables, parameters, etc
    "zbirenbaum/neodim",
    event = "LspAttach",
    config = function()
        require("neodim").setup({
            alpha = 0.5
        })
    end
}
