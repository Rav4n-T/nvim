return {
	{
		"mfussenegger/nvim-dap",
		ft = { "c", "cpp", "go", "py", "rust" },
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
				opts = {
					layouts = {
						{
							elements = {
								{
									id = "repl",
									size = 0.6, -- 25% of total lines
								},
								{
									id = "watches",
									size = 0.4, -- 25% of total lines
								},
							},
							size = 0.25, -- 25% of total lines
							position = "bottom",
						},
						{
							elements = {
								"scopes",
								"breakpoints",
							},
							size = 0.25, -- 40 columns
							position = "left",
						},
					},
					floating = {
						max_height = nil, -- These can be integers or a float between 0 and 1.
						max_width = nil, -- Floats will be treated as percentage of your screen.
						border = "single", -- Border style. Can be "single", "double" or "rounded"
						mappings = {
							close = { "q", "<Esc>" },
						},
					},
				},
				config = function(_, opts)
					local dap = require("dap")
					local dapui = require("dapui")
					local icons = require("config.options").icons.dap

					for name, sign in pairs(icons) do
						sign = type(sign) == "table" and sign or { sign }
						vim.fn.sign_define(
							"Dap" .. name,
							{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
						)
					end
					dapui.setup(opts)

					dap.listeners.before.attach.dapui_config = function()
						dapui.open()
					end
					dap.listeners.before.launch.dapui_config = function()
						dapui.open()
					end
					dap.listeners.before.event_terminated.dapui_config = function()
						dapui.close()
					end
					dap.listeners.before.event_exited.dapui_config = function()
						dapui.close()
					end
				end,
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				config = true,
			},
		},
		config = function()
			local dap = require("dap")
			local map = vim.keymap.set
			local adapters = require("config.dap.adapters")
			local pyCfg = require("config.dap.python")
			local goCfg = require("config.dap.goc")
			local cCfg = require("config.dap.c")

			dap.adapters.python = adapters.python
			dap.configurations.python = pyCfg

			dap.adapters.delve = adapters.dlv
			dap.configurations.go = goCfg

			-- dap.adapters.codelldb = adapters.codelldb
			-- dap.adapters.lldb = adapters.lldb
			-- require("dap-go").setup()

			dap.adapters.cppdbg = adapters.cppdbg

			dap.configurations.c = cCfg.cppdbg
			dap.configurations.cpp = cCfg.cppdbg
			dap.configurations.rust = cCfg.cppdbg

			-- set debug keymaps
			map("n", "<F6>", "<cmd>DapStepOver<cr>", { desc = "Step Over", remap = true, silent = true })
			map("n", "<F7>", "<cmd>DapStepInto<cr>", { desc = "Step Into", remap = true, silent = true })
			map("n", "<F8>", "<cmd>DapStepOut<cr>", { desc = "Step Out", remap = true, silent = true })
			map("n", "<F9>", "<cmd>DapContinue<cr>", { desc = "Continue", remap = true, silent = true })
			map(
				"n",
				"<leader>da",
				"<cmd>DapRerun<cr>",
				{ desc = "Re-run the last debug config", remap = true, silent = true }
			)
			map(
				"n",
				"<leader>db",
				"<cmd>DapToggleBreakpoint<cr>",
				{ desc = "Toggle Breakpoint", remap = true, silent = true }
			)
			map(
				"n",
				"<leader>dc",
				"<cmd>DapRunToCursor<cr>",
				{ desc = "Continues execution to current cursor", remap = true, silent = true }
			)
			map(
				"n",
				"<leader>dr",
				"<cmd>DapRestartFrame<cr>",
				{ desc = "Restart the current frame", remap = true, silent = true }
			)
			map(
				"n",
				"<leader>ds",
				"<cmd>DapStop<cr>",
				{ desc = "Stops the current debug session", remap = true, silent = true }
			)
			map(
				"n",
				"<leader>dx",
				"<cmd>DapTerminate<cr>",
				{ desc = "Terminates the debug session", remap = true, silent = true }
			)
			map("n", "<leader>dt", function()
				require("dapui").float_element("stacks", { position = "center", width = 90, height = 80, enter = true })
			end, { desc = "Stack trace", remap = true, silent = true })
		end,
	},
}
