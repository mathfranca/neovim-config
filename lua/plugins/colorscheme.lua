return {
	{
		"kvrohit/rasmus.nvim",
		-- "aktersnurra/no-clown-fiesta.nvim",
		-- "projekt0n/github-nvim-theme",
		-- "yazeed1s/minimal.nvim",
		-- "santos-gabriel-dario/darcula-solid.nvim",
		-- "vermdeep/darcula_dark.nvim",
		dependencies = {
			"rktjmp/lush.nvim",
		},
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd 'set termguicolors'
			vim.cmd.colorscheme 'rasmus'
		end
	},
}
