-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local remap = vim.keymap.set

remap("n", "<leader>e", ":NvimTreeToggle<CR>")

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false, 
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {}
	end,
}
