return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader><leader>', builtin.find_files)
    vim.keymap.set('n', '<leader>fb', builtin.buffers)
    vim.keymap.set('n', '<leader>fg', builtin.live_grep)

    require('telescope').setup {
      defaults = {
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.5,
            results_width = 0.5,
            height = 0.8,
            preview_cutoff = 120,
          }
        },
      },
    }
  end
}
