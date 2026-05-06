return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		local wk = require("which-key")

		wk.add({
			{ "<leader>j", group = "harpoon" },
			{ "<leader>b", group = "buffer" },
			{ "<leader>d", group = "dap (debug)" },
			{ "<leader>t", group = "tab" },
			{ "<leader>f", group = "file tree" },
		})

		wk.setup({
			delay = function(_)
				return 1000 -- 1 second
			end
		})
	end,
}
