return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		local api = require("nvim-tree.api")
		vim.keymap.set("n", "<leader>ee", api.tree.toggle, { desc = "Toggle tree view" })
		vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFileToggle<CR>", { desc = "Toggle tree view", silent = true })
		require("nvim-tree").setup({})
	end,
}
