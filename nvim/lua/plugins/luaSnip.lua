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
    end
}
