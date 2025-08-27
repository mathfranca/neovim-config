local options = {
	number = true,
	relativenumber = true,
	mouse = 'a',
	breakindent = false,
	undofile = true,
	ignorecase = true,
	smartcase = true,
	signcolumn = 'yes',
	updatetime = 250,
	timeoutlen = 300,
	cursorline = true,
	scrolloff = 10,
	hlsearch = true,
	writebackup = false,
	shiftwidth = 4,
	tabstop = 4,
	pumheight = 10,
	winborder = 'single',
}

local global = {
	-- Leader mapping
	mapleader = ' ',
	maplocalleader = ',',
}

for name, value in pairs(options) do
	vim.opt[name] = value
end

for name, value in pairs(global) do
	vim.g[name] = value
end
