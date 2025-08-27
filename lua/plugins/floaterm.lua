return {
	"voldikss/vim-floaterm",
	config = function()
		vim.keymap.set("n", "<leader>tt", "<cmd>FloatermToggle --name=scratch --width=1<CR>", { desc = "Floaterm Toggle" })
	end,
}
