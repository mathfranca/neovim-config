vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true}),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- vim.api.nvim_create_autocmd("TermOpen", {
--   group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
--   callback = function()
-- 	vim.opt.number = false
-- 	vim.opt.relativenumber = false
--   end,
-- })
--
-- local job_id = 0
-- vim.keymap.set("n", "<leader>tt", function()
--   vim.cmd.vnew()
--   vim.cmd.term()
--   vim.cmd.wincmd("J")
--   vim.api.nvim_win_set_height(0, 15)
--
--   job_id = vim.bo.channel
-- end, { desc = "Open terminal"})
--
-- vim.keymap.set("n", "<leader>tc", function()
--   vim.fn.chansend(job_id, {"echo 'hi\n\n"})
-- end, {desc = "example of sending a command to terminal"})
