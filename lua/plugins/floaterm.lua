return {
	"voldikss/vim-floaterm",
	config = function()
		vim.keymap.set("n", "<leader>tt", "<cmd>FloatermToggle --name=scratch<CR>", { desc = "Floaterm Toggle" })
	end,
}
