return {
    'github/copilot.vim',
    enabled = false,
    config = function()
        require('copilot').setup({})
    end
}
