return {
    'neovim/nvim-lspconfig',
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        local custom_attach = function(client, bufnr)
        end

        -- Pyright
        vim.lsp.config('pyright', {
            on_attach = custom_attach,
            capabilities = capabilities,
            settings = {
                python = {
                    pythonPath = "/Users/kaleempeeroo/venv/bin/python",
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = false,
                        diagnosticMode = "openFilesOnly",
                    },
                },
            },
        })
        vim.lsp.enable('pyright')

        -- Ruff
        vim.lsp.config('ruff', {
            on_attach = custom_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable('ruff')

        -- Rust Analyzer
        vim.lsp.config('rust_analyzer', {
            on_attach = custom_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable('rust_analyzer')

        -- Texlab
        vim.lsp.config('texlab', {
            on_attach = custom_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable('texlab')

        -- Lua LS
        vim.lsp.config('lua_ls', {
            on_attach = custom_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        enable = false,
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
        vim.lsp.enable('lua_ls')

        -- New server template:
        -- vim.lsp.config('SERVER', {
        --     on_attach = custom_attach,
        --     capabilities = capabilities,
        --     -- COPY PASTE SERVER SETTINGS HERE
        -- })
        -- vim.lsp.enable('SERVER')
    end
}
