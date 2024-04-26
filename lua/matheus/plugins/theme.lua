return {
	-- "folke/tokyonight.nvim",
	-- priority = 1000,
	-- init = function()
	-- 	vim.cmd.colorscheme("tokyonight-night")
	-- 	vim.cmd.hi("Comment gui=none")
	-- end,
	"AlexvZyl/nordic.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("nordic").load()
	end,
}
