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

require("lazy").setup({
    {
        'leet0rz/modified-moonlight.nvim', -- this is the theme
        config = function()
            -- vim.cmd('colorscheme moonlight') -- this applies the theme
        end
    },
    {
        'EdenEast/nightfox.nvim',
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
            -- vim.keymap.sets
            vim.keymap.set('n', "'", ':CommentToggle<CR>')
            vim.keymap.set('v', "'", ':CommentToggle<CR>')
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
            -- vim.keymap.sets
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader><leader>', builtin.find_files)
            vim.keymap.set('n', '<leader>fg', builtin.live_grep)
            vim.keymap.set('n', '<leader>fb', builtin.buffers)
            vim.keymap.set('n', '<leader>fh', builtin.help_tags)
            vim.keymap.set('n', '<leader>fm', builtin.marks)
            vim.keymap.set('n', 'gd', builtin.lsp_definitions)
            vim.keymap.set('n', 'gr', builtin.lsp_references)
            -- vim.keymap.set('n', '<leader>f', builtin.lsp_document_symbols)
            vim.keymap.set('n', '<leader>f', ':lua require("telescope.builtin").lsp_document_symbols({symbols="function"})<CR>')

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
            -- vim.keymap.sets
            vim.keymap.set('n', '<leader>o', ':Oil<CR>')
            require('oil').setup({
                default_file_explorer = true,
                keymaps = {
                    ['<C-s>'] = ':w<CR>',
                    ['<C-l>'] = false,
                    ['<C-h>'] = false
                },
                view_options = { show_hidden = true },
                skip_confirm_for_simple_edits = true
            })
        end
    },
    --0=============================================================================================0
    -- █▄▄ █░█ █▀▀ █▀▀ █▀▀ █▀█ █░░ █ █▄░█ █▀▀
    -- █▄█ █▄█ █▀░ █▀░ ██▄ █▀▄ █▄▄ █ █░▀█ ██▄    
    --0=============================================================================================0
    {
        "akinsho/bufferline.nvim",
        -- version = "*",
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
                ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'latex' },
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
    dependencies = { 'nvim-tree/nvim-web-devicons' },
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
            end
            require'lspconfig'.pyright.setup{}
            require'lspconfig'.ruff.setup{}
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
                        require('luasnip.loaders.from_vscode').lazy_load({
                            paths = {
                                './my_snippets'
                            }
                        })
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
        "L3MON4D3/LuaSnip",
        lazy = false,
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load({
                paths = './my_snippets'
            })
        end
    },

    -- {
    --     "nvim-tree/nvim-tree.lua",
    --     version = "*",
    --     lazy = false,
    --     dependencies = {
    --         "nvim-tree/nvim-web-devicons",
    --     },
    --     config = function()
    --         vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
    --         require("nvim-tree").setup {
    --           view = {adaptive_size = true}
    --         }
    --     end
    -- },
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
        -- vim.keymap.set('n', '<leader>f', ':AerialToggle!<CR> ')
      end
    },
    {
      'vidocqh/data-viewer.nvim',
      opts = {
        columnColorRoulette = {
          "white",
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
    -- {
    --   'echasnovski/mini.animate',
    --   version = '*',
    --   config = function()
    --     require('mini.animate').setup({
    --       cursor = {
    --         enable = true,
    --         timing = function()
    --           return 1
    --         end,
    --       },
    --       scroll = {
    --         enable = true,
    --         timing = function()
    --           return 1
    --         end,
    --       },
    --     })
    --   end
    -- },
    {
      'nvim-treesitter/nvim-treesitter-context',
      config = function()
        require('treesitter-context').setup()
      end
    },
    {
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
    },
    {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup()
      end
    },
    {
      'lervag/vimtex',
      lazy = false,
      config = function()
        vim.g.vimtex_view_method = 'zathura'
        vim.keymap.set('n', '<leader>ll', ':VimtexCompile<CR>')
        -- vim.api.nvim_set_keymap('n', '<leader>lf', ':lua insert_latex_figure_snippet()<CR>', { novim.keymap.set = true, silent = true })
      end
    },
    {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end,
    lazy = false
    },
    {
      "epwalsh/obsidian.nvim",
      version = "*",
      lazy = true,
      ft = "markdown",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      opts = {
        workspaces = {
          {
            name = "vault 2.0",
            path = "~/vault 2.0/"
          }
        }
      }
    },
    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("todo-comments").setup {}
      end
    },
    {
      "christoomey/vim-tmux-navigator",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious"
      },
      keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" }
      }
    },
    {
      'zaldih/themery.nvim',
      config = function()
        vim.keymap.set('n', '<leader>ct', ':Themery<CR>')
        require('themery').setup({
          themes = {
            { name = "Nightfox",  colorscheme = "Nightfox" },
            { name = "Dayfox", colorscheme = "Dayfox" },
            { name = "Dawnfox", colorscheme = "Dawnfox" },
            { name = "Duskfox", colorscheme = "Duskfox" },
            { name = "Nordfox", colorscheme = "Nordfox" },
            { name = "Terafox", colorscheme = "Terafox" },
            { name = "Carbonfox", colorscheme = "Carbonfox" },

            { name = "Rose Pine Main", colorscheme = "rose-pine-main" },
            { name = "Rose Pine Moon", colorscheme = "rose-pine-moon" },
            { name = "Rose Pine Dawn", colorscheme = "rose-pine-dawn" },

            { name = "Tokyo Night", colorscheme = "tokyonight-night" },
            { name = "Tokyo Night Storm", colorscheme = "tokyonight-storm" },
            { name = "Tokyo Night Day", colorscheme = "tokyonight-day" },
            { name = "Tokyo Night Moon", colorscheme = "tokyonight-moon" },
          }
        })
      end
    },
    {
      "rose-pine/neovim",
      name = "rose-pine",
    },
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {}
    },
    {"MunifTanjim/nui.nvim"},
    {"rcarriga/nvim-notify"},
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify"
      },
      config = function()
        require("noice").setup({
          lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
          },
          -- you can enable a preset for easier configuration
          presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
          },
        })
      end
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            { 'zbirenbaum/copilot.lua' },
            { 'nvim-lua/plenary.nvim' },
        },
        build = { 'make tiktoken' },
        opts = {
            debug = false,
            mappings = {
                reset = {
                    normal = '',
                    insert = '',
                }
            }
        },
    },
    {
        "rmagatti/goto-preview",
        event = "BufEnter",
        config = function()
            require("goto-preview").setup({
                width = 150,
                height = 30
            })
            vim.keymap.set('n', '<leader>d', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>')
            vim.keymap.set('n', '<leader>w', '<cmd>lua require("goto-preview").close_all_win()<CR>')
        end
    },
    {
        "zbirenbaum/neodim",
        event = "LspAttach",
        config = function()
            require("neodim").setup({
                alpha = 0.5
            })
        end
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = { "black" }
            })

            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.ruff
                }
            })

        end
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim"
        },
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = { "black" }
            })
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup()
        end
    },
    {
        "mhartington/formatter.nvim",
        config = function()
            require("formatter").setup({
                filetype = {
                    json = {
                        function()
                            return {
                                exe = "js-beautify",
                                stdin = true,
                                try_node_modules = true
                            }
                        end
                    },
                    ["*"] = {
                        require("formatter.filetypes.any").remove_trailing_whitespace,
                    }
                }
            })
        end
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup({})

            local conf = require("telescope.config").values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers").new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                }):find()

            end

            vim.keymap.set(
                "n",
                "<C-h>",
                function() toggle_telescope(harpoon:list()) end,
                { desc = "Open harpoon window"}
            )

            vim.keymap.set(
                "n",
                "<leader>a",
                function() harpoon:list():add() end
            )
        end
    }
},
{
    ui = {
        border = "rounded"
    }
})

