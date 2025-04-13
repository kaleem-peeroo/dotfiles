return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            options = {
                icons_enabled = true,
                theme = 'auto',
            },
            -- this part shows full path, helps navigate in Oil.
            tabline = {
                lualine_a = { 'branch' },
                lualine_b = { { 'filename', path = 1 } },
            },
            sections = {},
            inactive_sections = {}
        })
    end
}
