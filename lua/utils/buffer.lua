local M = {}
local api = vim.api
local notify = vim.notify

local function is_buffer_modified(bufnr)
	return api.nvim_get_option_value("modified", { buf = bufnr })
end

local function filter_buffers(bufnr)
	if not api.nvim_buf_is_valid(bufnr) or not api.nvim_get_option_value("buflisted", { buf = bufnr }) then
		return false
	end
	return true
end

local function get_valid_bufs()
	return vim.tbl_filter(filter_buffers, api.nvim_list_bufs())
end

local function get_buf_win(bufnr)
	local all_wins = api.nvim_list_wins()
	return vim.tbl_filter(function(win)
		return api.nvim_win_get_buf(win) == bufnr
	end, all_wins)
end

local function keep_win_layout(bufnr)
	-- local all_wins = api.nvim_list_wins()
	local current_win = api.nvim_get_current_win()
	local buffers = get_valid_bufs()

	if #buffers < 2 then
		local new_buf = api.nvim_create_buf(true, false)
		api.nvim_win_set_buf(current_win, new_buf)
		-- for _, win in ipairs(all_wins) do
		-- 	api.nvim_win_set_buf(win, new_buf)
		-- end
		return
	end

	-- local windows = get_buf_win(bufnr)
	--
	-- if #windows == 0 then
	-- 	return
	-- end

	for index, buffer in ipairs(buffers) do
		if buffer == bufnr then
			local new_focus_index = index + 1 > #buffers and #buffers - 1 or index + 1
			api.nvim_win_set_buf(current_win, buffers[new_focus_index])
		end
	end
end

local function del_buffer(bufnr)
	if is_buffer_modified(bufnr) then
		notify("Cannot delete buffer " .. bufnr .. " with unsaved changes", vim.log.levels.ERROR)
		return
	end
	keep_win_layout(bufnr)
	api.nvim_buf_delete(bufnr, {})
	notify("Delete buffer " .. bufnr .. " success", vim.log.levels.INFO)
end

function M.del_current_buffer()
	local current_bufnr = api.nvim_get_current_buf()
	del_buffer(current_bufnr)
end

function M.del_other_buffers()
	local current_bufnr = api.nvim_get_current_buf()
	local buffers = get_valid_bufs()
	for _, bufnr in ipairs(buffers) do
		if bufnr ~= current_bufnr then
			del_buffer(bufnr)
		end
	end
end

return M
