return {
	"echasnovski/mini.nvim",
	enabled = true,
	config = function()
		local statusline = require("mini.statusline")
		statusline.setup({ use_icons = true })

		local files = require("mini.files")
		files.setup({
			windows = {
				preview = false,
			},
			mappings = {
				close = "q",
				go_in = "l",
				go_in_plus = "L",
				go_out = "h",
				go_out_plus = "H",
				mark_goto = "'",
				mark_set = "m",
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},
		})

		local icons = require("mini.icons")
		icons.setup({})

		local tabline = require("mini.tabline")
		tabline.setup({})

		-- local pairs = require("mini.pairs")
		-- pairs.setup({})

		local notify = require("mini.notify")
		notify.setup({})

		local move = require("mini.move")
		move.setup({})

		local misc = require("mini.misc")
		misc.setup({})

		local cursorword = require("mini.cursorword")
		cursorword.setup({})

		local open_at_buf_file = function()
			files.open(vim.api.nvim_buf_get_name(0))
			files.reveal_cwd()
		end

		vim.keymap.set("n", "<leader>ff", files.open, { desc = "Open file explorer" })
		vim.keymap.set("n", "<leader>ef", open_at_buf_file, { desc = "Open file explorer at current file" })
	end,
}
