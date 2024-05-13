local remap = vim.keymap.set

vim.g.mapleader = " " 

-- remap("n", "<leader>e", vim.cmd.Ex)
remap("n", "<C-s>", ":w<CR>")
remap("i", "<C-s>", "<Esc>:w<CR>")
remap("v", "<C-s>", "<Esc>:w<CR>")

-- split window vertically or horizontally
remap('n', '<leader>-', '<Cmd>vsplit<CR>')
remap('n', '<leader>|', '<Cmd>split<CR>')

-- move between splits using hjkl
remap('n', '<leader>h', '<Cmd>wincmd h<CR>')
remap('n', '<leader>j', '<Cmd>wincmd j<CR>')
remap('n', '<leader>k', '<Cmd>wincmd k<CR>')
remap('n', '<leader>l', '<Cmd>wincmd l<CR>')

remap('n', 'n', 'nzz')
remap('n', 'N', 'Nzz')

remap('n', 'x', '"_x')
remap('v', 'x', '"_x')

-- format pasted line
remap('n', 'p', 'p==')

-- resize splits
remap('n', '<S-Left>', '<Cmd>vertical resize -2<CR>')
remap('n', '<S-Right>', '<Cmd>vertical resize +2<CR>')
remap('n', '<S-Up>', '<Cmd>resize -2<CR>')
remap('n', '<S-Down>', '<Cmd>resize +2<CR>')

-- indent/unindent selected text
remap('v', '>', '>gv')
remap('v', '<', '<gv')

-- navigate buffers (tabs)
remap('n', 'L', '<Cmd>bnext<CR>')
remap('n', 'K', '<Cmd>bprevious<CR>')

-- close this buffer (tab)
remap('n', '<leader>q', '<Cmd>bd<CR>')
