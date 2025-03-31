return {
  {
    "edluffy/hologram.nvim",
    ft = { "markdown", "markdown.mdx" },
    config = function()
      require("hologram").setup({
        auto_display = true,
      })
    end,
  },
}
