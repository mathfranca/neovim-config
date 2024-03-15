-- Disable netrw
--vim.g.loaded_netrw = 1     TODO: uncomment this when plugins configured
--vim.g.loaded_netrwPlugin = 1

local options = {
	number = true,
	relativenumber = true,
	mouse = "a",
	-- Don't show the mode, since it's already in status line
	showmode = false,
	-- Sync clipboard between OS and Neovim.
	--  Remove this option if you want your OS clipboard to remain independent.
	--  See `:help 'clipboard'`
	-- vim.opt.clipboard = 'unnamedplus'
	--
	-- Enable break indent
	breakindent = false,
	-- Save undo history
	undofile = true,
	-- Case-insensitive searching UNLESS \C or capital in search
	ignorecase = true,
	smartcase = true,
	-- Keep signcolumn on by default
	signcolumn = "yes",
	-- Decrease update time
	updatetime = 250,
	timeoutlen = 300,
	-- Configure how new splits should be opened
	splitright = true,
	splitbelow = true,
	-- Sets how neovim will display certain whitespace in the editor.
	--  See `:help 'list'`
	--  and `:help 'listchars'`
	list = true,
	listchars = { tab = "» ", trail = "·", nbsp = "␣" },
	-- Preview substitutions live, as you type!
	inccommand = "split",
	-- Show which line your cursor is on
	cursorline = true,
	-- Minimal number of screen lines to keep above and below the cursor.
	scrolloff = 10,
	-- Set highlight on search, but clear on pressing <Esc> in normal mode
	hlsearch = true,
	writebackup = false,
	--expandtab = true,
	shiftwidth = 2,
	tabstop = 2,
}

local global = {
	-- Leader mapping
	mapleader = " ",
	maplocalleader = " ",
}

for name, value in pairs(options) do
	vim.opt[name] = value
end

for name, value in pairs(global) do
	vim.g[name] = value
end
