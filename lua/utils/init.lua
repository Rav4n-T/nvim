local M = {}

M.root_patterns = { ".git", "go.mod", "cargo.toml", "package.json" }

function M.get_prompt(prompt, default_prompt)
	local prompt_text = prompt or default_prompt
	if prompt_text:sub(-1) == ":" then
		prompt_text = "[" .. prompt_text:sub(1, -2) .. "]"
	end
	return prompt_text
end

M.runCode = function()
	local ft = vim.bo.filetype
	vim.cmd("split")
	if ft == "c" then
		vim.cmd("term gcc -g % -o %:t:r")
	elseif ft == "cpp" then
		vim.cmd("term g++ -g % -o %:t:r")
	elseif ft == "python" then
		vim.cmd("term .env\\Scripts\\python %")
	end
end

M.str2argtable = function(str)
	-- trim spaces
	str = string.gsub(str, "^%s*(.-)%s*$", "%1")
	local arg_list = {}

	local start = 1
	local i = 1
	local quote_refs_cnt = 0
	while i <= #str do
		local c = str:sub(i, i)
		if c == '"' then
			quote_refs_cnt = quote_refs_cnt + 1
			start = i
			i = i + 1
			-- find next quote
			while i <= #str and str:sub(i, i) ~= '"' do
				i = i + 1
			end
			if i <= #str then
				quote_refs_cnt = quote_refs_cnt - 1
				arg_list[#arg_list + 1] = str:sub(start, i)
				start = M.find_next_start(str, i + 1)
				i = start
			end
		-- find next start
		elseif c == " " then
			arg_list[#arg_list + 1] = str:sub(start, i - 1)
			start = M.find_next_start(str, i + 1)
			i = start
		else
			i = i + 1
		end
	end

	-- add last arg if possiable
	if start ~= i and quote_refs_cnt == 0 then
		arg_list[#arg_list + 1] = str:sub(start, i)
	end
	return arg_list
end
---@param fn fun()
function M.on_very_lazy(fn)
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			fn()
		end,
	})
end

return M
