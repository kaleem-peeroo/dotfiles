return {
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
}
