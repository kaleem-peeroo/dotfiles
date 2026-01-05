return {
    "scottmckendry/cyberdream.nvim",
    config = function()
        require("cyberdream").setup({
            transparent = true
        })
    end,
    lazy = false,
    priority = 1000,

}
