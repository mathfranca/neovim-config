return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-mini/mini.icons" },
	opts = {},
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup()

		vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>sn", function() fzf.files({ cwd = "~/.config/nvim" }) end,
			{ desc = "Find files in neovim config" })
		vim.keymap.set("n", "<leader>sb", fzf.buffers, { desc = "Find opened buffers" })
		vim.keymap.set("n", "<leader><leader>", fzf.buffers, { desc = "Find opened buffers" })
		vim.keymap.set("n", "<leader>st", fzf.tabs, { desc = "Find opened tabs" })
		vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "Show bound keymaps" })
		vim.keymap.set("n", "<leader>sg", fzf.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "Grep current word" })
		vim.keymap.set("n", "<leader>sW", fzf.grep_cWORD, { desc = "Grep current Word" })
		vim.keymap.set("n", "<leader>s/", fzf.grep_curbuf, { desc = "Grep in current buffer" })

		-- General Menu
		vim.keymap.set("n", "<leader>F", ":FzfLua<CR>", { desc = "Open FzfLua menu", silent = true })
	end,
}
