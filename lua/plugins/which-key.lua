return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		require("which-key").setup({
			delay = function(_)
				return 1000 -- 1 second
			end
		})
	end,
}
