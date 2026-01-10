return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        -- vim.keymap.sets
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader><leader>', builtin.find_files)
        vim.keymap.set('n', '<leader>fg', builtin.live_grep)
        vim.keymap.set('n', '<leader>fb', builtin.buffers)
        vim.keymap.set('n', '<leader>fh', builtin.help_tags)
        vim.keymap.set('n', '<leader>fm', builtin.marks)
        vim.keymap.set('n', 'gd', builtin.lsp_definitions)
        vim.keymap.set('n', 'gr', builtin.lsp_references)
        vim.keymap.set('n', '<leader>cp', builtin.colorscheme)
        vim.keymap.set('n', '<leader>f', builtin.lsp_document_symbols)

        require('telescope').setup {
            defaults = {
                sorting_strategy = 'ascending',
                layout_strategy = 'vertical',
                layout_config = {
                    horizontal = {
                        prompt_position = 'top',
                        preview_width = 0.5,
                        results_width = 0.5,
                        height = 0.8,
                        preview_cutoff = 120,
                    },
                    vertical = {
                        mirror = false,
                        height = 0.9,
                        width = 0.8,
                        preview_height = 0.6,
                    },
                },
            },
            pickers = {
                colorscheme = {
                    enable_preview = true,
                },
            }
        }
    end
}
