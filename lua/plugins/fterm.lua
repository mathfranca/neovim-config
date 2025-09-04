return {
	"numToStr/FTerm.nvim",
	config = function()
		require 'FTerm'.setup({
			border     = 'double',
			dimensions = {
				height = 0.7,
				width = 0.9,
			},
		})

		-- Example keybindings
		vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
		vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
	end,
}
