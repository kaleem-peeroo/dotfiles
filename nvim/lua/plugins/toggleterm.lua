return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require('toggleterm').setup {
            direction = 'float',
            shade_filetypes = false,
            float_opts = {
            border = 'double'
        }
    }
    vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>')
    vim.keymap.set('n', '<leader>lg', ':TermExec cmd="lazygit"<CR>')
    vim.keymap.set('n', '<leader>vd', ':TermExec cmd="vd . "<CR>')
    end
}
