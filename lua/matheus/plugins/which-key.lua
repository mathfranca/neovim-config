return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		require("which-key").setup()

		require("which-key").register({
			["<leader>l"] = { name = "LSP", _ = "which_key_ignore" },
			["<leader>d"] = { name = "Document", _ = "which_key_ignore" },
			["<leader>r"] = { name = "Run", _ = "which_key_ignore" },
			["<leader>s"] = { name = "Search", _ = "which_key_ignore" },
			["<leader>w"] = { name = "Workspace", _ = "which_key_ignore" },
			["<leader>v"] = { name = "View", _ = "which_key_ignore" },
			["<leader>t"] = { name = "Tab", _ = "which_key_ignore" },
			["<leader>g"] = { name = "Debug", _ = "which_key_ignore" },
		})
	end,
}
