return {
	-- "folke/tokyonight.nvim",
	-- priority = 1000,
	-- init = function()
	-- 	vim.cmd.colorscheme("tokyonight-night")
	-- 	vim.cmd.hi("Comment gui=none")
	-- end,
	-- "AlexvZyl/nordic.nvim",
	-- "miikanissi/modus-themes.nvim",
	"aktersnurra/no-clown-fiesta.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- require("modus-themes").setup({})
		vim.cmd([[colorscheme no-clown-fiesta]])
	end,
}
