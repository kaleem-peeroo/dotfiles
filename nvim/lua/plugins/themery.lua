return {
    'zaldih/themery.nvim',
    config = function()
    vim.keymap.set('n', '<leader>ct', ':Themery<CR>')
    require('themery').setup({
        themes = {
            { name = "Kanagawa", colorscheme = "kanagawa" },
            { name = "OneDark", colorscheme = "onedark" },
            { name = "vscode", colorscheme = "vscode" },
            { name = "Material", colorscheme = "material" },
            { name = "Nord", colorscheme = "nord" },
            { name = "Tokyo Dark", colorscheme = "tokyodark" },
            { name = "Moonfly", colorscheme = "moonfly" },

            { name = "github_dark", colorscheme = "github_dark" },
            { name = "github_dark_default", colorscheme = "github_dark_default" },
            { name = "github_dark_colorblind", colorscheme = "github_dark_colorblind" },
            { name = "github_dark_dimmed", colorscheme = "github_dark_dimmed" },
            { name = "github_dark_high_contrast", colorscheme = "github_dark_high_contrast" },

            { name = "github_light", colorscheme = "github_light" },
            { name = "github_light_default", colorscheme = "github_light_default" },
            { name = "github_light_high_contrast", colorscheme = "github_light_high_contrast" },

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
