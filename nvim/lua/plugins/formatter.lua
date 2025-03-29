return {
    "mhartington/formatter.nvim",
    config = function()
        require("formatter").setup({
            filetype = {
                json = {
                    function()
                        return {
                            exe = "js-beautify",
                            stdin = true,
                            try_node_modules = true
                        }
                    end
                },
                ["*"] = {
                    require("formatter.filetypes.any").remove_trailing_whitespace,
                }
            }
        })
    end
}
