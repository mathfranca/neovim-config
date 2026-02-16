return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			-- REQUIRED
			harpoon:setup()
			-- REQUIRED

			vim.keymap.set("n", "<leader>jr", function() harpoon:list():add() end, { desc = "add file" })
			vim.keymap.set("n", "<leader>jj", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
				{ desc = "toggle quick menu" })

			vim.keymap.set("n", "<leader>ja", function() harpoon:list():select(1) end, { desc = "jump to file 1" })
			vim.keymap.set("n", "<leader>js", function() harpoon:list():select(2) end, { desc = "jump to file 2" })
			vim.keymap.set("n", "<leader>jd", function() harpoon:list():select(3) end, { desc = "jump to file 3" })
			vim.keymap.set("n", "<leader>jf", function() harpoon:list():select(4) end, { desc = "jump to file 4" })

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<leader>jp", function() harpoon:list():prev() end, { desc = "next harpoon file" })
			vim.keymap.set("n", "<leader>jn", function() harpoon:list():next() end, { desc = "previous harpoon file" })
		end
	},
}
