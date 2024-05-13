return {
  'terrortylor/nvim-comment',
  config = function()
    vim.keymap.set('n', "'", ':CommentToggle<CR>')
    vim.keymap.set('v', "'", ':CommentToggle<CR>')
    require('nvim_comment').setup()
  end
}
