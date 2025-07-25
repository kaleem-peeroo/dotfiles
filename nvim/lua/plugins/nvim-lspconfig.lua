return {
    'neovim/nvim-lspconfig',
    config = function()
        local lspconfig = require('lspconfig')
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        local custom_attach = function(client, bufnr)
        end

        lspconfig.pyright.setup {
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
        }

        lspconfig.ruff.setup {}

        lspconfig.texlab.setup {}

        lspconfig.lua_ls.setup({
            on_attach = custom_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- enable = true,
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
        -- new server goes here:
        -- lspconfig.SERVER.setup({
        --    on_attach = custom_attach,
        --    capabilities = capabilities
        --    COPY PASTE SERVER SETTINGS HERE
        --})
    end
}
