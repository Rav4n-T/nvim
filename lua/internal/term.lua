local api = vim.api
local win = require("ui.window")
local M = {}

M.infos = {}
M.shell = nil

function M.get_current_shell()
	M.shell = os.getenv("SHELL") or os.getenv("ComSpec") -- 获取 SHELL 或 ComSpec 环境变量
	local shell_types = {
		bash = "Bash",
		zsh = "Zsh",
		fish = "Fish",
		powershell = "PowerShell",
		pwsh = "PowerShell 7",
	}

	if M.shell then
		for key, value in pairs(shell_types) do
			if M.shell:lower():find(key) then
				return value
			end
		end
	end

	if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
		-- Windows 系统
		M.shell = "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe"
	else
		-- 类 Unix 系统（Linux、macOS）
		M.shell = "/bin/bash"
	end
	return "Default Shell"
end

function M.open()
	local float_opt = {
		width = 0.8,
		height = 0.8,
		relative = "editor",
		title = "  " .. M.get_current_shell() .. " ",
		row = "c",
		col = "c",
	}

	M.infos.bufnr, M.infos.winid = win:new_float(float_opt, true, true):wininfo()

	function M.exit()
		-- 关闭窗口和缓冲区
		if api.nvim_win_is_valid(M.infos.winid) then
			api.nvim_win_close(M.infos.winid, true)
			api.nvim_buf_delete(M.infos.bufnr, { force = true })
			M.infos.winid = nil
		end
	end

	vim.fn.termopen(M.shell, {
		on_exit = M.exit,
	})

	-- 进入插入模式
	vim.cmd("startinsert")

	api.nvim_buf_set_keymap(M.infos.bufnr, "t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
	api.nvim_buf_set_keymap(M.infos.bufnr, "n", "q", "<cmd>bd!<cr>", { noremap = true, silent = true })

	vim.api.nvim_create_autocmd("TermClose", {
		buffer = M.infos.bufnr,
		callback = M.exit,
	})
end

return M
