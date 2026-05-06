return {
	"nvim-mini/mini.nvim",
	enabled = true,
	config = function()
		local MiniStatusline = require("mini.statusline")
		vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = "#ffffff", bg = "#444444" })
		MiniStatusline.setup({
			content = {
				active = function()
					local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
					local git = MiniStatusline.section_git({ trunc_width = 40 })
					local diff = MiniStatusline.section_diff({ trunc_width = 75 })
					local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
					local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
					local filename = MiniStatusline.section_filename({ trunc_width = 140 })
					local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
					local location = MiniStatusline.section_location({ trunc_width = 75 })
					local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
					return MiniStatusline.combine_groups({
						{
							hl = mode_hl,
							strings = { mode }
						},
						{ hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
						'%<',
						{ hl = 'MiniStatuslineFilename', strings = { filename } },
						'%=',
						{ hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
						{ hl = mode_hl,                  strings = { search, location } },
					})
				end,
			},
			use_icons = true,
		})


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
		vim.keymap.set("n", "<leader>ff", files.open, { desc = "Open file explorer" })
		local open_at_buf_file = function()
			files.open(vim.api.nvim_buf_get_name(0))
			files.reveal_cwd()
		end
		vim.keymap.set("n", "<leader>fe", open_at_buf_file, { desc = "Open file explorer at current file" })

		local icons = require("mini.icons")
		icons.setup({})

		-- local tabline = require("mini.tabline")
		-- tabline.setup({})

		local pairs = require("mini.pairs")
		pairs.setup({})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "rust",
			group = vim.api.nvim_create_augroup("Rust_disable_single_quote", { clear = true }),
			callback = function()
				pairs.unmap("i", "'", "''")
			end,
			desc = "Disable single quote Rust",
		})

		-- local notify = require("mini.notify") -- conflicts with the notify from lsp.
		-- notify.setup({
		-- 	lsp_progress = {
		-- 		-- Whether to enable showing
		-- 		enable = true,
		--
		-- 		-- Notification level
		-- 		level = 'ERROR', -- couldn't make it work
		--
		-- 		-- Duration (in ms) of how long last message should be shown
		-- 		duration_last = 2500,
		-- 	},
		-- })

		local move = require("mini.move") -- move text with ALT
		move.setup({})

		local misc = require("mini.misc")
		misc.setup({})

		local ai = require("mini.ai") -- enhances a and i operators
		ai.setup({})

		local cursorword = require("mini.cursorword")
		cursorword.setup({})

		local surround = require("mini.surround") -- like the tpope one, but better
		surround.setup({})
	end,
}
