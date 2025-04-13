-- Inverses whatever you're on. e.g. true becomes false, 1 becomes 0, etc.
return {
    "nguyenvukhang/nvim-toggler",
    config = function()
        require("nvim-toggler").setup()
        vim.keymap.set("n", "<leader>s", require('nvim-toggler').toggle)
    end,
}
