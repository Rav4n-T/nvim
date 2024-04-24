local M = {
	{
		type = "delve",
		name = "Debug Project",
		request = "launch",
		program = "${workspaceFolder}",
		-- program = "${workspaceFolderBasename}",
	},
	{
		type = "delve",
		name = "Debug Single File", -- configuration for debugging test files
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	-- works with go.mod packages and sub packages
	{
		type = "delve",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
}

return M
