local M = {}

M.gdb = {
	type = "executable",
	command = "gdb",
	args = { "-i", "dap" },
}

M.cppdbg = {
	id = "cppdbg",
	type = "executable",
	-- command = "C:/Users/Leon/AppData/Local/nvim-data/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
	command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7.exe",
	-- if you're on windows
	options = {
		detached = false,
	},
}

M.lldb = {
	type = "executable",
	command = "D:/Scoop/User/apps/mingw-winlibs-llvm-ucrt/current/bin/lldb-vscode.exe", -- adjust as needed, must be absolute path
	name = "lldb",
}

M.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		-- CHANGE THIS to your path!
		-- command = "C:/Users/Leon/AppData/Local/nvim-data/mason/packages/codelldb/extension/adapter/codelldb",
		command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
		args = { "--port", "${port}" },
		-- On windows you may have to uncomment this:
		detached = false,
	},
}

M.dlv = {
	type = "server",
	port = "${port}",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

M.python = function(cb, config)
	if config.requet == "attach" then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = {
				source_filetype = "python",
			},
		})
	else
		cb({
			type = "executable",
			command = ".env/bin/python",
			args = { "-m", "debugpy.adapter" },
			options = {
				source_filetype = "python",
			},
		})
	end
end

return M
