return {
    'echasnovski/mini.animate',
    lazy = false,
    version = '*',
    config = function()
    require('mini.animate').setup({
        cursor = {
            enable = true,
            timing = function(_, n) return 100 / n end,
        },
        scroll = {
            enable = false,
            timing = function(_, n) return 100 / n end,
        }
    })
    end
}
