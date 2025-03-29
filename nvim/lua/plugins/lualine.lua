return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        vim.o.showmode = false
        require('lualine').setup({
            options = {
                icons_enabled = true,
                -- theme = 'dracula',
            },
            -- this part shows full path, helps navigate in Oil.
            sections = {
                lualine_c = { { 'filename', path = 2 } }
            }
        })
    end
}
