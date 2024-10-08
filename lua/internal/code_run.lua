local win = require("internal.util.window")
local api = vim.api
local infos = {}

local function running_window(opt, full)
	local float_opt = {
		width = full and 0.8 or -0.25,
		height = full and 0.8 or 0.9,
		relative = "editor",
		title = "  Code Running ",
		row = full and "c" or "t",
		col = full and "c" or "r",
	}

	infos.bufnr, infos.winid = win:new_float(float_opt, true, true):wininfo()

	api.nvim_create_autocmd("WinClosed", {
		buffer = infos.bufnr,
		callback = function()
			if infos.winid and api.nvim_win_is_valid(infos.winid) then
				api.nvim_win_close(infos.winid, true)
				api.nvim_buf_delete(infos.bufnr, { force = true })
				infos.winid = nil
			end
		end,
	})

	vim.cmd.term(opt)
end

local function running(full)
	vim.cmd("w")

	local filetype = vim.bo.filetype
	local filename = vim.fn.expand("%")
	local runfile = vim.fn.expand("%<")

	vim.cmd("silent! lcd %:p:h")

	if filetype == "c" then
		running_window(
			string.format('gcc "%s" -o "%s" && ./"%s" && rm -f "%s"', filename, runfile, runfile, runfile),
			full
		)
	elseif filetype == "cpp" then
		running_window(
			string.format(
				'g++ "%s" -std=c++17 -O2 -g -Wall -o "%s" && ./"%s" && rm -rf "%s"',
				filename,
				runfile,
				runfile,
				runfile
			),
			full
		)
	elseif filetype == "python" then
		running_window("python3 " .. filename, full)
	elseif filetype == "lua" then
		running_window("luajit " .. filename, full)
	elseif filetype == "sh" then
		running_window("bash " .. filename, full)
	elseif filetype == "markdown" then
		require("internal.markdown_preview").markdown_preview()
	elseif filetype == "html" then
		vim.fn.jobstart("live-server --browser=" .. _G.browser)
	else
		vim.notify("Undefined\n")
	end
end

return { running = running }
