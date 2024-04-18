local wk = require("which-key")
local utils = require("utils")

local add_command = vim.api.nvim_create_autocmd
local add_augroup = vim.api.nvim_create_augroup
local group = add_augroup("stay_centered", { clear = true })

add_command("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 300,
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

add_command("FileType", {
	pattern = "c,cpp,python",
	callback = function()
		wk.register({
			["<F5>"] = {
				utils.runCode,
				"Compilite or Run",
			},
		})
	end,
})

vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

add_command("InsertLeave", {
	callback = function()
		local input_status = tonumber(vim.fn.system("fcitx5-remote"))
		if input_status == 2 then
			vim.fn.system("fcitx5-remote -c")
		end
		-- auto format in InsertLeave
		-- vim.cmd("Format")
	end,
})

add_command("ExitPre", {
	group = vim.api.nvim_create_augroup("Exit", { clear = true }),
	command = "set guicursor=a:ver90",
	desc = "Set cursor back to beam when leaving Neovim.",
})

-- stay current lin on screent center

add_command("CursorMovedI", {
	group = group,
	callback = function()
		local line = vim.api.nvim_win_get_cursor(0)[1]
		if line ~= vim.b.last_line then
			vim.cmd("norm! zz")
			vim.b.last_line = line
			local column = vim.fn.getcurpos()[5]
			vim.fn.cursor({ line, column })
		end
	end,
})
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
