return {
    -- Formatter. Basically reformats how your code looks when you save the file by e.g. removing extra lines.
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                python = { "black" },
            },
            format_on_save = {
                timeout_ms = 10000,
                lsp_fallback = true,
            },
        })
    end
}
