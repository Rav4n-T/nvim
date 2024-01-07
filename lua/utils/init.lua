local M = {}

M.root_patterns = { ".git", "lua", "package.json" }

function M.get_root()
	---@type string?
	local path = vim.api.nvim_buf_get_name(0)
	path = path ~= "" and vim.loop.fs_realpath(path) or nil
	---@type string[]
	local roots = {}
	if path then
		for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			local workspace = client.config.workspace_folders
			local paths = workspace
					and vim.tbl_map(function(ws)
						return vim.uri_to_fname(ws.uri)
					end, workspace)
				or client.config.root_dir and { client.config.root_dir }
				or {}
			for _, p in ipairs(paths) do
				local r = vim.loop.fs_realpath(p)
				if path:find(r, 1, true) then
					roots[#roots + 1] = r
				end
			end
		end
	end
	table.sort(roots, function(a, b)
		return #a > #b
	end)
	---@type string?
	local root = roots[1]
	if not root then
		path = path and vim.fs.dirname(path) or vim.loop.cwd()
		---@type string?
		root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
		root = root and vim.fs.dirname(root) or vim.loop.cwd()
	end
	---@cast root string
	return root
end

function M.get_prompt(prompt, default_prompt)
	local prompt_text = prompt or default_prompt
	if prompt_text:sub(-1) == ":" then
		prompt_text = "[" .. prompt_text:sub(1, -2) .. "]"
	end
	return prompt_text
end

function M.telescope(builtin, opts)
	local params = { builtin = builtin, opts = opts }
	return function()
		builtin = params.builtin
		opts = params.opts
		opts = vim.tbl_deep_extend("force", { cwd = M.get_root() }, opts or {})
		if builtin == "files" then
			if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
				opts.show_untracked = true
				builtin = "git_files"
			else
				builtin = "find_files"
			end
		end
		require("telescope.builtin")[builtin](opts)
	end
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

return M
