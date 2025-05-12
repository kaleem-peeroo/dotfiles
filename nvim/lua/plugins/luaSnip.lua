return {
    "L3MON4D3/LuaSnip",
    lazy = false,
    dependencies = {
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load({
            paths = './my_snippets'
        })
        require("luasnip.loaders.from_snipmate").lazy_load()
        require("luasnip.loaders.from_lua").load({
            paths = "~/.config/nvim/LuaSnip/"
        })

        require("luasnip").config.set_config({
            enable_autosnippets = true,
            store_selection_keys = "<Tab>",
        })
    end
}
