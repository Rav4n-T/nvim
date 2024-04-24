local M = {
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
