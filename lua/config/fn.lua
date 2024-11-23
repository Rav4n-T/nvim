local wk = require("which-key")
local utils = require("utils")

local add_command = vim.api.nvim_create_autocmd
local add_augroup = vim.api.nvim_create_augroup
local group = add_augroup("stay_centered", { clear = true })

-- add auto command

-- highlight on yank
add_command("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 300,
		})
	end,
})

-- Change cursor shape when neovim exit
-- add_command("ExitPre", {
-- 	group = vim.api.nvim_create_augroup("Exit", { clear = true }),
-- 	command = "set guicursor=a:ver90",
-- 	desc = "Set cursor back to beam when leaving Neovim.",
-- })

-- stay current lin on screent center
-- add_command("CursorMovedI", {
-- 	group = group,
-- 	callback = function()
-- 		local line = vim.api.nvim_win_get_cursor(0)[1]
-- 		if line ~= vim.b.last_line then
-- 			vim.cmd("norm! zz")
-- 			vim.b.last_line = line
-- 			local column = vim.fn.getcurpos()[5]
-- 			vim.fn.cursor({ line, column })
-- 		end
-- 	end,
-- })

add_command("CursorMoved", {
	group = group,
	callback = function()
		local line = vim.api.nvim_win_get_cursor(0)[1]
		if line ~= vim.b.last_line then
			vim.cmd("norm! zz")
			vim.b.last_line = line
		end
	end,
})

add_command("BufEnter", {
	group = group,
	callback = function()
		local line = vim.api.nvim_win_get_cursor(0)[1]
		if line ~= vim.b.last_line then
			vim.cmd("norm! zz")
			vim.b.last_line = line
		end
	end,
})

add_command("VimEnter", {
	group = group,
	once = true,
	callback = function()
		-- keymap
		require("config.keymaps")
		vim.cmd.colorscheme("everforest")
		-- lines
		-- require("internal.stl").setup()
	end,
})
-- Add run keybind
add_command("FileType", {
	pattern = "c,cpp,python",
	callback = function()
		wk.add({
			["<F5>"] = {
				utils.runCode,
				"Compilite or Run",
			},
		})
	end,
})

-- Use mingw build file in windows
-- add_command("FileType", {
--   pattern = "c,cpp",
--   callback = function()
--     local ft = vim.fn.expand("%:e")
--     -- local ft = vim.bo.filetype()
--     if ft == "c" then
--       wk.register({
--         ["<F4>"] = {
--           -- '<cmd>2TermExec direction=horizontal cmd="gcc % -o %:t:r.exe"<cr>',
--           "Compile the current c file",
--         },
--       })
--     elseif ft == "cpp" then
--       wk.register({
--         ["<F4>"] = {
--           -- '<cmd>2TermExec direction=horizontal cmd="g++ % -o %:t:r.exe"<cr>',
--           "Compile the current cpp file",
--         },
--       })
--     end
--   end,
-- })

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
		"markdown",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Auto remove unused imports and sort imports with buferr write (typescript-tools)
--add_command("BufWritePre", {
--	pattern = { "*.js", "*.mjs", "*.jsx", "*.ts", "*.tsx", "*.mts" },
--	callback = function()
--		vim.cmd("TSToolsAddMissingImports sync")
--		vim.cmd("TSToolsOrganizeImports sync")
--	end,
--})

-- Change fcitx5 status on insertLeave
--  IM Switch
require("utils.im").setup()
