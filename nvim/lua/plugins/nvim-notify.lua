return {
    "rcarriga/nvim-notify",
    config = function()
        require("notify").setup({
            top_down = false,
            stages = "static",
            timeout = 3000,
            render = "compact",
        })
    end
}
