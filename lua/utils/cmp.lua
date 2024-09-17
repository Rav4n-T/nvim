local M = {}

M.has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.fc_trigger_chars = function()
	local chars = {}
	if #chars == 0 then
		for i = 33, 126 do
			chars[#chars + 1] = string.char(i)
		end
		chars[#chars + 1] = "\n"
		chars[#chars + 1] = "\r"
		chars[#chars + 1] = "\r\n"
		chars[#chars + 1] = "\t"
	end
	return chars
end

return M
