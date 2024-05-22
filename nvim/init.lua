-- Error theme:
vim.cmd('colorscheme habamax')
--0=========================================================================0
-- █▀ █▀▀ ▀█▀ ▀█▀ █ █▄░█ █▀▀ █▀
-- ▄█ ██▄ ░█░ ░█░ █ █░▀█ █▄█ ▄█
--0=========================================================================0

-- Global Settings
vim.g.mapleader = ' '  -- Setting the leader key

-- Keymap Variables
local remap = vim.keymap.set

-- Terminal and Title Settings
vim.opt.title = true
vim.opt.titlestring = '%t'

-- Indentation and Formatting Settings
vim.opt.autoindent = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.tabstop = 2
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

--0=========================================================================0
-- █▀█ █▀▀ █▀▄▀█ ▄▀█ █▀█ █▀
-- █▀▄ ██▄ █░▀░█ █▀█ █▀▀ ▄█
--0=========================================================================0
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
remap('n', '<C-s>', ':w<CR>')
remap('i', '<C-s>', '<Esc>:w<CR>')
remap('v', '<C-s>', '<Esc>:w<CR>')
-- Move selected lines with alt arrows
remap('v', '<A-k>', ":m '<-2<CR>gv=gv")
remap('v', '<A-j>', ":m '>+1<CR>gv=gv")
remap('n', '<A-k>', ':m .-2<cr>==')
remap('n', '<A-j>', ':m .+1<cr>==')
-- Vertical split
remap('n', '<leader>|', '<Cmd>vsplit<CR>')
-- Horizontal split
remap('n', '<leader>-', '<Cmd>split<CR>')
-- Move in splits with hjkl
remap('n', '<leader>h', '<Cmd>wincmd h<CR>')
remap('n', '<leader>j', '<Cmd>wincmd j<CR>')
remap('n', '<leader>k', '<Cmd>wincmd k<CR>')
remap('n', '<leader>l', '<Cmd>wincmd l<CR>')
remap('t', '<leader>h', '<Cmd>wincmd h<CR>')
remap('t', '<leader>j', '<Cmd>wincmd j<CR>')
remap('t', '<leader>k', '<Cmd>wincmd k<CR>')
remap('t', '<leader>l', '<Cmd>wincmd l<CR>')
-- Resize splits
remap('n', '<S-Left>', '<Cmd>vertical resize +2<CR>')
remap('n', '<S-Right>', '<Cmd>vertical resize -2<CR>')
remap('n', '<S-Up>', '<Cmd>resize -2<CR>')
remap('n', '<S-Down>', '<Cmd>resize +2<CR>')
-- Indent/Unindent selected text with Tab and Shift+Tab
remap('v', '>', '>gv')
remap('v', '<', '<gv')
-- Remove search HL
remap('n', '<leader>nh', '<Cmd>nohlsearch<CR>')
-- New buffer
remap('n', '<leader>t', ':enew<CR>')
-- Next buffer
remap('n', 'L', '<Cmd>bnext<CR>')
-- Previous buffer
remap('n', 'H', '<Cmd>bprevious<CR>')
-- Quit current buffer
remap('n', '<leader>q', '<Cmd>bd<CR>')

-- Glow: View markdown
remap('n', '<leader>g', ':Glow<CR>')

-- My own version of gr (go to references)
function _G.yank_and_search()
  vim.cmd('normal! yiw')
  local yanked_word = vim.fn.getreg('"')
  vim.cmd(':/' .. yanked_word)
end

vim.api.nvim_set_keymap('n', 'gr', '<Cmd>lua yank_and_search()<CR>', { noremap = true, silent = true })


