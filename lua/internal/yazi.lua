local api = vim.api
local win = require("ui.window")
local infos = {}
local M = {}

local function open_file(open, opt)
	if opt == "left" then
		vim.cmd("set nosplitright")
	elseif opt == "down" then
		vim.cmd("set splitbelow")
	elseif opt == "up" then
		vim.cmd("set nosplitbelow")
	elseif opt == "right" then
		vim.cmd("set splitright")
	end

	if vim.fn.filereadable(vim.fn.expand(infos.tempname)) == 1 then
		local filenames = vim.fn.readfile(infos.tempname)
		for _, filename in ipairs(filenames) do
			vim.cmd(open .. " " .. filename)
		end
	end
end

local function end_options()
	vim.fn.delete(infos.tempname)
	vim.cmd("silent! lcd " .. infos.workpath)
end

function M.open(open, opt)
	infos.workpath = vim.fn.getcwd()
	infos.filename = api.nvim_buf_get_name(0)
	infos.tempname = vim.fn.tempname()

	vim.cmd("silent! lcd %:p:h")

	local float_opt = {
		width = 0.8,
		height = 0.8,
		title = " Yazi ",
		relative = "editor",
		row = "c",
		col = "c",
	}

	if infos.bufnr then
		float_opt.bufnr = infos.bufnr
		api.nvim_set_option_value("modified", false, { scope = "local", buf = infos.bufnr })
	end

	infos.bufnr, infos.winid = win:new_float(float_opt, true, true):wininfo()

	vim.fn.termopen(string.format('yazi %s --chooser-file="%s"', infos.filename, infos.tempname), {
		on_exit = function()
			if api.nvim_win_is_valid(infos.winid) then
				api.nvim_win_close(infos.winid, true)
				infos.winid = nil
				open_file(open, opt)
			end
			end_options()
		end,
	})

	-- 进入插入模式
	vim.cmd("startinsert")
end

function M.setup()
	api.nvim_create_user_command("Yazi", function(args)
		if #args.args == 0 then
			M.open("edit")
		elseif args.args == "left" then
			M.open("vsplit", "lefs")
		elseif args.args == "down" then
			M.open("split", "down")
		elseif args.args == "up" then
			M.open("split", "up")
		elseif args.args == "right" then
			M.open("vsplit", "right")
		elseif args.args == "tabe" then
			M.open("tabe")
		else
			error("Wrong parameters")
		end
	end, { nargs = "?" })
end

return M
