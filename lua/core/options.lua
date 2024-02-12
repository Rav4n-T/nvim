local M = {}
local datapath = vim.fn.stdpath("data")

M.options = {
	o = {
		number = true, --Enable number line
		signcolumn = "number", --Set signcolum line in number line
		guicursor = "n-i-c-ci-cr:ver1,v-ve-o-r-sm:hor1", --Set cursor type
		clipboard = "unnamedplus", --Enable system clipboard
		-- set status line  never show
		laststatus = 0,
		-- set columns of context
		sidescrolloff = 10,
		termguicolors = true,
		-- set timeout
		timeoutlen = 300,
		-- dont show mode since
		showmode = false,
		-- Set tab width is 2, set tab is space
		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
		expandtab = true,
		-- Set encode type
		encoding = "utf-8",
		fileencodings = "ucs-bom,utf-8,gbk,cp936,gb18030,gb2312",
		-- set fold
		foldmethod = "expr",
		foldenable = false,
		foldexpr = "nvim_treesitter#foldexpr()",
		foldlevel = 8,
		-- set cancel highlight, ignore case
		hlsearch = false,
		incsearch = true,
		-- disabled mouse
		mouse = "",
		-- enable auto read and auto write
		autoread = true,
		autowrite = true,
		-- hide * markup for bold and italic
		conceallevel = 0,
		-- disable line wrap
		wrap = false,
		-- set file cache
		updatetime = 200,
		backup = true,
		swapfile = true,
		undofile = true,
		undolevels = 10000,
		dir = datapath .. "/swp_temp/",
		undodir = datapath .. "/undo_temp/",
		backupdir = datapath .. "/backup_temp/",
		-- background = "dark",
		splitbelow = true,
		-- nvim 0.9 new options
		splitkeep = "screen",
		-- shortmess
		-- windows shell
		-- shell = "powershell",
	},
	g = {
		-- set leaderkey
		mapleader = " ",
		maplocalleader = " ",
		markdown_recommended_style = 0,
	},
	wo = {},
}

M.icons = {
	diagnostics = { Error = " ", Warn = " ", Info = " " },
	git = {
		added = "+ ",
		modified = "~ ",
		removed = "- ",
	},
	debug = {
		error = "🛑",
		condition = "󰟃",
		rejected = "󰃤",
		logpoint = "",
		stopped = "󰜴",
	},
}

return M
