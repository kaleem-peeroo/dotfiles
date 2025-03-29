return {
    'stevearc/oil.nvim',
    config = function()
        -- vim.keymap.sets
        vim.keymap.set('n', '<leader>o', ':Oil<CR>')
        require('oil').setup({
            default_file_explorer = true,
            use_default_keymaps = false,
            keymaps = {
                ['<C-s>'] = ':w<CR>',
                ['g?'] = { 'actions.show_help', mode="n" },
                ['<CR>'] = "actions.select",
                ['<C-l>'] = false,
                ['<C-h>'] = false,
                ['fy'] = {
                    desc = "Copy filepath to system clipboard",
                    callback = function()
                        require('oil.actions').copy_entry_path.callback()
                        vim.fn.setreg('+', vim.fn.getreg(vim.v.register))
                    end,
                }
            },
            view_options = { show_hidden = true },
            skip_confirm_for_simple_edits = true
        })
    end
}
