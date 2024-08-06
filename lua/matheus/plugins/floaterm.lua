return {
	"voldikss/vim-floaterm",
	config = function()
		vim.keymap.set("n", "<leader>ft", "<cmd>FloatermToggle --name=scratch<CR>", { desc = "Floaterm Toggle" })
	end,
}
