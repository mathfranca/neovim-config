return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("dapui").setup()
			require("dap-go").setup()

			require("mason-nvim-dap").setup({
				automatic_installation = true,
				ensure_installed = {
					"delve",
				},
			})

			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dg", dap.run_to_cursor, { desc = "Run to cursor" })
			vim.keymap.set("n", "<leader>d?", function()
				require("dapui").eval(nil, { enter = true })
			end, { desc = "Eval var under cursor" })
			vim.keymap.set("n", "<leader>dt", ui.toggle, { noremap = true, silent = true, desc = "Toggle Dap-ui" })
			vim.keymap.set(
				"n",
				"<leader>dr",
				":lua require('dapui').open({reset =true})<CR>",
				{ noremap = true, silent = true, desc = "Toggle Dap-ui" }
			)
			vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Debug terminate session" })

			vim.keymap.set("n", "<F1>", dap.continue, { desc = "Debug continue" })
			vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Debug step into" })
			vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Debug step over" })
			vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Debug step out" })
			vim.keymap.set("n", "<F5>", dap.step_back, { desc = "Debug step_back" })
			vim.keymap.set("n", "<F9>", dap.restart, { desc = "Debug restart" })

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end

			-- Java
			dap.configurations.java = {
				{
					type = "java",
					request = "launch",
					name = "Launch Java Program",
				},
			}
		end,
	},
}
