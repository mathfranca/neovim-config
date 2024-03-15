return {
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = { signs = false },
	config = function()
		local todo = require("todo-comments")
		vim.keymap.set("n", "]t", todo.jump_next, { desc = "Go to next [T]odo" })
		vim.keymap.set("n", "[t", todo.jump_prev, { desc = "Go to previous [T]odo" })
	end,
}
