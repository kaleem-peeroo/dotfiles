-- Terminal and Title Settings
vim.opt.title = true
vim.opt.titlestring = '%t'

-- Indentation and Formatting Settings
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.tabstop = 4
-- vim.opt.iskeyword = '_'

-- Display Settings
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.mouse = 'a'
vim.opt.showcmd = true
vim.opt.timeoutlen = 300
vim.opt.wildmenu = true
vim.opt.wrap = true
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.updatetime = 50
vim.opt.scrolloff = 1
vim.opt.signcolumn = 'yes'
vim.opt.statuscolumn = ""
vim.opt.statusline = ""
vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.colorcolumn = '0'
vim.opt.laststatus = 0

-- List and Match Settings
vim.opt.list = true
vim.opt.listchars = { tab = '  ', leadmultispace = '│   ' }
vim.opt.showmatch = true

-- GUI and Encoding Settings
vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.encoding = 'utf-8'

-- Search and Case Settings
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.smartindent = true

-- Line Number Settings
vim.opt.number = true
vim.opt.relativenumber = true

-- nvim-tree options
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- folding options
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- concel level for obsidian
vim.opt.conceallevel = 2

-- Highlight yanked text for 150ms
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end
})

vim.g.python3_host_prog = vim.fn.expand("~/venv/bin/python3")

vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
        ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
        ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
}
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
