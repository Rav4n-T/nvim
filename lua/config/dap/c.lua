local M = {}

M.gdb = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return (vim.fn.getcwd() .. "\\" .. vim.fn.expand("%:r") .. ".exe")
		end,
		cwd = "${workspaceFolder}",
		MIMode = "gdb",
	},
}

M.cppdbg = {
	-- launch exe
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "\\", "file")
		end,
		-- args = function()
		-- 	local input = vim.fn.input("Input args: ")
		-- 	return require("utils").str2argtable(input)
		-- end,
		-- args = "",
		cwd = "${workspaceFolder}",
		stopOnEntry = true,
		-- setupCommands = {
		-- 	{
		-- 		description = "enable pretty printing",
		-- 		text = "-enable-pretty-printing",
		-- 		ignoreFailures = false,
		-- 	},
		-- },
	},
	-- attach server
	-- {
	-- 	name = "Attach to gdbserver :1234",
	-- 	type = "cppdbg",
	-- 	request = "launch",
	-- 	MIMode = "gdb",
	-- 	miDebuggerServerAddress = "localhost:1234",
	-- 	miDebuggerPath = "/usr/bin/gdb",
	-- 	cwd = "${workspaceFolder}",
	-- 	program = function()
	-- 		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	-- 	end,
	-- 	setupCommands = {
	-- 		{
	-- 			text = "-enable-pretty-printing",
	-- 			description = "enable pretty printing",
	-- 			ignoreFailures = false,
	-- 		},
	-- 	},
	-- },
	-- -- attach process
	-- {
	-- 	name = "Attach process",
	-- 	type = "cppdbg",
	-- 	request = "attach",
	-- 	processId = require("dap.utils").pick_process,
	-- 	program = function()
	-- 		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	-- 	end,
	-- 	cwd = "${workspaceFolder}",
	-- 	setupCommands = {
	-- 		{
	-- 			description = "enable pretty printing",
	-- 			text = "-enable-pretty-printing",
	-- 			ignoreFailures = false,
	-- 		},
	-- 	},
	-- },
}
M.lldb = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return (vim.fn.getcwd() .. "\\" .. vim.fn.expand("%:r") .. ".exe")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		MIMode = "lldb",

		-- 💀
		-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
		--
		--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		--
		-- Otherwise you might get the following error:
		--
		--    Error on launch: Failed to attach to the target process
		--
		-- But you should be aware of the implications:
		-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
		-- runInTerminal = false,
	},
}

M.codelldb = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			-- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			return (vim.fn.getcwd() .. "\\" .. vim.fn.expand("%:r") .. ".exe")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = true,
		externalConsole = false,
		MIMode = "codelldb",
	},
}

return M
