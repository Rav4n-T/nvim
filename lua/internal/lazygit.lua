local api = vim.api
local win = require("ui.window")
local M = {}

M.infos = {}

function M.open()
	local float_opt = {
		width = 0.8,
		height = 0.8,
		relative = "editor",
		title = "  Layz Git ",
		row = "c",
		col = "c",
	}

	M.infos.bufnr, M.infos.winid = win:new_float(float_opt, true, true):wininfo()

	vim.fn.termopen("lazygit", {
		on_exit = function()
			if api.nvim_win_is_valid(M.infos.winid) then
				api.nvim_win_close(M.infos.winid, true)
				M.infos.winid = nil
			end
		end,
	})
	-- 进入插入模式
	vim.cmd("startinsert")
end

return M
