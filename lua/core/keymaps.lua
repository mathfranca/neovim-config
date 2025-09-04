vim.keymap.set("n", "<localleader><localleader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<localleader>x", ":.lua<CR>")
vim.keymap.set("v", "<localleader>x", ":lua<CR>")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")


-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window management
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<leader>vv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
vim.keymap.set("n", "<leader>vh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
vim.keymap.set("n", "<leader>ve", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
vim.keymap.set("n", "<leader>vc", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
-- --
vim.keymap.set("n", "<leader>t", "", { desc = "Tab commands" })
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
--
vim.keymap.set("n", "<Tab>", "<cmd>bn!<CR>", { desc = "Go to next buffer" })                        -- go to next buffer
vim.keymap.set("n", "<S-Tab>", "<cmd>bp!<CR>", { desc = "Go to previous buffer" })                  -- go to previous buffer
vim.keymap.set("n", "<leader>bd", "<cmd>bn!|bd!#<CR>", { desc = "Close current buffer " })          -- close current buffer
--
vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { silent = true, desc = "Next item in quickfix list" })
vim.keymap.set("n", "[q", "<cmd>cprevious<CR>", { silent = true, desc = "Next item in quickfix list" })
vim.keymap.set("n", "Q", function()
	local qf_exists = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1 then
			qf_exists = true
		end
	end
	if qf_exists == true then
		vim.cmd("cclose")
		return
	end
	if not vim.tbl_isempty(vim.fn.getqflist()) then
		vim.cmd("copen")
	end
end, { silent = true, desc = "Open quickfix list" })
