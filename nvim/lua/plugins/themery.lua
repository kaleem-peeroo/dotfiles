return {
    'zaldih/themery.nvim',
    config = function()
    vim.keymap.set('n', '<leader>ct', ':Themery<CR>')
    require('themery').setup({
        themes = {
            { name = "Nightfox",  colorscheme = "Nightfox" },
            { name = "Dayfox", colorscheme = "Dayfox" },
            { name = "Dawnfox", colorscheme = "Dawnfox" },
            { name = "Duskfox", colorscheme = "Duskfox" },
            { name = "Nordfox", colorscheme = "Nordfox" },
            { name = "Terafox", colorscheme = "Terafox" },
            { name = "Carbonfox", colorscheme = "Carbonfox" },

            { name = "Rose Pine Main", colorscheme = "rose-pine-main" },
            { name = "Rose Pine Moon", colorscheme = "rose-pine-moon" },
            { name = "Rose Pine Dawn", colorscheme = "rose-pine-dawn" },

            { name = "Tokyo Night", colorscheme = "tokyonight-night" },
            { name = "Tokyo Night Storm", colorscheme = "tokyonight-storm" },
            { name = "Tokyo Night Day", colorscheme = "tokyonight-day" },
            { name = "Tokyo Night Moon", colorscheme = "tokyonight-moon" },
        }
    })
    end
}
