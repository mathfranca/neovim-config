return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = {
	'nvim-lua/plenary.nvim',
	{'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
	require('telescope').setup({
	  pickers = {
		find_files = {
		  theme = "ivy"
		}
	  },
	  defaults = {
		path_display = { "smart" },
	  },
	  extensions = {
		fzf = {}
	  }
	})

	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "ui-select")

	local builtin = require('telescope.builtin')
	local find_files = builtin.find_files


	vim.keymap.set("n", "<leader>s", "", { desc = "Search functions"})

	vim.keymap.set("n", "<leader>sf", find_files, { desc = "Search files"})

	vim.keymap.set("n", "<leader>sn", function()
	  local opts = require("telescope.themes").get_ivy({
		cwd = vim.fn.stdpath("config")
	  })
	  builtin.find_files(opts)
	end, { desc = "Search files in neovim config"})

	vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search Keymaps" })

	vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current word" })

	vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })

	vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })

	vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Search Resume" })

	vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })

	vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Find existing buffers" })

	vim.keymap.set("n", "<leader>/", function()
	  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	  }))
	end, { desc = "Fuzzily search in current buffer" })

	vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "Search in Open Files" })
  end,
}
