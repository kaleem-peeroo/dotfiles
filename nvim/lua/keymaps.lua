vim.g.mapleader = ' '  -- Setting the leader key
local remap = vim.keymap.set

-- Exit insert mode with jj
remap('i', 'jj', '<Esc>')
-- QOL:
-- Search centering
remap('n', 'n', 'nzz')
remap('n', 'N', 'Nzz')
-- Remove search highlighting
remap('i', '<Esc>', '<Esc>:noh<CR>')
remap('n', '<Esc>', '<Esc>:noh<CR>')
-- Deleting to the void
remap('n', 'x', '"_x')
remap('v', 'x', '"_x')
-- Format pasted line
remap('n', 'p', 'p==')

-- Page movement up/down
remap('n', '<C-k>', '<S-Up>zz')
remap('n', '<C-j>', '<S-Down>zz')
remap('v', '<C-k>', '<S-Up>zz')
remap('v', '<C-j>', '<S-Down>zz')

-- Save file
local function silent_format()
    if vim.lsp.buf.server_ready() then
        vim.lsp.buf.format({async = true})
    end
end
remap('n', '<C-s>', ':silent w<CR>')
remap('i', '<C-s>', '<Esc>:silent w<CR>')
remap('v', '<C-s>', '<Esc>:silent w<CR>')

-- Move selected lines with alt arrows
remap('v', '<A-k>', ":m '<-2<CR>gv=gv")
remap('v', '<A-j>', ":m '>+1<CR>gv=gv")
remap('n', '<A-k>', ':m .-2<cr>==')
remap('n', '<A-j>', ':m .+1<cr>==')

-- Vertical split
remap('n', '<leader>|', '<Cmd>vsplit<CR>')

-- Horizontal split
remap('n', '<leader>-', '<Cmd>split<CR>')

-- Close split
remap('n', '<leader>wq', '<Cmd>close<CR>')

-- -- Move in splits with hjkl
-- remap('n', '<leader>h', '<Cmd>wincmd h<CR>')
-- remap('n', '<leader>j', '<Cmd>wincmd j<CR>')
-- remap('n', '<leader>k', '<Cmd>wincmd k<CR>')
-- remap('n', '<leader>l', '<Cmd>wincmd l<CR>')
-- remap('t', '<leader>h', '<Cmd>wincmd h<CR>')
-- remap('t', '<leader>j', '<Cmd>wincmd j<CR>')
-- remap('t', '<leader>k', '<Cmd>wincmd k<CR>')
-- remap('t', '<leader>l', '<Cmd>wincmd l<CR>')

-- Resize splits
remap('n', 'H', '<Cmd>vertical resize +5<CR>')
remap('n', 'L', '<Cmd>vertical resize -5<CR>')
remap('n', 'K', '<Cmd>resize -5<CR>')
remap('n', 'J', '<Cmd>resize +5<CR>')

-- Indent/Unindent selected text with Tab and Shift+Tab
remap('v', '>', '>gv')
remap('v', '<', '<gv')
-- Remove search HL
remap('n', '<leader>nh', '<Cmd>nohlsearch<CR>')
-- New buffer
remap('n', '<leader>t', ':enew<CR>')
-- Next buffer
remap('n', '<leader>l', '<Cmd>bnext<CR>')
-- Previous buffer
remap('n', '<leader>h', '<Cmd>bprevious<CR>')
-- Quit current buffer
remap('n', '<leader>q', '<Cmd>bd<CR>')

-- Glow: View markdown
remap('n', '<leader>g', ':Glow<CR>')
--
-- My own version of gr (go to references)
function _G.yank_and_search()
  vim.cmd('normal! yiw')
  local yanked_word = vim.fn.getreg('"')
  vim.cmd(':/' .. yanked_word)
end
vim.api.nvim_set_keymap('n', 'gr', '<Cmd>lua yank_and_search()<CR>', { noremap = true, silent = true })

-- Force comments for latex because no one does it for some reason...
vim.api.nvim_set_keymap('n', '<leader>c', 'I% <Esc>', { noremap = true, silent = true })

-- CopilotChat
vim.keymap.set('n', "<leader>cc", ':CopilotChatToggle<CR>')