--0=========================================================================0
-- █░░ ▄▀█ ▀█ █▄█
-- █▄▄ █▀█ █▄ ░█░
--0=========================================================================0
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim' -- Lazy bootstrap starts here
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)                                -- Ends here, this should be left alone.
--0=========================================================================0
-- █▀█ █░░ █░█ █▀▀ █ █▄░█ █▀   █▀ ▀█▀ ▄▀█ █▀█ ▀█▀   █░█ █▀▀ █▀█ █▀▀
-- █▀▀ █▄▄ █▄█ █▄█ █ █░▀█ ▄█   ▄█ ░█░ █▀█ █▀▄ ░█░   █▀█ ██▄ █▀▄ ██▄
--0=========================================================================0
require("lazy").setup({
    {
        'leet0rz/modified-moonlight.nvim', -- this is the theme
        config = function()
            vim.cmd('colorscheme moonlight') -- this applies the theme
        end
    },
    {
        'windwp/nvim-autopairs',
        config = function()
            require("nvim-autopairs").setup()
        end
    },
    {
        'terrortylor/nvim-comment',
        config = function()
            -- remaps
            remap('n', "'", ':CommentToggle<CR>')
            remap('v', "'", ':CommentToggle<CR>')
            require('nvim_comment').setup()
        end

    },
    --0=============================================================================================0
    -- ▀█▀ █▀▀ █░░ █▀▀ █▀ █▀▀ █▀█ █▀█ █▀▀
    -- ░█░ ██▄ █▄▄ ██▄ ▄█ █▄▄ █▄█ █▀▀ ██▄
    --0=============================================================================================0
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            -- remaps
            local builtin = require('telescope.builtin')
            remap('n', '<leader><leader>', builtin.find_files)
            remap('n', '<leader>fg', builtin.live_grep)
            remap('n', '<leader>fb', builtin.buffers)
            remap('n', '<leader>fh', builtin.help_tags)
            -- telescope's setup
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
    },
    --0=============================================================================================0
    -- █▀█ █ █░░
    -- █▄█ █ █▄▄
    --0=============================================================================================0
    {
        'stevearc/oil.nvim',
        config = function()
            -- remaps
            remap('n', '<leader>o', ':Oil<CR>')
            require('oil').setup({
                default_file_explorer = true,
                keymaps = {
                    ['<C-s>'] = ':w<CR>',
                },
                view_options = { show_hidden = true },
            })
        end
    },
    --0=============================================================================================0
    -- █▄▄ █░█ █▀▀ █▀▀ █▀▀ █▀█ █░░ █ █▄░█ █▀▀
    -- █▄█ █▄█ █▀░ █▀░ ██▄ █▀▄ █▄▄ █ █░▀█ ██▄    
    --0=============================================================================================0
    {
        "akinsho/bufferline.nvim",
        version = "*",
        config = function()
            require("bufferline").setup()
        end
    },
    --0=============================================================================================0
    -- ▀█▀ █▀█ █▀▀ █▀▀ █▀ █░█ █ ▀█▀ ▀█▀ █▀▀ █▀█
    -- ░█░ █▀▄ ██▄ ██▄ ▄█ █▀█ █ ░█░ ░█░ ██▄ █▀▄
    --0=============================================================================================0
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function()
            -- ENABLES THIS IF USING WINDOWS:
            -- require('nvim-treesitter.install').compilers = { 'zig' } 
            require('nvim-treesitter.configs').setup {
                ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query' },
                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,
                -- Automatically install missing parsers when entering buffer
                auto_install = false,
                highlight = {
                    enable = true,
                },
            }
        end
    },
    --0=============================================================================================0
    -- █░░ █░█ ▄▀█ █░░ █ █▄░█ █▀▀
    -- █▄▄ █▄█ █▀█ █▄▄ █ █░▀█ ██▄
    --0=============================================================================================0
    {
    'nvim-lualine/lualine.nvim',
    config = function()
        vim.o.showmode = false
        require('lualine').setup({
            options = {
                icons_enabled = true,
                -- theme = 'dracula',
            },
            -- this part shows full path, helps navigate in Oil.
            sections = {
                lualine_c = { { 'filename', path = 2 } }
            }
        })
    end
    },
    --0=============================================================================================0
    -- █░░ █▀ █▀█
    -- █▄▄ ▄█ █▀▀
    --0=============================================================================================0
    {
        'neovim/nvim-lspconfig',
        config = function()
            local lspconfig = require('lspconfig')
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
            local custom_attach = function(client, bufnr)
                print('Lsp Attached.')
            end
            require'lspconfig'.pyright.setup{}
            --0=============================================================================================0
            -- █░░ █░█ ▄▀█ ▄▄ █░░ ▄▀█ █▄░█ █▀▀ █░█ ▄▀█ █▀▀ █▀▀ ▄▄ █▀ █▀▀ █▀█ █░█ █▀▀ █▀█
            -- █▄▄ █▄█ █▀█ ░░ █▄▄ █▀█ █░▀█ █▄█ █▄█ █▀█ █▄█ ██▄ ░░ ▄█ ██▄ █▀▄ ▀▄▀ ██▄ █▀▄
            --0=============================================================================================0
            lspconfig.lua_ls.setup ({
                on_attach = custom_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            enable = true,
                            -- enable = false,
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                              vim.env.VIMRUNTIME,
                            },
                        },
                        telemetry = { enable = false },
                    },
                },
            })
            -- new server goes here:
            -- lspconfig.SERVER.setup({
            --    on_attach = custom_attach,
            --    capabilities = capabilities
            --    COPY PASTE SERVER SETTINGS HERE
            --})
        end
    },
    --0=============================================================================================0
    -- █▀▀ █▀▄▀█ █▀█
    -- █▄▄ █░▀░█ █▀▀
    --0=============================================================================================0
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
            -- Other:
            'hrsh7th/cmp-path',
        },
        config = function()
            local cmp = require('cmp')
            local cmp_ap = require('nvim-autopairs.completion.cmp')
            local luasnip = require('luasnip')
            luasnip.config.setup {}
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered()
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                }),
            })
            -- bracket completion for lua
            cmp.event:on(
                'confirm_done',
                cmp_ap.on_confirm_done()
            )
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            remap('n', '<leader>e', ':NvimTreeToggle<CR>')
            require("nvim-tree").setup {}
        end
    },
    {
        'ellisonleao/glow.nvim',
        config = function ()
            require('glow').setup()
        end
    },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = {
            "kevinhwang91/promise-async",
        },
        config = function()
            require('ufo').setup()
        end
    },
    -- {
    --     'gaoDean/autolist.nvim',
    --     ft = {
    --         "markdown",
    --         'text',
    --         'text',
    --         'plaintext',
    --         'norg'
    --     },
    --     config = function ()
    --         require('autolist').setup()
    --         -- vim.keymap.set('i', '<tab>', '<cmd>AutolistTab<CR>')
    --         -- vim.keymap.set('i', '<s-tab>', '<cmd>AutolistShiftTab<CR>')
    --         vim.keymap.set('i', '<CR>', '<CR><cmd>AutolistNewBullet<CR>')
    --         vim.keymap.set('n', 'o', 'o<cmd>AutolistNewBullet<CR>')
    --         vim.keymap.set('n', 'O', 'O<cmd>AutolistNewBulletBefore<CR>')
    --     end
    -- },
    {
        'smjonas/inc-rename.nvim',
        config = function()
            require('inc_rename').setup()
            vim.keymap.set('n', '<leader>rn', ':IncRename ')
        end,
    },
    {
      'github/copilot.vim',
      opts = {},
      config = function()
        require('copilot').setup({})
      end
    },
    {
      'zbirenbaum/copilot.lua',
      cmd = 'Copilot',
      event = 'InsertEnter',
    },
    {
      'zbirenbaum/copilot-cmp',
      config = function()
        require('copilot_cmp').setup()
      end,
    },
    {
      'richardbizik/nvim-toc',
      config = function()
        require('nvim-toc').setup()
      end
    },
    {
      'stevearc/aerial.nvim',
      opts = {},
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        'nvim-tree/nvim-web-devicons'
      },
      config = function()
        require('aerial').setup({
          layout = {
            max_width = { 40, 0.3 }
          }
        })
        vim.keymap.set('n', '<leader>f', ':AerialToggle!<CR> ')
      end
    },
    {
      'vidocqh/data-viewer.nvim',
      opts = {
        columnColorRoulette = {
          "white",
          "aqua",
          "white"
        }
      },
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
      config = function()
        require('data-viewer').setup()
        vim.keymap.set('n', '<leader>dv', ':DataViewer<CR>')
      end
    },
    {
      'echasnovski/mini.animate',
      version = '*',
      config = function()
        require('mini.animate').setup({
          cursor = {
            enable = true,
            timing = function()
              return 1
            end,
          },
          scroll = {
            enable = true,
            timing = function()
              return 1
            end,
          },
        })
      end
    }
},
{
    ui = {
        border = "rounded"
    }
})
-- 
--0=========================================================================0
-- █▀█ █░░ █░█ █▀▀ █ █▄░█ █▀   █▀▀ █▄░█ █▀▄   █░█ █▀▀ █▀█ █▀▀
-- █▀▀ █▄▄ █▄█ █▄█ █ █░▀█ ▄█   ██▄ █░▀█ █▄▀   █▀█ ██▄ █▀▄ ██▄
--0=========================================================================0
--0=========================================================================0
-- ▄▀█ █░█ ▀█▀ █▀█ █▀▀ █▀▄▀█ █▀▄
-- █▀█ █▄█ ░█░ █▄█ █▄▄ █░▀░█ █▄▀
--0=========================================================================0
-- Highlight yanked text for 150ms
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end
})
